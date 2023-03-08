@ECHO OFF

::::::::::::::::::::::::::::::::::::::::::::::::::
::                                              ::
::    Script to Restore BKP from Progress DB    ::
::                                              ::
::              Raphael Frei - 2023             ::     
::                                              ::
::           www.github.com/raphaelfrei         ::
::                                              ::
::::::::::::::::::::::::::::::::::::::::::::::::::

:: Get today's date
FOR /F "tokens=1-4 delims=/ " %%i IN ('date /t') DO SET TDate=%%k%%j%%i

:: Variables information
SET DLC=C:\dlc117
SET BKP_LOCATION=E:\backup
SET DBS_NAME=sports2000
SET DBS_LOCATION=E:\LIVE\DATA
SET LOG_LOCATION=E:\temp\restore_%DBS_NAME%.log

ECHO.                                      >> %LOG_LOCATION%
ECHO. %TDate% - RESTORING BACKUP... ------ >> %LOG_LOCATION%

:: IF the database is running, shut it down - .LK file means it's running
IF EXIST %DBS_LOCATION%\%DBS_NAME%.lk CALL %DLC%\bin\proshut %DBS_LOCATION%\%DBS_NAME%.db -by >> %LOG_LOCATION%

:: Copy .ST to make sure there is no problem restoring
COPY %BKP_LOCATION%\*.st %DBS_LOCATION%\ >> %LOG_LOCATION%

:: Call PROREST to restore BKP
CALL %DLC%\bin\prorest %DBS_LOCATION%\%DBS_NAME% %BKP_LOCATION%\%DBS_NAME%.bkp >> %LOG_LOCATION%

ECHO.                                   >> %LOG_LOCATION%
ECHO. %TDate% - BACKUP RESTORED! ------ >> %LOG_LOCATION%