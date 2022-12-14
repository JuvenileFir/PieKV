#include "log.hpp"

LogSegment::LogSegment(MemPool *mempool)
{
    mempool_ = mempool;
    for (int i = 0; i < BLOCK_MAX_NUM; i++) {
        log_blocks_[i] = new LogBlock;
    }

    store_stats_ = new StoreStats();
    table_stats_ = new TableStats();
    memset(store_stats_,0,sizeof(StoreStats));
    memset(table_stats_,0,sizeof(TableStats));
    
    
    blocknum_ = 0;
    usingblock_ = 0;
    offset_ = 0;
    round_ = 0;
    avg_item_size = 0;
}

LogSegment::~LogSegment()
{
    for (int i = 0; i < BLOCK_MAX_NUM; i++) {
        delete log_blocks_[i];
    } 
    delete store_stats_;
    delete table_stats_;
}

Log::Log(MemPool *mempool, uint64_t init_block_number)
{
    mempool_ = mempool;
    total_segmentnum_ = THREAD_NUM;
    resizing_pointer_ = 0;
    mask_ = BLOCK_MAX_NUM * mempool->get_block_size() -1;

    for (uint64_t i = 0; i < total_segmentnum_; i++) {
        log_segments_[i] = new LogSegment(mempool);
    }

    for (uint64_t i = 0; i < init_block_number; i++) {
        int new_block_id = mempool->alloc_block();
        if (new_block_id == -1) break;

        total_blocknum_++;
        LogSegment *segment_in_use = log_segments_[i % total_segmentnum_];
        int num = segment_in_use->blocknum_;
        segment_in_use->log_blocks_[num]->block_id = new_block_id;
        segment_in_use->log_blocks_[num]->block_ptr = (uint8_t *)mempool->get_block_ptr(new_block_id);
        segment_in_use->log_blocks_[num]->residue = mempool->get_block_size(); // TODO : flexible block size
        segment_in_use->blocknum_++;
    }
    if (total_blocknum_ < total_segmentnum_) {
        // printf("[ERROR] too few blocks\n");
        exit(-1);
    }
}

Log::~Log()
{
}

/*
expand log segemnt by `numBlockToExpand` blocks:
`tableblocksToMove`: an array for ptrs of tableblocks to move
`numBlockToExpand`: the number of blocks to move
`blocksize`: init logblocks with this blocksize
*/
void Log::Expand(TableBlock **tableblocksToMove, uint64_t numBlockToExpand, size_t blockSize)
{
    for(uint64_t i = 0; i < numBlockToExpand; i++) {
        // first get the segment id to resize
        uint16_t segmentId = get_next_resize_segment_id(0);
        LogSegment *segmentToResize = log_segments_[segmentId];
        uint32_t blockNum = segmentToResize->blocknum_;
        segmentToResize->log_blocks_[blockNum]->block_ptr = (uint8_t *)(tableblocksToMove[i]->block_ptr);
        segmentToResize->log_blocks_[blockNum]->block_id = tableblocksToMove[i]->block_id;
        segmentToResize->log_blocks_[blockNum]->residue = blockSize;

        __sync_fetch_and_add((uint32_t *)&(segmentToResize->blocknum_), 1U);
        __sync_fetch_and_add((uint32_t *)&(total_blocknum_), 1U);

        set_next_resize_segment_id(0);
    }
}

void Log::Shrink(TableBlock **tableblocksToMove, uint64_t numBlockToShrink)
{
    for(uint64_t i = 0; i < numBlockToShrink; i++) {
        // first get the segment id to resize
        uint16_t segmentId = get_next_resize_segment_id(1);
        LogSegment *segmentToResize = log_segments_[segmentId];

        // check if there is free block
        if(segmentToResize->blocknum_ > 1 && segmentToResize->usingblock_ < segmentToResize->blocknum_ - 1) {
            __sync_fetch_and_sub((uint32_t *)&(segmentToResize->blocknum_), 1U);
            __sync_fetch_and_sub((uint32_t *)&(total_blocknum_), 1U);

            tableblocksToMove[i]->block_id = segmentToResize->log_blocks_[segmentToResize->blocknum_]->block_id;
            tableblocksToMove[i]->block_ptr = segmentToResize->log_blocks_[segmentToResize->blocknum_]->block_ptr;
        }
        else {
            numBlockToShrink++;         //  try to find next usable segment
        }
        set_next_resize_segment_id(1);
    }



}

 // expand: 0  shrink: 1
uint16_t Log::get_next_resize_segment_id(int expandOrShrink) {
    if (expandOrShrink == 0) {
        return resizing_pointer_;
    }else if (expandOrShrink == 1) {
        return (resizing_pointer_ + total_segmentnum_ - 1) % total_segmentnum_;
    } else {
        return -1;
    }
}

 // expand: 0  shrink: 1
void Log::set_next_resize_segment_id(int expandOrShrink) 
{
    if (expandOrShrink == 0) {
        resizing_pointer_ = (resizing_pointer_ + 1) % total_segmentnum_;
    }
    if (expandOrShrink == 1) {
        resizing_pointer_ = (resizing_pointer_ + total_segmentnum_ - 1) % total_segmentnum_;
    }
}

void LogSegment::get_log(uint8_t *out_value, uint32_t *in_out_value_length, const uint32_t block_id, uint64_t log_offset)
{
    LogItem *item = locateItem(block_id, log_offset);

    size_t key_length = ITEMKEY_LENGTH(item->kv_length_vec);
    if (key_length > MAX_KEY_LENGTH) key_length = MAX_KEY_LENGTH;

    size_t value_length = ITEMVALUE_LENGTH(item->kv_length_vec);
    if (value_length > MAX_VALUE_LENGTH) value_length = MAX_VALUE_LENGTH;

    memcpy8(out_value, item->data + ROUNDUP8(key_length), value_length);
    *in_out_value_length = value_length;
    
    table_stats_->get_found += 1;
}

int64_t LogSegment::set_log(uint64_t key_hash, const uint8_t *key, uint32_t key_length, const uint8_t *value,uint32_t value_length, uint32_t expire_time)
{
    
    uint64_t new_item_size = (uint32_t)(sizeof(struct LogItem) + ROUNDUP8(key_length) + ROUNDUP8(value_length));
    int64_t item_offset;

    item_offset = AllocItem(new_item_size);
    if (item_offset == -1) {

    #ifdef EXP_LATENCY
        auto end = std::chrono::steady_clock::now();
    #ifdef TRANSITION_ONLY
        if (isTransitionPeriod) {
        printf("SET(false): [time: %lu ns]\n", std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count());
        }
    #else
        printf("SET(false): [time: %lu ns]\n", std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count());
    #endif
    #endif

        table_stats_->set_fail += 1;
        
        return BATCH_FULL;
    } 
    else if (item_offset == -2) {

    #ifdef EXP_LATENCY
        auto end = std::chrono::steady_clock::now();
    #ifdef TRANSITION_ONLY
        if (isTransitionPeriod) {
        printf("SET(false): [time: %lu ns]\n", std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count());
        }
    #else
        printf("SET(false): [time: %lu ns]\n", std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count());
    #endif
    #endif

        table_stats_->set_fail += 1;
        return BATCH_TOO_SMALL;
    }

    uint32_t block_id = log_blocks_[usingblock_]->block_id;

    LogItem *new_item = (LogItem *)locateItem(block_id, item_offset);

    table_stats_->set_success += 1;

    #ifdef STORE_COLLECT_STATS
        store_stats_->actual_used_mem += new_item_size;
    #endif

    new_item->item_size = new_item_size;
    set_item(new_item, key_hash, key, (uint32_t)key_length, value, (uint32_t)value_length, expire_time);
    return block_id;
}

uint32_t LogSegment::get_block_id(uint32_t log_index) {
    return log_blocks_[log_index]->block_id;
}

uint32_t LogSegment::get_log_block_id(uint32_t mem_block_id) {
    for (uint32_t i = 0; i < blocknum_; i++) {
        if (log_blocks_[i]->block_id == mem_block_id)
            return i;
    }
    return -1;
}

void LogSegment::set_item(struct LogItem *item, uint64_t key_hash, const uint8_t *key, uint32_t key_length, const uint8_t *value,uint32_t value_length, uint32_t expire_time) 
{
  assert(key_length <= ITEMKEY_MASK);
  assert(value_length <= ITEMVALUE_MASK);

  item->kv_length_vec = ITEMKV_LENGTH_VEC(key_length, value_length);
  item->key_hash = key_hash;
  item->expire_time = expire_time;
  memcpy8(item->data, key, key_length);
  memcpy8(item->data + ROUNDUP8(key_length), value, value_length);
}

LogItem *LogSegment::locateItem(const uint32_t block_id, uint64_t log_offset)
{
    return mempool_->locate_item(block_id, log_offset);
    // return (LogItem *)(log_blocks_[block_id]->block_ptr + log_offset);
}

int64_t LogSegment::AllocItem(uint64_t item_size) {
    // uint64_t item_size = mem_size;
    //TODO: assert(item_size == ROUNDUP8(item_size));

    int64_t item_offset;
    if (item_size <= BATCH_SIZE) {

        if (log_blocks_[usingblock_]->residue < item_size) {
            // block in use is already filled up 
            // check if there is free block left
            offset_ = 0;
            if (usingblock_ < blocknum_ - 1) {
                // use next block
                usingblock_++;
                if (round_) {
                    store_stats_->actual_used_mem -= mempool_->get_block_size() - log_blocks_[usingblock_]->residue;
                    log_blocks_[usingblock_]->residue = mempool_->get_block_size();
                }   
            } else {
                usingblock_ = 0;
                round_++;
                store_stats_->actual_used_mem -= mempool_->get_block_size() - log_blocks_[0]->residue;
                log_blocks_[0]->residue = mempool_->get_block_size();

                printf("round:%d\n",round_);
                // return -1;
            }
        }
        item_offset = offset_;
        offset_ += item_size;
        
        log_blocks_[usingblock_]->residue -= item_size;
        avg_item_size = 
            (avg_item_size * table_stats_->set_success + item_size) * 1.0 /
            (table_stats_->set_success + 1);
        return item_offset;
    } else {
        // TODO: implement a function `big_set`
        return -2;  // batch_too_small
    }
}

uint64_t LogSegment::get_tail() {
    return usingblock_ * mempool_->get_block_size() + offset_;
}

void LogSegment::print_table_stats() {
  printf("count:                  %10zu\n", table_stats_->count);
  printf("set_nooverwrite:        %10zu | ", table_stats_->set_nooverwrite);
  printf("set_success:            %10zu | ", table_stats_->set_success);
  printf("set_fail:               %10zu\n", table_stats_->set_fail);
  printf("set_inplace:            %10zu | ", table_stats_->set_inplace);
  printf("set_evicted:            %10zu\n", table_stats_->set_evicted);
  printf("get_found:              %10zu | ", table_stats_->get_found);
  printf("get_notfound:           %10zu\n", table_stats_->get_notfound);
  printf("test_found:             %10zu | ", table_stats_->test_found);
  printf("test_notfound:          %10zu\n", table_stats_->test_notfound);
  printf("cleanup:                %10zu\n", table_stats_->cleanup);
  printf("move_to_head_performed: %10zu | ", table_stats_->move_to_head_performed);
  printf("move_to_head_skipped:   %10zu | ", table_stats_->move_to_head_skipped);
  printf("move_to_head_failed:    %10zu\n", table_stats_->move_to_head_failed);

}
