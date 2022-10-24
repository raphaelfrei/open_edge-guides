/* ------------------------------------------------------------------------
                            Raphael Frei - 2022
                            
                         WINDOW POP-UP MANAGEMENT
                                GUIDE SHEET
                                
------------------------------------------------------------------------ */

// Make the Main Window freezed (Cannot move, resize or close)
ASSIGN CURRENT-WINDOW:SENSITIVE = FALSE.
RUN My_Window.w.
ASSIGN CURRENT-WINDOW:SENSITIVE = TRUE.

// Hides the Main Window
wWin:VISIBLE = FALSE.
RUN My_Window_2.w.
wWin:VISIBLE = TRUE.
