# Distributed Indexes

Two agorithms: `BSBI` and `SPIMI`.

* Distributed index construction: MapReduce
* Dynamic index construction: how to keep the index up-to-date as the collection changes.

## Types of Distrubted Indexes

* (Blocked sort-based indexing)

Notes: http://nlp.stanford.edu/IR-book/html/htmledition/blocked-sort-based-indexing-1.html

* (Single-pass in-memory indexing)

Notes: http://nlp.stanford.edu/IR-book/html/htmledition/single-pass-in-memory-indexing-1.html

## Hardware Basics

* Many design choices will be impacted by the hardware the program is running on.
* As always, disks are still 10 fold slower than memory.
* Large chunks are always faster than lots of small chunks.
  * Block based reading.
* Servers in IR typically have GB's of RAM, and TB's of Disk.
  * Super computers can have TB's of RAM and PB's of disk (network)
* Fault tolerance is expensive.

## RCV1 Collection

* Reuters document collection from 1995 to 1996
* Shakespear's collection isn't even close to what we need to have real scale.

## Sort-Based index construction

* As we build index, we parse docs one at a time
* The final postings for any term are incomplete until the end.
* Can't keep everything in memory to perform computations.

## Same algorithm for disk?

* Could we just use the same instruction construction algorithm for larger collections on disk?
  * No, find some other way of processing over them.
* Sort all non-positional postings.
  * Each posting has size 12 bytes (4+4+4: termId, docId, termFrequency)
* Define a block to consist of the postings.
  * Could use 10 or 100 for the RCV1 collection.

## SPIMI

* Idea 1:
  * Generate separate dictionaries for each block, don't maintain mappings across blocks.
* Idea 2:
  * Don't sort. Accumulate postings in postings lists as they occur.
* With these two ideas we can generate a complete inverted index for each block.
* At the end we can merge the indexes into one larger index.
* Don't forget about compression too!
