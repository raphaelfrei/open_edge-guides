@echo off

::::::::::::::::::::::::::::::::::::::::::::::::::
::                                              ::
::  Script to Perform a backup on Progress DBs  ::
::                                              ::
::              Raphael Frei - 2023             ::     
::                                              ::
::           www.github.com/raphaelfrei         ::
::                                              ::
::::::::::::::::::::::::::::::::::::::::::::::::::

SET DLC=C:\Progress
SET PATH=%PATH%;%DLC%\bin;%DLC%

SET DB_NAME=sports2000
SET DB_PATH=E:\Live\Database\db\%DB_NAME%
SET BKP_PATH=E:\Backup\db

echo probkup.bat online %DBPATH% %BKPPATH%\%DB_NAME%
call probkup.bat online %DBPATH% %BKPPATH%\%DB_NAME%.bkp