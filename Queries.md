## Queries

The input from the user to find documents from the index.

## Corecting Queries

* First: isolated spelling correction
* Premise 1: There is a list of "correct words" from which the correct spellings come.
* Premise 2: We have a way of computing the distance between a mispelled word and a correct word.
  * [Levenshtein Distance] is often the goto algo.
* Simple spelling correction algorithm, return the correct word that has the smallest distance to the mispelled word.
* For the list of correct words, we can use the vocab of all words that occur in our collection.

[Levenshtein Distance]: http://en.wikipedia.org/wiki/Levenshtein_distance
