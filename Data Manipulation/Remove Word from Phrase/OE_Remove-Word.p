/* ------------------------------------------------------------------------

                            Raphael Frei - 2022

                          REMOVE WORD FROM PHRASE
                                GUIDE SHEET

------------------------------------------------------------------------ */

DEF VAR ii AS INT NO-UNDO.
                                   
DEF INPUT  PARAM mainPhrase AS CHAR NO-UNDO.
DEF INPUT  PARAM wordToRem  AS CHAR NO-UNDO.
DEF OUTPUT PARAM finalWord  AS CHAR NO-UNDO.

ii = 0.
    
DO ii = 1 TO LENGTH(mainPhrase):
    IF SUBSTRING(mainPhrase, ii, LENGTH(STRING(wordToRem))) 
        = STRING(wordToRem) THEN DO:

        mainPhrase = SUBSTRING(mainPhrase, 1, (ii - 1)) 
            + SUBSTRING(mainPhrase, 1 + ii + LENGTH(STRING(wordToRem))).

    END.
END.

finalWord = mainPhrase.
RETURN.
