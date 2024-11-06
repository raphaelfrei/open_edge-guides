/* ------------------------------------------------------------------------
    File        : Func-File-DeEncrypt.p
    Purpose     : File encryption and decryption

    Syntax      : Progress 4GL

    Description : Encrypt and Decrypt files - Works with any kind of files

    Author(s)   : Raphael Frei
    Created     : 06.Nov.2024
    Notes       : 
------------------------------------------------------------------------ */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ----- INPUT-OUTPUT PARAMETERS ----- */

DEFINE INPUT  PARAMETER iMode       AS INTEGER   NO-UNDO.
// 1 - Encrypt
// 2 - Decrypt

DEFINE INPUT  PARAMETER cInputFile  AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER cOutputFile AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER lStatus     AS LOGICAL   NO-UNDO.
DEFINE OUTPUT PARAMETER cStatus     AS CHARACTER NO-UNDO.
    
/* ----- MAIN-BLOCK ----- */

DO:

    IF SEARCH(cInputFile) = ? THEN DO:

        ASSIGN lStatus = FALSE
               cStatus = "INPUT FILE NOT EXISTS".

        RETURN.

    END.

    IF iMode = 1 THEN DO:

        RUN P-ENCRYPT-FILE(INPUT cInputFile, INPUT cOutputFile).

    END. ELSE IF iMode = 2 THEN DO:

        RUN P-DECRYPT-FILE(INPUT cInputFile, INPUT cOutputFile, OUTPUT lStatus, OUTPUT cStatus).

        IF NOT lStatus THEN
            RETURN.

    END. ELSE DO:

        ASSIGN lStatus = FALSE
               cStatus = "MODE INVALID".

    END.

    ASSIGN lStatus = TRUE
           cStatus = IF iMode = 1 THEN "FILE ENCRYPTED" ELSE "FILE DECRYPTED".

    RETURN.

END.

/* ----- PROCEDURES ----- */

PROCEDURE P-ENCRYPT-FILE:

    DEFINE INPUT PARAMETER cFileArc AS CHARACTER NO-UNDO.
    DEFINE INPUT PARAMETER cOutFile AS CHARACTER NO-UNDO.

    DEFINE VARIABLE mFile     AS MEMPTR   NO-UNDO.
    DEFINE VARIABLE lcFile    AS LONGCHAR NO-UNDO.
    DEFINE VARIABLE cFileHash AS CHARACTER   NO-UNDO.

    COPY-LOB FROM FILE cFileArc TO mFile.
    ASSIGN lcFile    = BASE64-ENCODE(mFile)
           cFileHash = STRING(MD5-DIGEST(lcFile)).
    COPY-LOB FROM lcFile TO FILE cOutFile.

    OUTPUT TO VALUE(cOutFile) APPEND.
        PUT UNFORMATTED cFileHash + STRING(LENGTH(cFileHash) + 6, "999999").
    OUTPUT CLOSE.

END.

PROCEDURE P-DECRYPT-FILE:

    DEFINE INPUT  PARAMETER cFileEnc AS CHARACTER NO-UNDO.
    DEFINE INPUT  PARAMETER cFileDec AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER lIsValid AS LOGICAL   NO-UNDO.
    DEFINE OUTPUT PARAMETER cError   AS CHARACTER NO-UNDO.

    DEFINE VARIABLE mFile     AS MEMPTR      NO-UNDO.
    DEFINE VARIABLE lcFile    AS LONGCHAR    NO-UNDO.
    DEFINE VARIABLE lcContent AS LONGCHAR    NO-UNDO.
    DEFINE VARIABLE cHashFile AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE cFileHash AS CHARACTER   NO-UNDO.
    DEFINE VARIABLE iHashSize AS INTEGER     NO-UNDO.

    COPY-LOB FROM FILE cFileEnc TO lcFile.

    ASSIGN iHashSize = INTEGER(SUBSTRING(lcFile, LENGTH(lcFile) - 5)) NO-ERROR.

    IF iHashSize = 0 THEN DO:

        ASSIGN lIsValid = FALSE
               cError   = "HASH ERROR".

        RETURN.

    END.

    ASSIGN lcContent = SUBSTRING(lcFile, 1, LENGTH(lcFile) - iHashSize)
           cHashFile = SUBSTRING(lcFile, LENGTH(lcFile) - iHashSize + 1, iHashSize - 6).

    ASSIGN cFileHash = STRING(MD5-DIGEST(lcContent)).

    IF cFileHash <> cHashFile THEN DO:

        ASSIGN lIsValid = FALSE
               cError   = "HASH DOES NOT MATCH".

        RETURN.

    END.

    ASSIGN mFile = BASE64-DECODE(lcContent).
    COPY-LOB FROM mFile TO FILE cFileDec.

    ASSIGN lIsValid = TRUE.

END.

CATCH err AS Progress.Lang.Error:
    ASSIGN lStatus = FALSE
           cStatus = "FILE INVALID".
END.
