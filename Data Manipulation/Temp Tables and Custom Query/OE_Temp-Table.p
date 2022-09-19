/* ------------------------------------------------------------------------

                            Raphael Frei - 2022

                         TEMP TABLE/FREEFORM QUERY
                                GUIDE SHEET

------------------------------------------------------------------------ */

/* ----- DEFINITION BLOCK ----- */
                       
    DEFINE TEMP-TABLE tt-table
         FIELD t-fstname AS CHAR
         FIELD t-lstname AS CHAR
         FIELD t-age     AS INT
         FIELD t-ssn     AS INT
         FIELD t-address AS CHAR
       //INDEX i-trace   IS PRIMARY t-ssn
         .

/* ----- FREEFORM QUERY ----- */

    //// DISPLAY TRIGGER
    // Does not require all fields
    tt-table.t-fstname LABEL "First Name"       FORMAT "X(10)"       WIDTH 20
    tt-table.t-lstname LABEL "Last Name"        FORMAT "X(10)"       WIDTH 20
    tt-table.t-age     LABEL "Age"              FORMAT "99"          WIDTH 20
    tt-table.t-ssn     LABEL "Social S. Number" FORMAT "999.99.9999" WIDTH 20

    //// OPEN_QUERY TRIGGER
    OPEN QUERY {&SELF-NAME} FOR EACH tt-table. //WHERE... AND... OR...
    
    //// ROW-DISPLAY TRIGGER
    // If user age is under 18, paint the column in red.

    DEF VAR bgRed AS INT NO-UNDO.
    // This is the color ID from the .ini file
    bgRed = 12.

    IF tt-table.t-age < 18 THEN 
        // Rename the 'brUser' to the browser's name
        ASSIGN tt-table.t-fstname:BGCOLOR IN BROWSE brUser = bgRed
               tt-table.t-lstname:BGCOLOR IN BROWSE brUser = bgRed
               tt-table.t-age:BGCOLOR     IN BROWSE brUser = bgRed   
               tt-table.t-ssn:BGCOLOR     IN BROWSE brUser = bgRed.   
