/* ******************************************************************** *
*                                                                       *
*                           Raphael Frei - 2024                         *
*                                                                       *
*                  Get List with all subdir from folder                 *
*                                                                       *
* ********************************************************************* */

/* ----- TEMP-TABLE ----- */
DEFINE TEMP-TABLE tt-dir
        FIELD tt-dir  AS CHARACTER
        FIELD tt-used AS LOGICAL.

/* ----- MAIN-BLOCK ----- */

DO:
    RUN FillTempTableDir(INPUT "J:\src").

    MESSAGE "Search complete."
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

    FOR EACH tt-dir NO-LOCK:
        MESSAGE tt-dir.tt-dir
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    END.
END.

/* ----- PROCEDURES ----- */

PROCEDURE FillTempTableDir:
    DEFINE INPUT PARAMETER cFileRootDir AS CHARACTER NO-UNDO.
    
    FILE-INFO:FILE-NAME = cFileRootDir.

    IF FILE-INFO:FILE-TYPE <> "DRW" OR FILE-INFO:FULL-PATHNAME EQ ? THEN DO:
        MESSAGE "The informed directory does not exists - '" cFileRootDir "'."
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

        RETURN.
    END.

    DEFINE VARIABLE cCommand AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cPath    AS CHARACTER NO-UNDO.

    FIND FIRST tt-dir WHERE tt-dir = cFileRootDir NO-LOCK NO-ERROR.
    
    IF NOT AVAIL tt-dir THEN DO:

        CREATE tt-dir.
        ASSIGN tt-dir.tt-dir  = cFileRootDir
               tt-dir.tt-used = NO.

    END.
    
    ASSIGN cCommand = "CMD.EXE /C DIR ~"" + cFileRootDir + "~" /A:D /B".

    INPUT THROUGH VALUE(cCommand) NO-ECHO.
    
    REPEAT:
        IMPORT UNFORMATTED cPath.
    
        RUN FillTempTableDir(INPUT STRING(cFileRootDir + "\" + cPath)).
    END.

END PROCEDURE.
