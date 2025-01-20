# Pure4GLTV - Fix Error 13712 on Progress 64 bits.

To fix this error:

1. Open ````pure4gltv.w````;
2. Open ````EXTERNALPROCEDURES```` procedure;
3. Procedure ````GetKeyboardEvents````, rename all ````LONG```` references to ````INT64````:

### OLD:

````java
PROCEDURE GetKeyboardState EXTERNAL "user32.dll":
   DEFINE INPUT  PARAMETER KBState AS LONG. /* memptr */
&IF DEFINED(APIRtnParm) &THEN
   DEFINE RETURN PARAMETER RetVal  AS LONG. /* bool   */
&ENDIF
````

### NEW:
````java
PROCEDURE GetKeyboardState EXTERNAL "user32.dll":
   DEFINE INPUT  PARAMETER KBState AS INT64. /* memptr */
&IF DEFINED(APIRtnParm) &THEN
   DEFINE RETURN PARAMETER RetVal  AS INT64. /* bool   */
&ENDIF
````
