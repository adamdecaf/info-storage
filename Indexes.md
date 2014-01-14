# Indexes

## Term-document incident matrix

```
           Anthony and      Julius Cesar        The Tempest     Hamlet
           Cleopatra
Anothony      1                   1                  0            0
Brutus        1                   1                  0            0
(etc.)
```

To find if a result is within a document, just lookup the (M,N) pair in the matrix.
If we wanted to find the documents that contain two people but not someone else it
could be something like:

```
(Brutus)    and   (Cesar)  but not Calpurnia
110100            110111           100000 (Need to find the compliment)
= 110100 and 110111 and 011111 = 010100
```

Consider `10^6` documents. Each with `10^3` tokens, ergo `10^9` total tokens. Not
even close to a large collection.

* How large is this matrix?
* How long will computations take?
* How much space will it take to store all the documents?

Conclusions

* On average 6 bytes per token, `6 * 10^9 = 6GB`
* Assume there are M = 500,000 distinct terms in the collection.
* `M = 500,00 * 10^6 = 5 * 10^11` (half a trillion 0s and 1s)
* The matrix has no more than a billion 1s.
 * `10^3` (distinct tokens per document) * `10^6` (documents) = `10^9` 1s.

Only store the 1s in a linked list tied to each term.

```
brutus -> [1,2,4,11]
caesar -> [1,2,4,5,6]
calpurnia -> [2,31,54,101]
```
