#pragma once

#include "shm.h"

#include <stdint.h>

#define TAG_MASK (((uint64_t)1 << 15) - 1)
#define TAG(item_vec) ((item_vec) >> 48)

#define PAGE_MASK (0x0000fffff8000000UL)
#define PAGE(item_vec) ((item_vec & PAGE_MASK) >> 27)
#define SET_PAGE(entry, pageNumber) (((uint64_t)entry) | ((uint64_t)pageNumber) << 27)

#define ITEM_OFFSET_MASK (((uint64_t)1 << 27) - 1)
#define ITEM_OFFSET(item_vec) ((item_vec)&ITEM_OFFSET_MASK)

#define ITEM_VEC(tag, pageNumber, item_offset) \
  (((uint64_t)(tag) << 48) | ((uint64_t)(pageNumber) << 27) | (uint64_t)(item_offset))

EXTERN_BEGIN

typedef enum cuckooStatus {
  ok,
  failure,
  failure_key_not_found,
  failure_key_duplicated,
  failure_table_full,
  failure_under_expansion,
} cuckooStatus;

typedef enum ITEM_RESULT {
  ITEM_OK = 0,
  ITEM_ERROR,
  ITEM_FULL,
  ITEM_EXIST,
  ITEM_NOT_FOUND,
  ITEM_PARTIAL_VALUE,
  ITEM_NOT_PROCESSED,
} ITEM_RESULT;

typedef struct tablePosition {
  uint32_t bucket;
  uint32_t slot;
  enum cuckooStatus cuckoostatus;
} tablePosition;

typedef struct page_bucket {
  uint32_t version;  // XXX: Is uint32_t wide enough?
#ifdef ITEMS_PER_BUCKET_7
#define bitmap uint8_t
  uint8_t occupy_bitmap;
  uint8_t unused1;//加锁
  uint16_t unused2;//补位
#elif defined ITEMS_PER_BUCKET_15
#define bitmap uint16_t
  uint16_t occupy_bitmap;
  uint16_t unused1;
#else
  uint32_t unused;  // TODO: bitmap for early pruning.
#endif
  uint64_t item_vec[ITEMS_PER_BUCKET];

  // 64: key hash
  // 16: tag (1-base)
  // 48: item offset
  // item == 0: empty item
} page_bucket ALIGNED(64);

uint16_t calc_tag(uint64_t key_hash);

uint32_t read_version_begin(const page_bucket *bucket UNUSED);

uint32_t read_version_end(const page_bucket *bucket UNUSED);

void write_lock_bucket(page_bucket *bucket UNUSED);

void write_unlock_bucket(page_bucket *bucket UNUSED);

Cbool is_entry_expired(uint64_t index_entry);

Cbool key_eq(const uint8_t *key1, size_t key1_len, const uint8_t *key2, size_t key2_len);

uint16_t try_read_from_bucket(const page_bucket *bucket, const uint16_t tag, const uint8_t *key, uint32_t keylength);

uint16_t try_find_slot(const page_bucket *bucket, const uint16_t tag, const uint64_t offset);

Cbool try_find_insert_bucket(const page_bucket *bucket_, uint32_t *slot, const uint16_t tag, const uint8_t *key,
                             uint32_t keylength);

EXTERN_END
