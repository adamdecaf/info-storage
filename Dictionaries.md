# Dictonaries

The dictionary is the data structure for storing the term vocab.

* Term Vocab: The Data
* Dictonary: Data structure used for storing term vocab.

## As Array of fixed-width entries

* For each term, we need to store a couple of items:
  * Document Frequency
  * Pointer to postings list
* Assume for the time being, we can store this information in a fixed-length entry.

    |---------------------------------|
    | term  | doc freq | posting list |
    |       |          |              |
    |       |          |              |
    |---------------------------------|
     20 bytes  4 bytes    4 bytes

## Speed

* Two main classes of data structures: hashes and trees.
* Some IR systems use hashes, some use trees.
  * Is there a fixed number of terms?
    * Yes, then hash tables could be the right way to go.
    * No, probably should use trees.
  * Is there a way to order the structure based on query keyword frequency?
  * How many terms are we likely to have?

## Hashes

* Each vocab term is hashed to some value for storing.
  * Could be an int if you're storing them in an array.
* Fixed cost, fixed output size
* Pros:
  * Faster than tree lookups. (Constant)
* Cons:
  * Minor variants will widly change hash output
  * No prefix search
  * Need to keep rehashing if the vocab keeps growing

## Trees

* Trees solve the prefix problem (find all terms starting with "automat")
* Simplest tree: binary tree
* Slightly slower search `O(log M)` where `M` is the size of the vocab.
  * `O(log M)` only holds for _balanced_ trees.
* B-tree mitigate the rebalancing problem.
