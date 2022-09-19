# Scale Screen
Make the app scale according to Screen Size.
<br>
Works in the same app to go full screen with 16:9 or 4:3.
<br>

## How To Use:
This procedure does not work with text sizes, because you have to set them manually.<br>
You have to import the details from the procedure directly into your .w, you can't call the procedure to scale your app.

You can do this with the following code:

````progress
//At WINDOW-MAXIMIZED TRIGGER:
DO WITH FRAME {&FRAME-NAME}:
    //// These are not font sizes, they are the fonts from the .ini file
    // Choose the bigger size font - Add this at the end of the trigger
    fll-timer:FONT       = 16.
    fll-lstchck:FONT     = 16.
    fll-lstchck-txt:FONT = 16.
    fll-interval:FONT    = 16.
END.

//At WINDOW-RESTORED TRIGGER:
DO WITH FRAME {&FRAME-NAME}:
    // Choose the smaller size font - Add this at the end of the trigger
    fll-timer:FONT       = 1.
    fll-lstchck:FONT     = 1.
    fll-lstchck-txt:FONT = 1.
    fll-interval:FONT    = 1.
END.
````
