/* **********************************************************************
*                                                                       *
*                                                                       *
*                           Raphael Frei - 2024                         *
*                                                                       *
*                    https://www.github.com/raphaelfrei                 *   
*                                                                       *
*                                                                       *
*************************************************************************
*                                                                       *
*       COPYRIGHT (C) 2024 - Raphael Frei                               *
*                                                                       *
*       PROGRAM: OE-QUERY-Creation.p                                    *
*                                                                       *
*       PROGRAM SUMMARY:                                                *
*           Get username and program that called the procedure.         *
*                                                                       *
*       INPUT/OUTPUT PARAMETERS:                                        *
*           None.                                                       *
*                                                                       *
*       VERSIONS:                                                       *
*           v1.00 - 05/Jun/24: Document Creation                        *
*                                                                       *
*                                                                       *
********************************************************************** */

/* ----- TEMP-TABLES ----- */

DEFINE TEMP-TABLE TT-User
    FIELD Usr-UserID   AS INTEGER
    FIELD Usr-Email    AS CHARACTER
    FIELD Usr-Password AS CHARACTER
    FIELD Usr-FullName AS CHARACTER
    FIELD Usr-RegDate  AS DATETIME
    FIELD Usr-Birthday AS DATETIME
    INDEX IDX-1 IS PRIMARY UNIQUE Usr-UserID Usr-Email.

DEFINE TEMP-TABLE TT-PasswordHistory
    FIELD Usr-UserID   AS INTEGER
    FIELD Usr-Password AS CHARACTER
    INDEX IDX-1 IS PRIMARY Usr-UserID.
                                                      
/* ----- VARIABLES ----- */

DEFINE VARIABLE cSearchQuery  AS CHARACTER NO-UNDO.
DEFINE VARIABLE cTextToSearch AS CHARACTER NO-UNDO.

DEFINE VARIABLE lSearchByID    AS LOGICAL NO-UNDO.
DEFINE VARIABLE lSearchByEmail AS LOGICAL NO-UNDO.
DEFINE VARIABLE lSearchByName  AS LOGICAL NO-UNDO.
DEFINE VARIABLE lSearchByRegDt AS LOGICAL NO-UNDO.
DEFINE VARIABLE lSearchByBthdy AS LOGICAL NO-UNDO.

DO:

    // Insert 'WHERE 1=1' makes easier to add other filters only with AND
    ASSIGN cSearchQuery = "FOR EACH TT-USER WHERE 1=1".
    
    IF lSearchByID THEN
        ASSIGN cSearchQuery = cSearchQuery + " AND TT-User.Usr-UserID = " + cTextToSearch.
    
    IF lSearchByEmail THEN
        ASSIGN cSearchQuery = cSearchQuery + " AND TT-User.Usr-Email = " + QUOTER(cTextToSearch).
    
    IF lSearchByName THEN
        ASSIGN cSearchQuery = cSearchQuery + " AND TT-User.Usr-FullName = " + QUOTER(cTextToSearch).
    
    IF lSearchByRegDt THEN
        ASSIGN cSearchQuery = cSearchQuery + " AND TT-User.Usr-RegDate = " + QUOTER(cTextToSearch).
    
    IF lSearchByBthdy THEN
        ASSIGN cSearchQuery = cSearchQuery + " AND TT-User.Usr-Birthday = " + QUOTER(cTextToSearch).
    
    // You can ulso use HIGHER and LOWER for ID's and DATE's - To search something between both values like this
    // TT-User.Usr-UserID >= (or >) cTextToSearch1 AND TT-User.Usr-UserID <= (or <) cTextToSearch2
    // The same logic that you'll use to mount a query in a FIND or FOR block, you can use here - This way is more recommended when you can have multiple optional filters
    // I'm using this on programs that creates reports based on ID's, DATE's and many more
    
    // Search thru related databases
    ASSIGN cSearchQuery = cSearchQuery + ", EACH TT-PasswordHistory OF TT-User NO-LOCK".
    
    // You need to add all tables mentioned on Search Query here
    DEFINE QUERY q FOR TT-User, TT-PasswordHistory.
    
    QUERY q:QUERY-PREPARE(cSearchQuery).
    QUERY q:QUERY-OPEN().
    
    GET FIRST q.
    REPEAT WHILE AVAILABLE TT-User:
    
        // Do your logic here
    
        GET NEXT q.
    
    END.

END.
