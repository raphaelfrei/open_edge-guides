/* ------------------------------------------------------------------------

                            Raphael Frei - 2022
                            
                         LIST ITEMS FROM DIRECTORY
                                GUIDE SHEET
                                
------------------------------------------------------------------------ */

DEF VAR cFileStream AS CHAR NO-UNDO.
DEF VAR i_directory AS CHAR NO-UNDO.

//// Show all the files and folders inside this folder
// Does not include subitems
i_directory = "C:\Windows\System32".

INPUT FROM OS-DIR(i_directory).

REPEAT:
    // cFileStream receives the name of every file, including extension - EX: '20220921.txt'
    IMPORT cFileStream.

    // Here you can manipulate the files, like using DOS command to move them around
    MESSAGE STRING(cFileStream).
END.
