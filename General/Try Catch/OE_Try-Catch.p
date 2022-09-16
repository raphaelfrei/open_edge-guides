/* ------------------------------------------------------------------------

                            Raphael Frei - 2022

                          TRY AND CATCH OPERATION
                                GUIDE SHEET

------------------------------------------------------------------------ */

// Start of the file
BLOCK-LEVEL ON ERROR UNDO, THROW.

// Always the last part of the file
CATCH err AS Progress.Lang.Error:    
    MESSAGE err:GetMessage(1).
END.
