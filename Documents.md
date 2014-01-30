# Documents

Collections of symbols that make sense to humans. (But, not really. It gets more complex.)

## Parsing

We need to deal with format and language of each document. Each of the following
is a classification problem.

* What format is it in? pdf, docx, xls, html?
* What language is it in?
* What character set is in use?
* Use heuristics. (Marking characters at the start, character set frequency)

## Format / Language Complications

* Might have a french email with a Spanish attachment.
* What is the document unit for indexing? (Email only? Email and Document? only Attachment?)

## Terms

* Word - A delimited string of characters as it appears in the text. (Normally, what about Chinese?)
* Term - A "normalized" word (case, morphology, spelling, etc) an equivalence class of words.
* Token - An instance of a word or term occurring in a document.
* Type - The same as a term in most cases: an equivalence class of tokens.

## Normalization

* Need to normalize words in indexed text as well as query term(s) into the same form.
  * e.g. We want to match U.S.A. to USA to usa to U S A
* We commonly implicitly define equivalence classes of terms.
* Alternatively: Do asymmetric expansion
  * window -> window, windows
  * windows -> Windows, windows, Microsoft Windows
  * Windows -> Windows, Microsoft Windows
    * Assuming that the user is "lazy", and if they put extra work in then match it exclusively.

## Inverted Index Creation

* Friends, Romans, Countrymen
  * -> `friend`, `roman`, `countryman`

## Tokenization Problems

* Hewlett-Packard
* State-of-the-art (one word? one term? four terms?)
* co-education (normalized to coeducation?)
* data base (db? database?)
* Los Angeles-based company
* Cheap San Fransisco-Los Angeles fares
* New York vs York University

## Numbers / Dates

* 3/20/91
* 20/3/91
  * Use heuristics again to try and figure out the date.
* Mar 20, 1991
* B-52 (Plane, Band)
* 100.2.86.144
* (800) 234-2333
* 800.234.2333

## Other Languages

* Chinese has no white space. Many languages don't.
* Many languages don't use letters, but symbols.
* Many languages aren't read left to right.
  * Some even change directions when they encounter a language that reads in the opposite direction.
* Many languages don't use arabic/hindu numbers.
* Combinations of symbols can mean one term or a combination of other terms.
  * Segmentation difficulties
* Some texts have multiple alaphabets within the one block of text.
* Some languages and words have accents and other inflection symbols and annotations.

## Back to English

* In case folding...
  * Reduce all letters to lowercase.
    * Even if some terms would only have meaning or duplicate meanings.
    * Since a lot of times users will only use lowercase.
  * Then you can go back and handle the one-offs (or not lowercase them first).

## Stop words

* Words that are very common and don't help with queries or indexing
* Examples: a, an, and, are, as, on, that, its, of, were, was, with, he, in, etc..
* Sometimes you need them, "King of Denmark"
* Most web search engines will index with stop words, to use in fallback queries.

## Lemmatization

* Reduce inflectional / variant forms to base form
  * Example: am, are, is -> be
  * Example: car, cars, car's, cars' -> car
* Lemmatization implies doing "proper" reduction to dictionary headword form (the lemma).
* Inflectional morphology (cutting -> cut) vs derivation morphology (destruction -> destroy).

## Correcting Documents

* We're not interested in ineractive spelling correction.
* In IR, we use document correction largely for OCR'ed documents.
* In general, don't change the documents.
