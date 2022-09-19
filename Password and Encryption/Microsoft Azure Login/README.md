# Microsoft Azure - Password Authentication
This helps to create a program that not requires user's password maintenance, it'll be the same as their Microsoft Accounts.
- Requires machine to be registred on Active Directory's service.

## How To Use:
1st - [Register your DLL](https://github.com/raphaelfrei/open_edge-guides/tree/main/General/Custom%20DLL) with ProAsmRef.<br>
2st - Import this Procedure into your program *(or use the code directly into the app)*<br>

How should be the way that you call the procedure:

````progress
// DOMAIN must be in the form 'DOMAIN.com'
RUN OE_Azure-Login.p(INPUT i_userid, INPUT i_password, INPUT i_domain, OUTPUT i_status).
// If user password is correct, the i_status will begin with SUCCESS, else begins with ERROR

IF i_status BEGINS "SUCCESS" THEN DO:
    MESSAGE "User has successfully logged in.".
END.
ELSE DO:
    MESSAGE "User name or password is incorrect.".
END.
````


