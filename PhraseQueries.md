# Phrase Queries

* We want to answer a query such as [stanford university] - as a phrase
* Thus _The inventor Stanford Ovshinsky never went to university_ should *not* be a match.
* The concept of a phrase query has proven easily understood by users.
* Only 10% of web queries are phrase queries.
* Consquence for inverted index: it no longer suffices to store docIds in posting lists.
* Two ways of extending the inverted index:
  * biword index
  * positional index

## biword Indexes

* Index every consecutive pair of terms in the text as a phrase.
* "Friends, Romans, Countrymen" -> "friends romans", "romans contrymen"
* Each of these biwords is now a vocab term.
* The query then is transformed into AND's of consecutive pairs.
* Then do a post-filtering of hits to idenfity results that contain all pairs.
* However, they're not often used.
  * More memory / space
  * The reindex cost creates `(n-1)` terms (given `n` terms) to index.
    * Which the index doesn't give a lot of benefit.
  * False positives are generated a fair amount of the time.

## Positional Indexes

* More efficient alternative to biword indexes
* Store the position in the document and a list of positions.

### Example

   Query: "to(1) be(2) or(3) not(4) to(5) be(6)"
   To:
     {1,6: {7, 18, 33, 72, 86, 231} // {(docId, occurences): {positions}}
      2,5: {1, 17, 74, 222, 255},
      ...
     }
   Be:
     {1,2: {17, 25}
      4,5: {17, 191, 430, 434},
      ...
     }

* You can search in these indexes by finding the documents that all terms are in.
  * Then compare the positions based on position.
    * Keep the documents that contain the same ordering of terms as the query
  * Repeat across the documents, in the usual mannor of an inverse index.
* Note, you can use all terms at once and look in the term indexes across the same document
  * This allows for an easy and fast way to break out of a document if one term isn't found.
* Can use this for a proximity search
  * "employment /4 place"
    * Documents that have the term "employment" and then within 4 positions the term "place".
  * Look at the cross products of positions of "employment" and "place".
* Very bad for frequent words, especially stop words.
* Remember, we want the actual matching positions, not just a list of documents.

## Combinations

* Biword indexes and positional indexes can be profitably combined.
* Many biwords are extremely frequent: "Michael Jackson", "Britnet Spears"
* For these biwords, increased speed compared to a pure positional index.
* Combinational scheme: Include frequent biwords as vocab terms in the index.
  * Do all other phrases as positional intersection.
