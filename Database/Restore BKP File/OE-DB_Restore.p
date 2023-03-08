/* **********************************************************************
*                                                                       *
*                                                                       *
*                           Raphael Frei - 2023                         *
*                                                                       *
*                      Restore Backup from BKP File                     *   
*                                                                       *
*                                                                       *
*************************************************************************
*                                                                       *
*       COPYRIGHT (C) 2023 - RAPHAEL FREI                               *
*                                                                       *
*       PROGRAM: OE-DB_Restore.p                                        *
*                                                                       *
*       PROGRAM SUMMARY:                                                *
*           Restore .BKP file from database                             *
*                                                                       *
*       INPUT/OUTPUT PARAMETERS:                                        *
*           cBackupLocation   - CHAR - .BKP file path                   *
*           cDatabaseLocation - CHAR - Database folder location         *
*           cDatabaseName     - CHAR - Database name                    *
*           cLogLocation      - CHAR - Output log path (with file)      *
*                                                                       *
*                                                                       *
*       VERSIONS:                                                       *
*           v1.00 - 08/03/23: Document Creation                         *
*                                                                       *
*                                                                       *
********************************************************************** */

/* RUN OE-DB_Restore.p (INPUT "E:\Backup", INPUT "E:\LIVE\DB", INPUT "sports2000", INPUT "C:\temp\restore_sports2000.log") */

/* ----- INPUT PARAMETERS ----- */

DEFINE INPUT PARAM cBackupLocation   AS CHAR NO-UNDO.
DEFINE INPUT PARAM cDatabaseLocation AS CHAR NO-UNDO.
DEFINE INPUT PARAM cDatabaseName     AS CHAR NO-UNDO.
DEFINE INPUT PARAM cLogLocation      AS CHAR NO-UNDO.

/* ----- MAIN BLOCK ----- */

RUN RemoveLastBackslash(INPUT-OUTPUT cBackupLocation).
RUN RemoveLastBackslash(INPUT-OUTPUT cDatabaseLocation).

RUN CheckAndStopRunningDB.

RUN CopyFilesFromFolder(INPUT cBackupLocation, INPUT cDatabaseLocation, INPUT "*.st", INPUT cLogLocation).
RUN CopyFilesFromFolder(INPUT cBackupLocation, INPUT cDatabaseLocation, INPUT "*.bkp", INPUT cLogLocation).

DOS SILENT VALUE("CALL prorest " + cDatabaseLocation + "\" + cDatabaseName + " " + cBackupLocation + "\" + cDatabaseName + ".bkp >> " + cLogLocation).

QUIT.

/* ----- PROCEDURES ----- */

PROCEDURE CheckAndStopRunningDB:

    IF SEARCH(cDatabaseLocation + "\" + cDatabaseName + ".lk") <> ? THEN
        DOS SILENT VALUE("call proshut " + cDatabaseLocation + "\" + cDatabaseName + " -by >> cLogLocation").

END.

// -----

PROCEDURE RemoveLastBackslash:

    DEFINE INPUT-OUTPUT PARAM cFilePath AS CHAR NO-UNDO.

    IF SUBSTRING(cFilePath, LENGTH(cFilePath) - 1) = "\" THEN 
        ASSIGN cFilePath = SUBSTRING(cFilePath, 1, LENGTH(cFilePath) - 1).

    RETURN.

END.

// -----

PROCEDURE CopyFilesFromFolder:

    DEFINE INPUT PARAM cFolderPath    AS CHAR NO-UNDO.
    DEFINE INPUT PARAM cCopyToPath    AS CHAR NO-UNDO.
    DEFINE INPUT PARAM cFileExtension AS CHAR NO-UNDO.
    DEFINE INPUT PARAM cLogOutput     AS CHAR NO-UNDO.

    DOS SILENT VALUE("COPY " + cBackupLocation + "\" + cFileExtension + " >> " + cLogOutput).

    RETURN.

END.
