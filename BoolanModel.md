# Boolean Model

Searching a set of documents that contain "Cesar" and "Brute". In general this means:

```
  Q = [w1, w2, w3, ... wn]
```

Google does something similar for this by default as its first check. They may ignore
certain `w_i` strings if they're common or misspelled (and sometimes substitute them)
for others. On very large search tokens many of the tokens will be ignored.
