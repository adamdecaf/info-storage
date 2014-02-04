# Spelling Correction

* Fix the queries and documents we index or search with.

## k-gram indexes for spelling correction

* Enumerate all k-grams in the query term.
  * bigram index: bordroom
    * bigrams: bo, or, rd, ro, oo, om
    * With a k-gram index try to retrieve the correct words that match query term k-grams
    * Threshold by number of matching k-grams

## Context-sensitive spelling correction

* How can we correct form in the phrase: "an asteroid that fell form the sky"?
* Ideas:
  * `hit-based` spelling correction
    * Retrieve "correct" terms close to each query term.
    * for `flew form munich`: `flea` for `flew`, `from` for `form`, `munch` for `munich`
    * Then try all possible resulting phrases as queries with one "fixed" word at a time.
    * Queries
      * `flea form munich`
      * `flew from munich` <-- probably the best query/correction.
      * `flew form munch`
