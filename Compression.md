# Compression

* Lets us use less disk, saves money.
* Keep more stuff in memory. (Increase speed)
* Reading compressed data from disk and uncompressing is faster than reading uncompressed data from the disk.

## Lossy vs Lossless

* Lossy compression: Discard some information
  * Case-folding and stemming are lossy algorithms.
* Lossless compression: All information is preserved.

## How big is the term vocab?

* That is, how many distinct words are there?
* Can we assume there is an upper bound?
* Not really: At least 70^20 (on the order of 10^37) different words of length 20.
* The vocab will keep growing with collection size.
* Heaps law: `M = kT^b`
  * `M`: Size of the vocab
  * `T` is the number of tokens in the collection.
  * Typical values for the parameters k and b are: 30 <= k <= 100 and b = 1/2
* Heaps law is linear in log-log space.

## Excercise

* What if we were to store spelling corrections? We'd find that Heaps law would start to underestimate our vocab size.
* Compute the vocab size M
  * 3000 diff terms in first 10,000 tokens and 30,000 diff terms in first 1,000,000 tokens
    * `3000 = k(10000)^b; 30000 = k(1000000)^b`

# Zipf's Law

* Now we have characterized the growth of the vocab in collections.
* We also want to calculate how many frequent vs infrequent terms we should expect in a collection.
* In natural language, there are a few very frequent terms and very many rare terms.
* The ith most frequent term has frequency cf_i proportional to 1/i.
* cf_i is collection freq
