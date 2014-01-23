# Homework 1

Create an incidence matrix.

## Idea

Create a program that searches "Taming of the shrew" and allows Gray to query terms
in the document. Also must build up an index.

## Requirements

* Strip out bad whitespace and special characters such as `/[^a-z0-9]/i`.
*

## Ideas

Don't forget to grep though, for things that still have bad characters.

```shell
adam@pluto:$ cat tamingoftheshrew | tr [\n\t] '\n' | tr '[:upper:]' '[:lower]' | tr '[:cntrl:]' '\n' | sort -u
your
yourself
yourselves
youth

adam@pluto:$ !! | grep -vi -e "a-z"
```
