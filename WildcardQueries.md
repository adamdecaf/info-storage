# Wildcard Queries

* `mon*`: Find all documents containing any term beginning with `mon`.
  * Easy with B-tree dictionary: retrieve all terms t in the range `mon <= t < moo`.
* `*mon`: Find all docs containing any term ending with `mon`.
  * Uhh, store another tree with the reverse of all the terms.
  * Then it's just `nom <= t < non`
* `m*nchen`
  * Intersect the trees, go forwards and backwards.
  * Expensive.

# Permuterm index

Rotate every wildcard query so that the `*` occurs at the end.

* For a term like `Hello`, add `hello$`, `ello$h`, `llo$he`, etc.. adding the `$` as an end of word marker.
  * Then search the B-tree with the end of word marker.
* For a term of `n` characters, we store `n+1` terms
* How to handle wildcards:
  * For `x` look up `x$`
  * For `X*` look up `$x*`
  * For `*x` look up `x$*`
  * For `*x*` lookup `x*`
  * For `x*y` look up `y$x*`
* It is a single tree that holds every permutation of the word in the tree.
* However, permuterm trees more than _quadruples_ the size of the original size.

## K-gram indexes

Take every word you have, and split it up into k-character sequences.

* More space efficient than permuterm index
* 2-grams are called bigrams.

### Example

from "April is the cruelest month" we get the bigrams, with `$` as a end of word separator

```
$a ap pr ri il l$ $i is s$ ... mo on nt h$
```

Then, we'd get a 3-gram inverted index of:

```
etr -> [beetroot] -> [metric] -> [petrify]
```

## Back to indexes

* We now have two different types of inverted indexes.
* Query `mon*` can now be ran as: `$m and mo and on`
* Gets us all the terms with the prefix mon..
  * ...but also mmany false positives like `moon`.
  * Have to post-filter these false positives out.
* k-gram vs permuterm
  * k-gram index is more space efficient
  * permuterm index doesn't require post-filtering.

## Edit Distance (Spelling corrections)

* Two principal uses
  * Correcting documents being indexed
  * Correcting user queries
* Isolated word spelling correction
  * Check each word on it's own misspelling
  * Will not catch typos resulting in correctly spelled words: `an asteroid that fell form the sky`
* Context-sensitive spelling correction
  * Look at surrounding words
  * Can correct form/from error above.
