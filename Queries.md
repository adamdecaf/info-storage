## Queries

The input from the user to find documents from the index.

## Corecting Queries

* First: isolated spelling correction
* Premise 1: There is a list of "correct words" from which the correct spellings come.
* Premise 2: We have a way of computing the distance between a mispelled word and a correct word.
  * [Levenshtein Distance] is often the goto algorithm.
* Simple spelling correction algorithm, return the correct word that has the smallest distance to the mispelled word.
* For the list of correct words, we can use the vocab of all words that occur in our collection.
  * We may want to use Webster or it'll use a specialized IR dictionary. (Containing medical terms more likely, etc.)

### Distance between misspelled word and correct word.

* [Levenshtein Distance]: Basic opertations are: insert, delete, replace [, or leave it alone].
* [Damerau–Levenshtein]: Adds transposition as a fourth possible operation.

[Levenshtein Distance]: http://en.wikipedia.org/wiki/Levenshtein_distance
[Damerau–Levenshtein]: http://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance

### Weighted Edit Distance

* If we assume that queries are on a QWERTY keyboard, we could introduce a metric for that keyboard layout
  * Edit distances based on the locality of keys.
  * However, we now need that weight matrix.
