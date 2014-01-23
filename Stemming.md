# Stemming

    Crude heuristic process that **chops off the ends of words** in the hope of achieving what
    "principled" lemmaatization attempts to do with a lot of linguistic knowledge.

* Language dependent
* Often inflectional and derivational
* Example for derivational: automate, automatic, automation, automaton, all reduce to automate.
* Most common algorithm is *Porters Algorithm*.
* It's good when the data and query have very generalized terms

## Porter's Algorithm

* Most common algorithm for stemming English.
* Results suggest that itis at least as good as other stemming options.
* Conecntions + 5 phases of reductions.
* Phases are applied sequentially
* Each phase consists of a set of commands
  * Sample command: Delete final ement if what remains is longer than 1 character.
    * replacement -> replac
    * cement -> cement
  * Sample Command: Of the rules in a compound command, select the one that applies to the longest suffix.

### Example

    Rule          Example
    SSES -> SS    caresses -> caress
    IES  -> I     ponies   -> poni
    SS   -> SS    caresses -> caress
    S    ->       cats     -> cat

## Other Stemmers

* Lovins Stemmer (1970's)
* Paice Stemmer (1980's)
