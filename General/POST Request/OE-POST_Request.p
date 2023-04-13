/* ------------------------------------------------------------------------

                            Raphael Frei - 2023
                       POST Request / From TempTable
                                GUIDE SHEET
                                
------------------------------------------------------------------------ */

// ----- VARIABLES -----                                                      

DEFINE VARIABLE HttpClient  AS CLASS System.Net.WebClient. 
DEFINE VARIABLE webResponse AS LONGCHAR    NO-UNDO. 
DEFINE VARIABLE cURL-Base   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cURL-Get    AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cURL-Post   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cURL-Token  AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cURL-Call   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE cCode       AS CHARACTER   NO-UNDO.
DEFINE VARIABLE wPost       AS LONGCHAR    NO-UNDO.    
DEFINE VARIABLE auth        AS CHARACTER   NO-UNDO.

FIX-CODEPAGE (webResponse) = "UTF-8".

// ----- TEMP TABLE -----

DEFINE TEMP-TABLE ttforpost LABEL "Post Request"
    FIELD cItem1  AS CHARACTER LABEL "Item 1"
    FIELD cItem2  AS CHARACTER LABEL "Item 2"
    FIELD cItem3  AS CHARACTER LABEL "Item 3"
    FIELD iItem4  AS INTEGER   LABEL "Item 4"
    FIELD dItem5  AS DATETIME  LABEL "Item Date"
    FIELD lStatus AS LOGICAL   LABEL "Is Post".

// ----- MAIN BLOCK -----

DO:

    RUN WriteLog(INPUT "----- STARTING AT: " + SUBSTRING(STRING(NOW), 1, 19) + " -----").

    RUN WriteLog(INPUT "----- LOADING TABLE -----").

    RUN LoadTempTable.

    RUN WriteLog(INPUT "----- STARTING POST -----").

    RUN PostRequest.

    RUN WriteLog(INPUT "----- FINISHED AT: " + SUBSTRING(STRING(NOW), 1, 19) + " -----").
    
    RUN WriteLog(INPUT " ").
    RUN WriteLog(INPUT FILL("-", 80)).
    RUN WriteLog(INPUT " ").

END.

// ----- PROCEDURES -----

/* Create PostRequest for Temp-Table */
PROCEDURE PostRequest:

    ASSIGN  cURL-base   = "https://www.google.com"
            cURL-get    = "/api/.../"
            cURL-Token  = "/api/.../.../token/"
            cURL-Post   = "/api/.../.../.../".

    FOR EACH ttforpost WHERE NOT lStatus NO-LOCK:

        HttpClient = NEW System.Net.WebClient(). 
        HttpClient:PROXY:Credentials = System.Net.CredentialCache:DefaultNetworkCredentials. 
        System.AppContext:SetSwitch("Switch.System.Net.DontEnableSchUseStrongCrypto", FALSE).


        ASSIGN wPost = ' [~{' +
               '"ITEM1":"'    + TRIM(ttforpost.cItem1)         + '", ' +
               '"ITEM2":"'    + TRIM(ttforpost.cItem2)         + '", ' +
               '"ITEM3":"'    + TRIM(ttforpost.cItem3)         + '", ' +
               '"ITEM4": '    + TRIM(STRING(ttforpost.iItem4)) +  ', ' +                            
               '"ITEMDATE":"' + STRING(YEAR(ttforpost.dItem5),"9999") + "-" + STRING(MONTH(ttforpost.dItem5),"99") + "-" + STRING(DAY(ttforpost.dItem5),"99") + 
                         '" }]' NO-ERROR.

        IF wPost = "" OR wPost = ? THEN DO:

            /* POST Assign Error - Cannot proceed */
            RUN WriteLog(INPUT "POST Assign Error: " + TRIM(ttforpost.cItem1)).

        END. ELSE DO:

            /* Syntax is correct - Proceed with request */

            auth = "...".

            httpClient:headers:ADD("Accept","application/json"). 
            httpClient:headers:ADD("Authorization", auth). 
            httpClient:headers:ADD("content-type","application/json").                   

            cURL-Call = cURL-base + cURL-Post.

            /* Upload the string */
            webResponse = HttpClient:UploadString(cURL-Call,wPost). 

            IF TRIM(STRING(webResponse)) = " " THEN DO:
                /* POST request was successfull */
                RUN WriteLog(INPUT "POST SUCCESS     : " + cUrl-Call + " " + STRING(wPost)).
                ASSIGN lStatus = TRUE.
            END. ELSE DO:
                /* POST error */
                RUN WriteLog(INPUT "POST ERROR       : " + cUrl-Call + " " + STRING(wPost) + " " + STRING(webResponse)).
            END.

        END.

        HttpClient:Dispose().
        DELETE OBJECT HttpClient.

    END.

END PROCEDURE.

/* Write Results into a LOG */
PROCEDURE WriteLog:

    DEFINE INPUT PARAMETER cMessage AS CHARACTER NO-UNDO.

    DEFINE VARIABLE cLogFileName AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cLogFilePath AS CHARACTER NO-UNDO.

    cLogFileName = "FUNC-HTTP-POST_" + STRING(YEAR(TODAY), "9999") + STRING(MONTH(TODAY), "99") + STRING(DAY(TODAY), "99").
    cLogFilePath = "C:\log\".

    OUTPUT TO VALUE(cLogFilePath + cLogFileName) APPEND.
        PUT UNFORMATTED STRING(NOW) + " | " + cMessage SKIP.
    OUTPUT CLOSE.

END PROCEDURE.

/* Load the Temp-Table */
PROCEDURE LoadTempTable:

    /* Do your function here... */

END PROCEDURE.
