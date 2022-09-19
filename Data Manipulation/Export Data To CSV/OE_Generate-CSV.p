/* ------------------------------------------------------------------------

                            Raphael Frei - 2022

                         EXPORT TABLES TO CSV FILE
                                GUIDE SHEET

------------------------------------------------------------------------ */

// File created based on temp table - Change the names and fields from your tables

/* ----- DEFINITION BLOCK ----- */
                       
    DEFINE TEMP-TABLE tt-table
         FIELD t-fstname AS CHAR
         FIELD t-lstname AS CHAR
         FIELD t-age     AS INT
         FIELD t-ssn     AS INT
         FIELD t-address AS CHAR
       //INDEX i-trace   IS PRIMARY t-ssn
         .

/* ----- Export Procedure ----- */

    DEF VAR i_filepath AS CHAR NO-UNDO INITIAL "C:\report.csv".

    DEF VAR i_topdata  AS CHAR NO-UNDO.

    i_topdata = "User Data Export" + CHR(13) + 
                "Exported on: " + STRING(TODAY) + 
                CHR(13) + CHR(13).

    OUTPUT TO VALUE(i_filepath).

        PUT UNFORMATTED i_topdata.

        EXPORT DELIMITER ","
                "First Name"
                "Last Name"
                "Age"
                "Social Security Number"
                "Address"
                .

        FOR EACH tt-table /* WHERE... AND... OR... */ NO-LOCK.

            EXPORT DELIMITER ","
                    tt-table.t-fstname
                    tt-table.t-lstname
                    tt-table.t-age
                    tt-table.t-ssn
                    tt-table.t-address
                    .

        END.

    OUTPUT CLOSE.
