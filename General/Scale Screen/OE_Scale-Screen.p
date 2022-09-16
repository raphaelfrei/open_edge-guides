/* *********************************************
*                                              *
*           Tamanho de Tela Dinâmico           *
*             Resize e Full Screen             *  
*                 Raphael Frei                 *                                     
*                                              *                                               
********************************************* */

/* ----- DEFINITION BLOCK ----- */

DEFINE VARIABLE hCol AS HANDLE NO-UNDO.
DEFINE VARIABLE winState AS INTEGER NO-UNDO.

DEFINE TEMP-TABLE tt_Size NO-UNDO
    FIELD wg_Name   AS CHARACTER
    FIELD wg_Width  AS DECIMAL
    FIELD wg_Height AS DECIMAL
    FIELD wg_Xpos   AS DECIMAL
    FIELD wg_Ypos   AS DECIMAL
    INDEX wg_Name   IS PRIMARY wg_Name.
DEFINE BUFFER bf_Size FOR tt_Size.

/* ----- MAIN BLOCK ----- */

ASSIGN CURRENT-WINDOW:MAX-WIDTH  = SESSION:WIDTH-CHARS
       CURRENT-WINDOW:MAX-HEIGHT = SESSION:HEIGHT-CHARS.

ASSIGN hCol = CURRENT-WINDOW NO-ERROR.

CREATE tt_Size.

ASSIGN tt_Size.wg_Name   = STRING(hCol)
       tt_Size.wg_Width  = hCol:WIDTH-PIXELS
       tt_Size.wg_Height = hCol:HEIGHT-PIXELS
       tt_Size.wg_Xpos   = hCol:X
       tt_Size.wg_Ypos   = hCol:Y 
       NO-ERROR.

/* ----- WINDOW-MAXIMIZED TRIGGER ----- */

ASSIGN winState = 1 NO-ERROR.

ASSIGN hCol = FRAME {&FRAME-NAME}:HANDLE NO-ERROR.

FIND FIRST bf_Size WHERE bf_Size.wg_Name = STRING(CURRENT-WINDOW) NO-ERROR.

IF AVAILABLE bf_Size THEN DO:
    ASSIGN hCol:HEIGHT-PIXELS = (hCol:HEIGHT-PIXELS * CURRENT-WINDOW:HEIGHT-PIXELS) / bf_Size.wg_Height
           hCol:WIDTH-PIXELS  = (hCol:WIDTH-PIXELS  * CURRENT-WINDOW:WIDTH-PIXELS)  / bf_Size.wg_Width 
           NO-ERROR.

    FIND FIRST tt_Size WHERE tt_Size.wg_Name = STRING(hCol) NO-ERROR.

    IF NOT AVAILABLE tt_Size THEN DO:
        CREATE tt_Size.

        ASSIGN tt_Size.wg_Name = STRING(hCol)
               tt_Size.wg_Width = hCol:WIDTH-PIXELS
               tt_Size.wg_Height = hCol:HEIGHT-PIXELS
               tt_Size.wg_xPos = hCol:X
               tt_Size.wg_yPos = hCol:Y 
               NO-ERROR.
    END.

    ASSIGN hCol = hCol:FIRST-CHILD NO-ERROR.
    ASSIGN hCol = hCol:FIRST-CHILD NO-ERROR.

    DO WHILE VALID-HANDLE(hCol):
        FIND FIRST tt_Size WHERE tt_Size.wg_Name = STRING(hCol) NO-ERROR.

        IF NOT AVAILABLE tt_Size THEN DO:
            CREATE tt_Size.

            ASSIGN tt_Size.wg_Name   = STRING(hCol)
                   tt_Size.wg_Width  = hCol:WIDTH-PIXELS
                   tt_Size.wg_Height = hCol:HEIGHT-PIXELS
                   tt_Size.wg_xPos   = hCol:X
                   tt_Size.wg_yPos   = hCol:Y 
                   NO-ERROR.

        END.

        ASSIGN hCol:HEIGHT-PIXELS = (hCol:HEIGHT-PIXELS * CURRENT-WINDOW:HEIGHT-PIXELS) / bf_Size.wg_Height
               hCol:WIDTH-PIXELS  = (hCol:WIDTH-PIXELS  * CURRENT-WINDOW:WIDTH-PIXELS)  / bf_Size.wg_Width
               hCol:X = (hCol:X * CURRENT-WINDOW:WIDTH-PIXELS)  / bf_Size.wg_Width
               hCol:Y = (hCol:Y * CURRENT-WINDOW:HEIGHT-PIXELS) / bf_Size.wg_Height 
               NO-ERROR.

        ASSIGN hCol = hCol:NEXT-SIBLING NO-ERROR.
    END.
END.

/* ----- WINDOW-RESTORED TRIGGER ----- */

IF winState = 3 THEN
    ASSIGN winState = 0 NO-ERROR.

ELSE DO:
    IF winState = 1 THEN DO:
        ASSIGN winState = 0 NO-ERROR.

    END.

    ASSIGN hCol = FRAME {&FRAME-NAME}:HANDLE NO-ERROR.

    FIND FIRST tt_Size WHERE wg_Name = STRING(hCol) NO-ERROR.

    IF AVAILABLE tt_Size THEN DO:
        ASSIGN hCol:HEIGHT-PIXELS = tt_Size.wg_Height
               hCol:WIDTH-PIXELS  = tt_Size.wg_Width
               hCol:X = tt_Size.wg_xPos
               hCol:Y = tt_Size.wg_yPos 
               NO-ERROR.
    END.

    ASSIGN hCol = hCol:FIRST-CHILD NO-ERROR.
    
    ASSIGN hCol = hCol:FIRST-CHILD NO-ERROR.

    DO WHILE VALID-HANDLE(hCol):
        FIND FIRST tt_Size WHERE wg_Name = STRING(hCol) NO-ERROR.

        IF AVAILABLE tt_Size THEN DO:
            ASSIGN hCol:HEIGHT-PIXELS = tt_Size.wg_Height
                   hCol:WIDTH-PIXELS  = tt_Size.wg_Width
                   hCol:X = tt_Size.wg_xPos
                   hCol:Y = tt_Size.wg_yPos 
                   NO-ERROR.

        END.

    ASSIGN hCol = hCol:NEXT-SIBLING NO-ERROR.

    END.
END.

/* ----- WINDOW-MINIMIZED TRIGGER ----- */

ASSIGN winState = 3.

/* ----- WINDOW-RESIZED TRIGGER ----- */

IF winState <> 1 THEN DO:
    FIND FIRST tt_Size WHERE tt_Size.wg_Name = STRING(CURRENT-WINDOW) NO-ERROR.

    IF AVAILABLE tt_Size THEN

        ASSIGN CURRENT-WINDOW:HEIGHT-PIXELS = tt_Size.wg_Height
               CURRENT-WINDOW:WIDTH-PIXELS  = tt_Size.wg_Width
               NO-ERROR.
END.
