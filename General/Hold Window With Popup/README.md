# Hold Main Window while Popup is opened
- Do not allow user to use the window while popup is appearing
  - Method 1: Freeze the Main Window
  - Method 2: Hide the Main Window
 
## How To Use:

````progress
    // Put the content before and after the RUN command
    
    // Make the Main Window freezed (Cannot move, resize or close)
    ASSIGN CURRENT-WINDOW:SENSITIVE = FALSE.
    RUN My_Window.w.
    ASSIGN CURRENT-WINDOW:SENSITIVE = TRUE.

    // Hides the Main Window
    wWin:VISIBLE = FALSE.
    RUN My_Window_2.w.
    wWin:VISIBLE = TRUE.
````
