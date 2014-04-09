# Vector Spaces and modeling.

## Storing things in matrixe

* Binary Incidence Matrixes suck
* Count Incidence Matrixes suck

## Weight Matrix

* Each doc is now represented as a real-valued vector of tf-idf weights that exist in R^|V| space.
* Terms are axis of the space. Documents are points (or vectors) in the space.
* Each vector is very sparse though - most entrys are zero.

### Key Ideas

* Treat the queries as the same dimensional vectors also.
* Rank docs according to their priximity to the query.
* Get away from boolean queries, we're okay with inbetweenness.

## How do we formalize vector space similarity?

* First cut: (negative) distance between two points.
  * (= distance between the end points of two vectors)
  * Euclidian Distance is bad though...
* Find proximity via their angles.
  * Use the inverse cosine of the two vectors.
  * In higher dimensions, find their dot product with normalized vectors.
  * As a result, longer docs and shorter docs have weights on the same order of magniude.
  * An effect of a doc d and it's self concatination d' have idential vectors.

```
||x||_2 = sqrt { Σi x_i * x_i }

cos(q, d) = sim(q, d) = (q (dot prod) d) / |q||d|
```

* However, since we store normalized vectors, we simplify our equations.
  * To not include the division by vector magnitudes.
