/* ------------------------------------------------------------------------
    File        : OE-ProgressSocket.p
    Purpose     : Facilitate migration between WinSocket to Progress Socket

    Syntax      : Progress 4GL

    Description : Connect Progress Socket with KeepWare's VB

    Author(s)   : Raphael Frei
    Created     : 20.Jan.2025
    Notes       : 
------------------------------------------------------------------------ */

/* ----- VARIABLES ----- */
DEFINE VARIABLE hSocket      AS HANDLE      NO-UNDO.
DEFINE VARIABLE cConString   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE lIsConnected AS LOGICAL     NO-UNDO.

/* ----- MAIN-BLOCK ----- */
DO:

    ASSIGN cConString = "-H 192.168.0.1 -S 1001 -clientConnectTimeout 200". // - Just example
    
    CREATE SOCKET hSocket.
    
    hSocket:CONNECT(cConString) NO-ERROR.
    hSocket:SET-READ-RESPONSE-PROCEDURE("CON_RESPONSE_PROCEDURE").
    
    ASSIGN lIsConnected = hSocket:CONNECTED().

END.

/* ----- PROCEDURES ----- */

// Get Response from Socket
PROCEDURE CON_RESPONSE_PROCEDURE:

    DEFINE VARIABLE cResponse AS CHARACTER   NO-UNDO.   
    
    DEFINE VARIABLE mBuffer     AS MEMPTR      NO-UNDO.
    DEFINE VARIABLE iBytesTotal AS INTEGER     NO-UNDO.
    DEFINE VARIABLE lOk         AS LOGICAL     NO-UNDO.
    
    IF SELF:GET-BYTES-AVAILABLE() <= 0 THEN
        RETURN NO-APPLY.
        
    ASSIGN iBytesTotal = SELF:GET-BYTES-AVAILABLE() + 1.    
    
    SET-SIZE(mBuffer) = 0.
    SET-SIZE(mBuffer) = iBytesTotal.
    
    ASSIGN lOk = SELF:READ(mBuffer, 1, iBytesTotal, 1) NO-ERROR.
    
    IF NOT lOk THEN
        RETURN.
        
    ASSIGN cResponse = GET-STRING(mBuffer, 1, iBytesTotal). // - This is the return string from the socket    
    
END.
