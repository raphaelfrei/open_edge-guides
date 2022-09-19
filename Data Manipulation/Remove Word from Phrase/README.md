# Remove Word from Phrase
To execute this, the procedure requires two input parametes and returns one.

> INPT - Complete Phrase<br>
> INPT - Phrase (or Word) to Remove<br>
> OTPT - New Phrase (w/o the Word)<br>

## How To Run:

```progress
DEF VAR i_animals AS CHAR NO-UNDO.

RUN OE_Remove-Word.p (INPUT "dogs,cats,birds,apples", INPUT "apples", OUTPUT i_animals).
```
