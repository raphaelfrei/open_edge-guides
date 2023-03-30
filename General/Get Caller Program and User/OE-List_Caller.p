/* **********************************************************************
*                                                                       *
*                                                                       *
*                           Raphael Frei - 2023                         *
*                                                                       *
*                    https://www.github.com/raphaelfrei                 *   
*                                                                       *
*                                                                       *
*************************************************************************
*                                                                       *
*       COPYRIGHT (C) 2023 - Raphael Frei                               *
*                                                                       *
*       PROGRAM: OE-List_Caller.p                                       *
*                                                                       *
*       PROGRAM SUMMARY:                                                *
*           Get username and program that called the procedure.         *
*                                                                       *
*       INPUT/OUTPUT PARAMETERS:                                        *
*           None.                                                       *
*                                                                       *
*       VERSIONS:                                                       *
*           v1.00 - 30/03/23: Document Creation                         *
*                                                                       *
*                                                                       *
********************************************************************** */

/* _MyConnection stores information about current session */
FIND FIRST _myconnection NO-LOCK NO-ERROR.
    
/* Find enviroment variables from PID (User's Process ID*/
FIND FIRST _Connect WHERE _Connect-Pid = _myconnection._myconn-pid NO-LOCK NO-ERROR.

MESSAGE "The user who called is: " + _Connect-Name SKIP
        "And the caller program is: " + PROGRAM-NAME(2) SKIP
        "And this program is: " + PROGRAM-NAME(1)
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
