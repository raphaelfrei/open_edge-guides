/* ------------------------------------------------------------------------

                            Raphael Frei - 2023
                          CREATE ONLINE DB BACKUP
                                GUIDE SHEET
                                
------------------------------------------------------------------------ */

// ----- Input and Output Parameters -----

DEFINE INPUT PARAM cDatabaseLocation AS CHAR NO-UNDO.
DEFINE INPUT PARAM cBackupFolder     AS CHAR NO-UNDO.
DEFINE INPUT PARAM cLogLocation      AS CHAR NO-UNDO.

// ----- Variables -----

DEFINE VARIABLE cDatabaseName        AS CHAR NO-UNDO.

// ----- Main Block -----

OUTPUT TO VALUE(cLogLocation) APPEND.

    // Remove if exist last '\' from the Backup Folder path
    IF SUBSTRING(cBackupFolder, LENGTH(cBackupFolder) - 1) = "\" THEN ASSIGN cBackupFolder = SUBSTRING(cBackupFolder, 1, LENGTH(cBackupFolder) - 1).

    RUN GetDatabaseName(INPUT cDatabaseLocation, OUTPUT cDatabaseName).

    PUT UNFORMATTED "Backup started at " + SUBSTRING(STRING(NOW), 1, 19) SKIP
                    "Selected database is: " + cDatabaseName SKIP.

OUTPUT CLOSE.

    // Output needs to close for output inside the OS-COMMAND

    OS-COMMAND SILENT VALUE("probkup online " + cDatabaseLocation + " " + cBackupFolder + "\" + cDatabaseName + ".bkp >> " + cLogLocation).

OUTPUT TO VALUE(cLogLocation) APPEND.

    PUT UNFORMATTED SKIP(2) "Backup finished at " + SUBSTRING(STRING(NOW), 1, 19) + "." SKIP

OUTPUT CLOSE.

// ----- Procedures -----

// Get database name based on last entry of path
PROCEDURE GetDatabaseName:

    DEFINE INPUT  PARAM cFilePath AS CHAR NO-UNDO.
    DEFINE OUTPUT PARAM cDBName   AS CHAR NO-UNDO.

    DEFINE VARIABLE iNumEntries AS INT NO-UNDO.

    iNumEntries = NUM-ENTRIES(cFilePath, "\").

    cDBName = ENTRY(iNumEntries, cFilePath, "\").

    RETURN.

END.
