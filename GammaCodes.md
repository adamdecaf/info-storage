# Gamma Coding

* You can get more compression with another type of variable length encoding: bitlevel code
* Gamma code is the best known of these
* First, we need unary code to be able to introduce gamma code.
* Unary code:
  * Represent n as n 1s with a final 0
  * Unary code for 3 is 1110
  * Unary code for 40 is: 11111111111111111111111111111111111111110

## Merging Strategies

* Represent a gap G as a pair of length and offset.
* Offset is the gap in binary, with the leading bit chopped off.
* For example, 13 -> 1101 -> 101 = offset
* Length is the length of offset
  * `G = (trimmed binary representation)`
  * length of offset i `floor(lb(G))` bits
  * length of length is `floor(lb(G)) + 1` bits
  * So the length of the entire code is `2 * floor(lb(G)) + 1`
  * gamma codes are always of off length.
  * Gamma codes are within a factor of 2 of the optimal encoding length `lb(G)`
    * assuming the freq of a gap G is porportional to `lb(G)`
* For 13 (offset 101), this is 3
* Encode length in unary code: 1110.
* Gamma code of 13 is the concatenation of length and offset: 1110101
* Gamma codes are independent of the distribution of gaps.
  * And independent of the distribution.
  * They're prefix-free and parameter-free.

```
number | unary | length | offset | gamma-code
4      | 11110 | 110    | 00     | 110,00
1025   |  ...  | ....   | ...    | 11111111110,0000000001
```
