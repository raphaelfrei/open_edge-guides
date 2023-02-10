/* **********************************************************************
*                                                                       *
*                                                                       *
*                           Raphael Frei - 2023                         *
*                                                                       *
*                    Conexão SQL Server com o Progress                  *
*                                                                       *
*                                                                       *
********************************************************************** */

/* ----- SQL COM-HANDLE ----- */

DEFINE VARIABLE ObjRecordSet         AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ObjRecordSet_confirm AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ObjConnection        AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE ObjCommand           AS COM-HANDLE NO-UNDO.

/* Create the connection object for the link to SQL */
CREATE "ADODB.Connection" ObjConnection.
/* Create a recordset object ready to return the data */
CREATE "ADODB.RecordSet" ObjRecordSet.
/* Create a recordset object ready to return the data */
CREATE "ADODB.RecordSet" ObjRecordSet_confirm.
/* Create a command object for sending the SQL statement */
CREATE "ADODB.Command" ObjCommand.

/* ----- Connection Objects ----- */

DEFINE VARIABLE ODBC-DSN      AS CHARACTER NO-UNDO.
DEFINE VARIABLE ODBC-SERVER   AS CHARACTER NO-UNDO.
DEFINE VARIABLE ODBC-USERID   AS CHARACTER NO-UNDO.
DEFINE VARIABLE ODBC-PASSWD   AS CHARACTER NO-UNDO.
DEFINE VARIABLE ODBC-QUERY    AS CHARACTER NO-UNDO.
DEFINE VARIABLE ODBC-STATUS   AS CHARACTER NO-UNDO.
DEFINE VARIABLE ODBC-RECCOUNT AS INTEGER   NO-UNDO.
DEFINE VARIABLE ODBC-NULL     AS CHARACTER NO-UNDO.
DEFINE VARIABLE ODBC-CURSOR   AS INTEGER   NO-UNDO.

ASSIGN ODBC-DSN    = ""  // ODBC DSN
       ODBC-SERVER = ""  // Server hosting the SQL database
       ODBC-USERID = ""  // User for access the SQL database
       ODBC-PASSWD = "". // Password for the user

/* ----- Objects ----- */

DEFINE VARIABLE Field1 AS CHAR NO-UNDO.
DEFINE VARIABLE Field2 AS CHAR NO-UNDO.
DEFINE VARIABLE Field3 AS CHAR NO-UNDO.
DEFINE VARIABLE Field4 AS CHAR NO-UNDO.

/* ----- Open Connection ----- */

ObjConnection:OPEN("data source=" + ODBC-DSN + ";server=" + ODBC-SERVER, ODBC-USERID, ODBC-PASSWD, 0) NO-ERROR.

IF ERROR-STATUS:NUM-MESSAGES > 0 THEN DO:

    /* Error - Could not establish connection. */

END. ELSE DO:

    /* Connection established */

    ASSIGN ObjCommand:ActiveConnection     = ObjConnection
           ObjCommand:CommandType          = 1  /* adCmdText */
           ObjConnection:CursorLocation    = 3  /* adUseClient */
           ObjRecordSet:CursorType         = 3  /* adOpenStatic */
           ObjRecordSet_confirm:CursorType = 3. 

    // Preparing QUERY
    ODBC-QUERY = "SELECT ... FROM ... WHERE ...".
    ObjCommand:CommandText = ODBC-QUERY.
    ObjRecordSet = ObjCommand:EXECUTE(OUTPUT ODBC-NULL, "", 32) NO-ERROR.

    // Check if QUERY is not null
    IF ODBC-NULL <> "1" THEN DO:

        // Record Count
        ODBC-RECCOUNT = ObjRecordSet:RecordCount.

        // Check if any records where found
        IF ODBC-RECCOUNT > 0 THEN DO:

            // Move to the first
            ObjRecordSet:MoveFirst NO-ERROR.

            // Loop until the last record
            DO WHILE TRUE:

                Field1 = ObjRecordSet:FIELDS("Field1"):VALUE NO-ERROR.
                Field2 = ObjRecordSet:FIELDS("Field2"):VALUE NO-ERROR.
                Field3 = ObjRecordSet:FIELDS("Field3"):VALUE NO-ERROR.

                // Move to the next record
                ObjRecordSet:MoveNext NO-ERROR.

                // ----- Prepare one more query -----

                ODBC-QUERY = "DECLARE ... DECLARE ... EXECUTE ... '" + Field1 + "'".
                ObjCommand:CommandText = ODBC-QUERY.

                ObjRecordSet_Confirm = Objcommand:EXECUTE(OUTPUT ODBC-NULL, "", 32) NO-ERROR.

                IF ODBC-NULL <> "1" THEN DO:

                    ODBC-RECCOUNT = ObjRecordSet_Confirm:RecordCount.

                    IF ODBC-RECCOUNT > 0 THEN DO:

                        ObjRecordSet_confirm:MoveFirst NO-ERROR. 
                        Field4 = ObjRecordSet_confirm:FIELDS("Field4"):VALUE NO-ERROR.

                    END. ELSE DO:

                        Field4 = "Error".

                    END.

                END.

                // ----- End of 2nd Query -----

                // EOF - End of File
                IF ObjRecordSet:EOF THEN LEAVE. 

            END.

        END.

    END.

    ObjConnection:CLOSE NO-ERROR.

END.

/* ----- Release Memory ----- */
RELEASE OBJECT ObjConnection NO-ERROR.
RELEASE OBJECT ObjCommand    NO-ERROR.
RELEASE OBJECT ObjRecordSet  NO-ERROR.

ASSIGN ObjConnection = ?
       ObjCommand    = ?
       ObjRecordSet  = ?.

QUIT.
