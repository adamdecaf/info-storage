# Skip Pointers

Recall:

    BRUTUS    -> 1 -> 2 -> 4 -> 11 -> 31 -> 45 -> 173 -> 174
    CALPURNIA -> 2 -> 31 -> 54 -> 101
    Intersection -> 2 -> 31

## Definitions

* Skip pointers allow us to skip posting that will not figure in the search results.
  * This makes intersections postings lists more efficient
* Some postings lists contain several million entries
  * So efficiency can be an issue even in basic intersection is linear.

## Basic Idea

              ____   ______
    BRUTUS   /    \ /      \
            2 4 8 34 35 64 128
             ______   ________
            /      \ /        \
    CAESAR  1 2 3 5 8 17 21 31 75

This however assumes the keys for documents contains an ordering, so this allows you to
just jump over documents that you know the other term isn't part of.

On average, the best position for skip-pointers is `sqrt(p)` for `p` documents. `p` is
deterined when you have scanned all the documents and are making the index.

## Where do we place skips?

* Tradeoff: Number of items skipped vs freq skip can be taken.
* More skips: Close skips lets us skip a lot, but not very far.
* Less skips: Less usage of skips, but can skip a lot of documents.
* Simple heuristic: `sqrt(p)` for `p` documents. (assumingly evenly distributed terms)
* Also, this is __really__ only easy/useful when you have a static set of documents.
