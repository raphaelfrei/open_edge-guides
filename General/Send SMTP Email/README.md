# Send HTML Email with SMTP
Custom DLL to Create SMTP Emails from Progress. <br>
You can use [this link](https://github.com/raphaelfrei/open_edge-guides/tree/main/General/Custom%20DLL) to load custom DLL into Progress. *(Including the one here)*

### How To Use:

- The code inside the **OE_Send-SMTP-Email.p** is just a reference that you need to insert into your program;
- The code inside **WriteHTML.p** is my function to write the HTML based on the details provided. You can use this or create your own;

This code is used to write the HTML file:
````progress
    RUN WriteHTML.p(i_htmlpt,
                    "Error while logging in Azure",
                    i_status).
````

This code is responsable to send the email by SMTP:
````progress
    RF.SMTP:SendHTMLEmail("",        //SEND TO - ';' for multiple emails                                             
                          "",        //SUBJECT                                              
                          i_htmlpt,  //HTML Body Path                                       
                          "",        //SEND AS                                              
                          "").       //SMTP Client     
````

I've written the **i_htmlpt** as a variable to not have to change in lots of places if need replacement:
````progress
DEF VAR i_htmlpt AS CHAR NO-UNDO.

// Path where the function will find the html file
i_htmlpt = "C:\html.txt".

// Or you can send this directly:
RUN WriteHTML.p("C:\html.txt").
````

The rest of the code is just a charming to give more details on how it works... It's using [Azure Login Status](https://github.com/raphaelfrei/open_edge-guides/tree/main/Password%20and%20Encryption/Microsoft%20Azure%20Login) to send the email, based on if the password is correct or not.
