/* ------------------------------------------------------------------------

                            Raphael Frei - 2022

                          SEND SMTP - HTML EMAILS
                                GUIDE SHEET

------------------------------------------------------------------------ */

DEF VAR i_status AS CHAR NO-UNDO.
DEF VAR i_htmlpt AS CHAR NO-UNDO.

// Path where the function will find the html file
i_htmlpt = "C:\html.txt".

RUN OE_Azure-Login.p("", "", "", OUTPUT i_status).

IF NOT i_status BEGINS "Success" THEN DO:

    RUN WriteHTML.p(i_htmlpt,
                    "Error while logging in Azure",
                    i_status).

    RF.SMTP:SendHTMLEmail("",        //SEND TO                                              
                          "",        //SUBJECT                                              
                          i_htmlpt,  //HTML Body Path                                       
                          "",        //SEND AS                                              
                          "").       //SMTP Client                                          
                                                                                                                                                        

END.
