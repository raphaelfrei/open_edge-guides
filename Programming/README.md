# Programming with OpenEdge Progress 4GL - General Tips and Tricks:

- [Basics of Programming](https://github.com/raphaelfrei/open_edge-guides/tree/main/Programming#basics-of-programming)
- [Intermediate Contents](https://github.com/raphaelfrei/open_edge-guides/tree/main/Programming#intermediate-of-programming)

# Basics of Programming!
Basics on how to start programming with OpenEdge.

## INDEX:
- [Variables](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#variables)
- [Convert Variables](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#convert-variables)
- [Message Box](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#message-box)
- [Condition Blocks](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#condition-blocks)
- [Manipulate Screen Elements](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#manipulate-screen-elements)
- [Database on Code](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#database)
- [Open External Window/Procedure](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#open-other-windows)
- [Compile Apps](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#compile-apps)
- [Create and Modify Database](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#create-and-modify-database)
- [Connect Database from PF](https://github.com/raphaelfrei/open_edge-guides/tree/main/Basics%20of%20Programming#connect-database-from-parameter-file)
- [Run CMD Commands](https://github.com/raphaelfrei/open_edge-guides/blob/main/Basics%20of%20Programming/README.md#run-cmd-commands)

## VARIABLES:
*(Comparing to languages like C#)*
````progress

    // Always use NO-UNDO for best pratices - Check the end for more details
    DEFINE VARIABLE i_name AS type NO-UNDO.
    
    // You can also write in a smaller form (I prefer this way)
    DEF VAR i_name AS type NO-UNDO.
    
    // You can use INITIAL at the end to set the start value
    DEFINE VARIABLE i_text AS CHARACTER NO-UNDO INITIAL "Hello!".
    
    // You can use EXTENT for array - Array first position is 1 instead of 0 like other languages
    DEFINE VARIABLE i_num AS INT NO-UNDO EXTENT 3 INITIAL [1, 2, 3].
    
    //// -----------------------------------------------------
    
    //// Let's talk about variables types (and smaller form) then compare to C#
    // INTEGER - INT - Numeric Int
    DEFINE VARIABLE number AS INTEGER NO-UNDO.
    DEF VAR number AS INT NO-UNDO.
    
    number = 10.
    
    MESSAGE number. // Display '10'
    
    //// -----------------------------------------------------
    
    // DECIMAL - DEC - Numeric Float
    DEFINE VARIABLE number AS DECIMAL NO-UNDO.
    DEF VAR number AS DEC NO-UNDO.
    
    number = 10.5.
    
    MESSAGE number. // Display '10.5'
    
    //// -----------------------------------------------------
    
    // CHAR - CHARACTER - String (Character Sequence)
    DEFINE VARIABLE i_text AS CHARACTER NO-UNDO.
    DEF VAR i_text AS CHAR NO-UNDO.
    
    i_text = "Hello, World!".
    
    MESSAGE i_text. // Display 'Hello, World!'
    
    //// -----------------------------------------------------
    
    // LOGICAL - LOG - Boolean (True or False)
    DEFINE VARIABLE bool AS LOGICAL NO-UNDO.
    DEF VAR bool AS LOG NO-UNDO.
    
    bool = TRUE.

    MESSAGE bool. // Display 'yes'
    
    //// -----------------------------------------------------
    
    // DATE - Day/Month/Year
    DEF VAR i_today AS DATE NO-UNDO.

    i_today = TODAY.

    MESSAGE i_today. // Display '21/09/2022' (Today's date - DD/MM/YYYY)
    
    //// -----------------------------------------------------
    
    // DATETIME - Day/Month/Year Hour:Minute:Seconds,Milisseconds
    DEF VAR i_now AS DATETIME NO-UNDO.

    i_now = NOW.

    MESSAGE i_now. // Display '21/09/2022 09:39:42,467'
    
    //// -----------------------------------------------------
    
    // DATETIME-TZ - DATETIME + Time Zone - Day/Month/Year Hour:Minute:Seconds,Milisseconds-TimeZone
    DEF VAR i_now AS DATETIME NO-UNDO.

    i_now = NOW.

    MESSAGE i_now. // Display '21/09/2022 09:40:52,130-03:00'
    
    //// -----------------------------------------------------

````
- Find more about [NO-UNDO and NO-ERROR](https://stackoverflow.com/questions/51720186/what-is-the-meaning-of-no-undo-on-define-variable-in-progress-4gl).
- Find more about VARs in [Official Docs](https://documentation.progress.com/output/ua/OpenEdge_latest/pdsoe/PLUGINS_ROOT/com.openedge.pdt.langref.help/rfi1424920258246.html)

## CONVERT VARIABLES:
Will raise an error if conversion not possible

````progress
    
    i_variable = TYPE(other_variable).
    
    //// -----------------------------------------------------
    
    // Convert into INTEGER
    number = INT(dec_number).
    // If decimal part is greater than 0.5, it'll round up    
    
    // ---- Example ----
    
    DEF VAR i_now AS DECIMAL NO-UNDO.

    i_now = 10.4.

    // To show on message, must convert to STRING... Check next module for more details
    MESSAGE STRING(INT(i_now)). // Display '10'
    
    // -----
    
    i_now = 10.5.

    MESSAGE STRING(INT(i_now)). // Display '11'
    
    // -----
    
    DEF VAR i_text AS CHARACTER NO-UNDO INITIAL "Hi".
    
    MESSAGE STRING(INT(i_text)). // Raise the error 76 - Invalid CHAR
    
    //// -----------------------------------------------------
    
    // Date and Format
    
    DEF VAR i_today AS DATE NO-UNDO INITIAL TODAY.

    MESSAGE STRING(i_today, "99/99/99"). // Display '21/02/21'

````

## MESSAGE BOX:
How to Use Message Box to show information and accept user's input.

````progress

    MESSAGE "body" // Accepts variables as text to, just don't forget to convert with STRING().
                   // You can use 'SKIP' for line break
        VIEW-AS ALERT-BOX (QUESTION/INFORMATION/ERROR/MESSAGE/WARNING)
        TITLE "title".
        
    // ---- Example ----
    
    DEF VAR i_user AS CHAR NO-UNDO.
    
    // CONDITION and LOOP blocks will be covered in another section
    IF i_user = "" DO:
    
        MESSAGE "The username cannot be empty!"
            VIEW-AS ALERT-BOX INFO
            TITLE "Incorrect Field".
    
    END.
    
    // -----
    
    DEF VAR i_choice AS LOG NO-UNDO.
    
    MESSAGE "Do you want to leave without saving?"
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO-CANCEL
        TITLE "Save Settings" 
        UPDATE i_choice AS LOGICAL.

    CASE i_choice:
    
        WHEN TRUE THEN DO:
            // YES Operation
        END.
        
        WHEN FALSE THEN DO:
            // NO Operation
        END.
        
        OTHERWISE DO:
            // CANCEL Operation
        END.
    
    END. 
````
- Official Docs from [MESSAGE](https://docs.progress.com/en-US/bundle/openedge-abl-reference-117/page/MESSAGE-statement.html)

## CONDITION BLOCKS:
IF and ELSE; REPEAT; CASE.

````progress

    //// IF and ELSE
    
    // One line action
    IF condition THEN ...
        ELSE ...
        
    // Multiline action
    IF condition THEN DO:
        ...
        ...
    END. ELSE DO:
        ...
        ...
    END.
    
    // ---- Example ----
    
    DEF VAR login_attempt AS INT NO-UNDO INITIAL 0.
    DEF VAR max_login_att AS INT NO-UNDO INITIAL 5.
    
    IF login_attempt > max_login_att THEN DO:
        MESSAGE "Account blocked. Please contact your Local IT"
            VIEW-AS ALERT-BOX INFO
            TITLE "Account Blocked".
            
    END. ELSE DO:
        MESSAGE "Incorrect Password, please try again" 
            SKIP "Attempt " + STRING(login_attempt) + " of " + STRING(max_login_att) + "."
                VIEW-AS ALERT-BOX INFO
                TITLE "Incorrect Password".
            
    END.
    
    //// -----------------------------------------------------
    
    //// REPEAT
    
    REPEAT int TO max_value:
        ...
        ...
    END.
    
    // ---- Example ----
    
    // I always try to make the lines bind together - Makes easier to read the code after
    DEF VAR ii    AS INT NO-UNDO.
    DEF VAR i_int AS INT NO-UNDO EXTENT 3 INITIAL [10, 20, 30].
        
    REPEAT ii = 1 TO EXTENT(i_int):
        i_int[ii] = i_int[ii] * ii.
        
        //// You can also use MESSAGE here to show the values, but I prefered to use outside the repeat block to better show the answers...
        // MESSAGE i_int[ii].
    END.
    
    MESSAGE i_int[1]. // '10'
    MESSAGE i_int[2]. // '40'
    MESSAGE i_int[3]. // '90'
````

## MANIPULATE SCREEN ELEMENTS:
View or Modify elements like FILL-IN, RADIO-SET, BUTTON...

````progress

    // To READ or CHANGE an element, you'll always need to set the frame you're working.
    // You can do this by two ways:
    
    // Let's pretend that I have lots of FILL-IN called fll-txt-1, fll-txt-2, fll-txt-3, ...:
    
    //// First Way:
    // You have to specify the frame every time you change something... Use {&FRAME-NAME} or the name of the frame (Default is DEFAULT-FRAME)
    
    fll-txt-1:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(i_number-1).
    fll-txt-2:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(i_number-2).
    fll-txt-3:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(i_number-3).
    ...
    fll-txt-n:SCREEN-VALUE IN FRAME {&FRAME-NAME} = STRING(i_number-n).
    
    // Example with button
    btn-start:LABEL        IN FRAME {&FRAME-NAME} = "STOP".

    //// Second Way:
    // Specify the frame into a DO BLOCK...
    
    DO WITH FRAME {&FRAME-NAME}:
    
        fll-txt-1:SCREEN-VALUE = STRING(i_number-1).
        fll-txt-2:SCREEN-VALUE = STRING(i_number-2).
        fll-txt-3:SCREEN-VALUE = STRING(i_number-3).
        ...
        fll-txt-n:SCREEN-VALUE = STRING(i_number-n).
        
        btn-start:LABEL        = "STOP".
    
    END.
````

## DATABASE:
How to manipulate database on the code.

````progress

    //// LOCK Types:
    // NO-LOCK - Read only operation, more than one user at a time
    // EXCLUSIVE-LOCK - Read and Write operation, only one user at a time
    // SHARE-LOCK - Not in use anymore, only PAIN IN YOUR LIFE trying to use this... (Used around the 80's)
    
    //// ERROR types:
    // NO-ERROR - Will not set a MESSAGE if encontered some error
    // Leave it blank for error messages
    
    //// -----------------------------------------------------
    
    //// FIND types:
    // FIND [CURRENT/FIRST/LAST/NEXT/PREVIOUS] table [WHERE... AND... OR...] LOCK NO-ERROR.
    // Always use IF (NOT) AVAIL while working with FIND
    FIND FIRST user WHERE user.user_id    = i_user NO-LOCK        NO-ERROR.
    FIND FIRST user WHERE user.first_name = "John" EXCLUSIVE-LOCK NO-ERROR.
    
    //// ---- Examples ----
    
    // Read Only Operation:
    
    FIND FIRST user WHERE user.user_id = i_user NO-LOCK NO-ERROR.
    
    IF AVAIL user THEN DO:
        // Found user
    END.
    
    IF NOT AVAIL user THEN DO:
        // User not found
    END.
    
    // Read and Write Operation:
    
    FIND FIRST user WHERE user.first_name = "John" EXCLUSIVE-LOCK NO-ERROR.
    // Will raise error with NO-LOCK
    
    IF AVAIL user THEN DO:
    
        // Found user
        user.telephone_number = "123456789".
        
    END.
    
    IF NOT AVAIL user THEN DO:
    
        // User not found
        MESSAGE "User not found.".
        
    END.
    
    //// Searching with FIELDS option:
    // Reduces CPU and Memory usage because the search only occurs in these fields
    // This is different from the above, because there you search based on the name and after finding the record, you change the number
    
    FOR FIRST user FIELDS (user.usr_id) WHERE user.usr_id = "abc" NO-LOCK:
        // You can only display the fields used on the FIELDS option; Otherwhise will raise an error.
        DISPLAY usr_mstr.usr_userid.
    END.
    
    
    //// FOR EACH Types:
    // CAUTION - You can destroy an entire database with this
    // (I've done it myself... luckly it was on DEV's database... I've encrypted everybody's password twice, so no one could log into the system)
    
    // Read Only Operation:
    
    DEF VAR i_usercount AS INT NO-UNDO INITIAL 0.
    
    FOR EACH user /* CONDITIONS works here */ NO-LOCK:
    
        ii = ii + 1.
        
    END.
    
    MESSAGE "There are " + STRING(ii) + " users registred!".
    
    // Write Operation:
    FOR EACH user WHERE user.user_id BEGINS "a" EXCLUSIVE-LOCK:
    
        // Delete every user that ID begins with 'a'
        DELETE user.
        
    END.
    
    // You can also skip records:
    FOR EACH user WHERE user.user_id BEGINS "a" EXCLUSIVE-LOCK:
    
        // If first name not begins with 'J' then go to the next record
        IF NOT user.first_name BEGINS "J" THEN NEXT.
        
        // Delete every user that ID begins with 'a'
        DELETE user.
    END.

````
- Official Docs from [FIND](https://docs.progress.com/pt-BR/bundle/abl-reference/page/FIND-statement.html)
- Official Docs from [FOR EACH](https://documentation.progress.com/output/ua/OpenEdge_latest/pdsoe/PLUGINS_ROOT/com.openedge.pdt.langref.help/rfi1424919813003.html)

## OPEN OTHER WINDOWS:
Run window from another window... <br>
Like Main Menu opening Password Manager

````progress

    //// This can be done with RUN command
    // In two years of work, I've only used for .P or .R (You can let the extension for .R be .W, but it will require the .R in the folder)
    // You can use this with Web Services from Progress too
    
    RUN program.extension(INPUT variables, OUTPUT variables).
    
    // ---- Examples ----
    
    // Full Path
    RUN C:\apps\Print-User.p(INPUT user.userid).
    
    //// -----------------------------------------------------
    
    // Only App Name (Folder needs to be in PROPATH)
    RUN GenerateEncryptedPassword.p(INPUT fll-psw:SCREEN-VALUE, OUTPUT i_encpass).
    
    //// -----------------------------------------------------
    
    // Open New Window
    RUN UserMaintenance.w.
    // There is only one issue with this... It will trigger an error if you close the main window and them closes the new window
    // To use this on a system, I recommend doing something like that:
    RUN C-Win:VISIBLE = FALSE. // Main Window Object
    RUN UserMaintenance.w.
    RUN C-Win:VISIBLE = TRUE.
    
    // This will make that the user cannot close the main window (or the program) while not on the main window
    
    // Another issue is that 'QUIT.' command WILL CLOSE all of the Windows from the same session.
    
    //// -----------------------------------------------------
    
    // Run program from variable name
    DEF VAR i_path AS CHAR NO-UNDO.
    
    i_path = "C:\apps\Print-User.p".
    i_path = "Print-User.p".
    
    RUN VALUE(i_path)(INPUT ..., OUTPUT...).
````
- Official Docs from [RUN](https://documentation.progress.com/output/ua/OpenEdge_latest/pdsoe/PLUGINS_ROOT/com.openedge.pdt.langref.help/rfi1424920323961.html)

## COMPILE APPS:
From APP Builder - Generate .R files from .P or .W

- APP Builder > Tools *(Top Menu)* > Application Compiler:
  - Options > Compiler... - Choose compiler options - Most important is SAVE INTO folder
  - Add - Add files or folder path to compile queue
  - Start Compile - Compile all apps on queue

## CREATE AND MODIFY DATABASE:
From APP Builder... This is not my field, so I'll give you the basics on how to create <br>
*(Not included INDEX... I've corrupted an DB using this)*<br>

- APP Builder > Tools *(Top Menu)* > Data Dictionary:
  - Database > Create... 
    - Select Folder to save files (.DB and some others)
    - Starts With - Select if it's a blank DB of if it's based on another
    - Create Database
  - Database > Connect *(I'll show how to connect automatically from .PF file)*
    - Select .DB file
    - Select if monouser or not in Advanced Options > ✅ Multiple Users
  - This will load your DB, from there you can create TABLES, FIELDS and INDEX

## CONNECT DATABASE FROM PARAMETER FILE:

### PF Configuration:

Add this command into the PF:
- -db path_to_db -ld nickname connection_type

- Connection Type:
  - Local DB: '-1'
  - Online DB: '-N "number_of_users" -H "server_ip/host_name" -S "service_name" -Mm "maximum_servers"'
    - [More Information](https://docs.progress.com/en-US/bundle/openedge-startup-and-parameter-reference-117/page/Startup-Parameter-Descriptions.html)

### Example:
- -db C:\DB\UserSettings.db -ld UserSettings -1
- -db C:\DB\UserSettings.db -ld UserSettings -N TCP -H 192.168.0.1 -S 80000 -Mm 4096

## RUN CMD COMMANDS:
Run CMD values from Procedures

````progress

    //// Run DOS commands - Only on Windows
    DOS /* [SILENT] */ VALUE(/* VARIABLE or DIRECT COMMAND */).
    // SILENT prevents from appearing CMD window (If not SILENT, will require user to hit spacebar to close CMD)
    
    // ---- Examples ----
    DEF VAR i_command    AS CHAR NO-UNDO.
    DEF VAR i_filePath   AS CHAR NO-UNDO.
    DEF VAR i_moveFileTo AS CHAR NO-UNDO.
    
    // '~' is the escape character from Progress
    i_command = "move ~"" + i_filePath + "~" ~"" + i_moveFileTo + "~"".
    //// DOS: move "C:\logs\21092022.log" "C:\logs\old\"
    // Example command, DOS works with all CMD commands (I've been using this a lot with NETUSE)
    
    DOS SILENT VALUE(i_command).
````
- Official Docs from [DOS](https://docs.progress.com/pt-BR/bundle/openedge-abl-reference-117/page/DOS-statement.html)
- All [DOS COMMANDS](https://en.wikipedia.org/wiki/List_of_DOS_commands)

# Intermediate of Programming!
Apply more advanced tricks to the basics.

## INDEX:
- [Custom .INI File](https://github.com/raphaelfrei/open_edge-guides/tree/main/Programming#custom-ini-file)

## CUSTOM .INI FILE:
.INI file is required to set custom fonts, colors and PROPATH variables. <br>
This is a good option when you have more than one enviroment and need to set some custom settings individually.

### Set up a new .INI File:

Copy the default file from Progress to another folder that you will use. <br>
The location is: ````C:\YOUR_PROGRESS_FOLDER\bin\progress.ini````

### Add .INI File to Shortcut:

Modify your Progress Shortcut and add the -INI parameter - Something like: <br>
````C:\Progress\bin\prowin32.exe -ini "C:\...\DEV\dev.ini" -p _ab.r````

### Editing .INI File:

There are **two ways** to modify the file.

1. Modify by opening the **PRO\*TOOLS** and choose the option that you need (Colors, Fonts, PROPATH). <br>
2. Modify by opening the .INI file with **Notepad**. *(I recommend using this only to change the PROPATH variables, use PRO\*TOOLS to modify everything else instead)*

### What is this file good for?

As [Progress](https://docs.progress.com/pt-BR/bundle/openedge-abl-manage-applications-117/page/Maintaining-the-progress.ini-file.html) said:

````
The progress.ini file specifies environment variable settings for the Windows environment. It contains sections and settings for the following types of options:

1. Options required by OpenEdge
2. Options required by OpenEdge tools (such as the Procedure Editor and the Report Builder)
3. User-defined options
4. Environment variables
````

For pratical uses, if you specify a **.INI** file with **PROPATH** showing the **.W/.R** folder, you don't need to pass the full path when calling the program from shortcut or code itself.<br>
You now only need to pass the program name and it will open the first-find on the **PROPATH** folder.
1. It gives an error if .INI or .W/.R file is not found.
2. If you have more than one file with the same name and in different PROPATH folders, it will open the folder nearest to the beginning of the PROPATH.
