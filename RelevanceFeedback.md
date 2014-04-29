## Relevance Feedback and query expansion

Two ways of improving recall:

* relevance feedback
* query expansion

An example of a query q: "aircraft" and a document `d` containing "plane" wouldn't be considered.
Even if `d` is the most relevant. However, if we abuse this we could decrease recall and overall
relevance.

### Options for improving recall

* Local: Do a "local", on demand, analysis for a user query
  * Main local method: relevance feedback
    * Find terms that have high similar terms as neighbors.
      * These terms probably mean the same thing most of the time.
* Global: Do a global analysis once to produce a thesaurus
  * Use a thesaurus for query expansion.

### Relevance Feedback

__Basic Idea__

* User issues a query
* User clicks on a few results but comes back to the main page
* Exclude results that are similar to those that are ignored.

### Centroids

* The centroid is the center of mass of a set of points.
* Recall that we represent documents as points in a high-dimensional space.

```
mu(D) = 1/|D| * sum(v(d)) for d in D

Where D is a set of documents and v(d) = d is the vector we use to represent document d.
```

Then we can use the [Rocchio algorithm] to and and adjust our relevance feedback.
(With negative weights set to 0). Typically, we'd pick `a,b,c` to be as follows:

* `a`: `1.0`
* `b`: `0.8`
* `c`: `0.1` (or even `0`)

[Rocchio algorithm]: http://en.wikipedia.org/wiki/Rocchio_algorithm

### Automatic Thesaurus Generation

* Method 1: Two words are similar if they co-occur with similar words
  * car and motorcycle
* Method 2: similar if they occur in a given grammatical releation with the same words
  * eat, prepare, peal, juice (apples and pears)

### Take-Away

* Interactive relevance feedback improves initial retieval results
* Best known model: Rocchio feedback
* Query expansion: improve retrieval results by adding synonyms / related terms
  * Sources for related terms could be:
    * manual process
    * automatic tehesaurus
    * query logs
