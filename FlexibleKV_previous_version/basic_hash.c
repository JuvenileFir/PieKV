#include "basic_hash.h"

EXTERN_BEGIN

uint16_t calc_tag(uint64_t key_hash) {
  // uint16_t tag = (uint16_t)(key_hash & TAG_MASK);
  uint16_t tag = (uint16_t)((key_hash >> 16) & TAG_MASK);
  if (tag == 0)
    return 1;
  else
    return tag;
}

uint32_t read_version_begin(const page_bucket *bucket UNUSED) {
#ifdef TABLE_CONCURRENT
  while (true) {
    uint32_t v = *(volatile uint32_t *)&bucket->version;
    memory_barrier();
    if ((v & 1U) != 0U) continue;
    return v;
  }
#else
  return 0U;
#endif
}

uint32_t read_version_end(const page_bucket *bucket UNUSED) {
#ifdef TABLE_CONCURRENT
  memory_barrier();
  uint32_t v = *(volatile uint32_t *)&bucket->version;
  return v;
#else
  return 0U;
#endif
}

void write_lock_bucket(page_bucket *bucket UNUSED) {
#ifdef TABLE_CONCURRENT
  // if (table->concurrent_access_mode == 1) {
  //   assert((*(volatile uint32_t *)&bucket->version & 1U) == 0U);
  //   (*(volatile uint32_t *)&bucket->version)++;
  //   memory_barrier();
  // } else if (table->concurrent_access_mode == 2) {
  while (1) {
    uint32_t v = *(volatile uint32_t *)&bucket->version & ~1U;
    uint32_t new_v = v | 1U;
    if (__sync_bool_compare_and_swap((volatile uint32_t *)&bucket->version, v, new_v)) break;
  }
  // }
#endif
}

void write_unlock_bucket(page_bucket *bucket UNUSED) {
#ifdef TABLE_CONCURRENT
  memory_barrier();
  assert((*(volatile uint32_t *)&bucket->version & 1U) == 1U);
  // No need to use atomic add because this thread is the only one writing to version
  (*(volatile uint32_t *)&bucket->version)++;
#endif
}

inline Cbool is_entry_expired(uint64_t index_entry) { return !index_entry; }

Cbool key_eq(const uint8_t *key1, size_t key1_len, const uint8_t *key2, size_t key2_len) {
  return key1_len == key2_len && memcmp8(key1, key2, key1_len);
}

uint16_t try_read_from_bucket(const page_bucket *bucket, const uint16_t tag, const uint8_t *key, uint32_t keylength) {
  uint32_t slot;
  for (slot = 0; slot < ITEMS_PER_BUCKET; slot++) {
    if (TAG(bucket->item_vec[slot]) != tag) continue;

    // we may read garbage values, which do not cause any fatal issue
    log_item *item = (log_item *)log_item_locate(PAGE(bucket->item_vec[slot]), ITEM_OFFSET(bucket->item_vec[slot]));

    // a key comparison reads up to min(source key length and destination key length), which is always safe to do
    if (!key_eq(item->data, ITEMKEY_LENGTH(item->kv_length_vec), key, keylength)) continue;

    return slot;
  }
  return ITEMS_PER_BUCKET;
}

uint16_t try_find_slot(const page_bucket *bucket, const uint16_t tag, const uint64_t offset) {
  uint32_t slot;
  for (slot = 0; slot < ITEMS_PER_BUCKET; slot++) {
    if (ITEM_OFFSET(bucket->item_vec[slot]) != offset || TAG(bucket->item_vec[slot]) != tag) continue;
    return slot;
  }
  return ITEMS_PER_BUCKET;
}

/*
 * try_find_insert_bucket will search the bucket for the given key, and for
 * an empty slot. If the key is found, we store the slot of the key in
 * `slot` and return false. If we find an empty slot, we store its position
 * in `slot` and return true. If no duplicate key is found and no empty slot
 * is found, we store `ITEMS_PER_BUCKET` in `slot` and return true.
 */
Cbool try_find_insert_bucket(const page_bucket *bucket_, uint32_t *slot, const uint16_t tag, const uint8_t *key,
                             uint32_t keylength) {
  uint32_t i;
  *slot = ITEMS_PER_BUCKET;
  for (i = 0; i < ITEMS_PER_BUCKET; ++i) {
    if (!bucket_->item_vec[i]) {
      *slot = i;
    } else {
      if (TAG(bucket_->item_vec[i]) != tag) continue;
      log_item *item = (log_item *)log_item_locate(PAGE(bucket_->item_vec[i]), ITEM_OFFSET(bucket_->item_vec[i]));
      if (key_eq(item->data, ITEMKEY_LENGTH(item->kv_length_vec), key, keylength)) {
        *slot = i;
        return false;
      }
    }
  }
  return true;
}

EXTERN_END
