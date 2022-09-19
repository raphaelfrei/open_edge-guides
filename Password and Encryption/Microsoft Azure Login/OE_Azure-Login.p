/* ------------------------------------------------------------------------

                            Raphael Frei - 2022

                       MICROSOFT AZURE AUTHENTICATE
                                GUIDE SHEET

------------------------------------------------------------------------ */

DEF INPUT PARAM i_user AS CHAR NO-UNDO.
DEF INPUT PARAM i_pass AS CHAR NO-UNDO.
DEF INPUT PARAM i_domn AS CHAR NO-UNDO.

DEF OUTPUT PARAM i_status AS CHAR NO-UNDO.

i_status = RF.CONTROL:AzureLogin(i_user, i_pass, i_domn).

RETURN.
