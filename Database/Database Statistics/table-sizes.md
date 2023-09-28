# Check Table Sizes with PROUTIL

To get all tables size in a database, you can use the command TABANALYS inside of the PROUTIL.<br>

## Command:
To run this command, you need to use **CMD** or **Progress' PROENV**:<br>
*Is not required to shutdown the database, you can do this online*

### CMD:
````cmd
:: You need to navigate into the BIN folder
CD c:\...\Progress\bin

:: And run the following command:
:: proutil dbname -C tabanalys > output file

:: Replace dbname with the path to your database.db - Including the database, but ommiting the .DB
::    Something like - E:\Data\data_prod\database
:: Replace output file to the output file path
::    Something like - C:\temp\tabanalys.log
:: So, the command will be something like:

proutil E:\Data\data_prod\database -C tabanalys > C:\temp\tabanalys.log
````

### PROENV:
For PROENV, continue running the program without CDing into the BIN folder
````cmd
:: Run the following command:
:: proutil dbname -C tabanalys > output file

:: Replace dbname with the path to your database.db - Including the database, but ommiting the .DB
::    Something like - E:\Data\data_prod\database
:: Replace output file to the output file path
::    Something like - C:\temp\tabanalys.log
:: So, the command will be something like:

proutil E:\Data\data_prod\database -C tabanalys > C:\temp\tabanalys.log
````
