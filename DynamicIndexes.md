## Dynamic Indexes

### Simple Approach

* Maintain big index on disk
* New docs go into small aux index in memory.
* Search across both, merge results
* Periodically, merge aux indexes into big index.
* Deletions:
  * Invalidation bit

### Logarithmic Merge

* Merging amortizes the cost of merging indexes over time.
  * Users see a smaller effect on response times.
* Maintain a series of indexes, each twice as large as the previous one.
* Keep smallest in memory
* Larger ones go on disk.
