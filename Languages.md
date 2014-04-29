## Language Models

* LM = Language Model
* View the document as a generative model that generates the query
* How to
  * Define the percise generative model we want to use
  * Estimate parameters / smooth to avoid zeros

__What is a language model?__

We can view a finite state automaton as a deterministic language model.

```
        ----->   ------
--> I          || wish || (final state)
        <-----   ------
```

Using a one-state probabilistic finite-state automaton - a unigram language model -
and the state emission distribution for it's state q_1.

Given the probabilities that the automaton would generate individual strings we can
find the probabilitiy that a longer string is generated is found by the product.

Always add a STOP on the end, it's a constant probability. (It's the probability that
you don't stop after the first term.)

```
q_1 = p_i * p_(i+1) * p_(i+2) * ... * p_(i+k)
```
