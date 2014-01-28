# Homework 1

Create an incidence matrix.

## Objective

* Write a program that parses plain-text ASCII input files and generates a single inverted index output file.
* For any programming task in this course, you are to write an original program with the following requirements:
* The program is written in a language supported on the course development server storm.cs.uni.edu.
* The program compiles as submitted and runs without errors on the course development server storm.cs.uni.edu.
* Your program is required to render a usage statement upon being invoked with too many or too few command-line parameters.
* If written in a scripting language, such as perl, python, ruby, scheme, etc., your program must be written to invoke the
  correct interpreter by appropriate hash-bang directive at the top of the script.
  (As in "#!/usr/bin/python3.3m" to use the specific python3.3m interpreter to run your code)
* The program's logic should be documented using appropriate and constructive comments.  At no time should comments be
  flippant or reflect an unprofessional tone.
* Your program's source code must contain the author's name, the course number, and the assignment designation as comments
  at the beginning of the file, following any obligatory interpreter directives.

## Specific program requirements for Programming Task #1

Your program is to take the name of the input files from the user as command-line arguments.  If the files do
not exist, cannot be read, are not of an appropriate format for parsing, or if the user specifies an incorrect
argument list, your program is to print out an appropriate usage statement.

After successfully verifying that the input files can be opened for reading, your program is to generate
an inverted index list for the tokens in the documents.  Your program's logic will be required to implement
certain subjective heuristics for generation of the dictionary.  Your code should include a description of
the choices made during the parsing of the document's terms within the comments that surround the corresponding
logic in your code.

All dictionary terms are to be lower case and without punctuation.

After generating the inverted index list for the documents, your program is to open an output file.
The output file is to be named `"document.idx"`.

The format of the output file consists of a legend that names the N input document references followed
by the inverted index dictionary and postings list, sorted alphabetically:

    # INPUT DOCUMENT REFERENCE LEGEND[EOL]
    1[tab][input file name #1][EOL]
    2[tab][input file name #2][EOL]
    ...
    N[tab][input file name #N][EOL]
    # INVERTED INDEX RESULTS[EOL}
    [DICTIONARY TERM #1][tab][NUMDOCS1][tab][DOC1#1][tab][DOC1#2][tab[DOC1#3][tab]...[DOC1#N1][EOL]
    [DICTIONARY TERM #2][tab][NUMDOCS2][tab][DOC2#1][tab][DOC2#2][tab[DOC2#3][tab]...[DOC2#N2][EOL]
    [DICTIONARY TERM #3][tab][NUMDOCS3][tab][DOC3#1][tab][DOC3#2][tab[DOC3#3][tab]...[DOC3#N3][EOL]


where

* [DICTIONARY TERM #j] is the j-th term from the document collection's lexigraphically-sorted dictionary
* [tab] is the tab character '\t';
* [NUMDOCSj] is the number of documents in the term's listing.  In the above output illustration,
    term i's [DUMDOCSj] value is always equal to DOCi#j] found at the end of the term's index line.
* [DOCi#j] is the i-th dictionary term's inverted index refefence to the j'th document.
* [EOL] is the end of line character '\n'
* The two headings lines starting with "#" are also required.
* The goal of the above output description is comparable to that shown in Figure 1.4 on page 8 in the textbook.


__Other programmatic considerations__:

Other than printing of the usage statement when warranted, your final program should not print any
information to the console. Discuss freely, code individually. There will be no tolerance for sharing
of code or submission of code content that was not written by the individual student.

__Programming suggestions__:

Treat the task initially as simply a generation of a dictionary listing for a single input file specified
on the command line.  Your output index will simply have 1 reference document and each term's inverted
index will reflect one document occurance, that being document number 1.  This will give you the opportunity
to check the terms that you're generating for the dictionary and help you to generalize to the case where
you have multiple input files.

If you develop on your own resources, periodically push the code up to storm.cs.uni.edu to compile and run.
Don't get into the situation where you're scrambling to adhere to the submission requirements at the last minute.


## In Class Sample Handling of Edge Cases

```shell
adam@pluto:$ cat tamingoftheshrew | tr [\n\t] '\n' | tr '[:upper:]' '[:lower]' | tr '[:cntrl:]' '\n' | sort -u
your
yourself
yourselves
youth

adam@pluto:$ !! | grep -vi -e "a-z"
```
