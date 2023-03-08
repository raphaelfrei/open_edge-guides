# Restore BKP File from Database
Use **CMD** or **Progress** to restore **BKP File**.<br>

## The code submitted is a procedure, that requires three parameters:
1. BKP file location. *(Requires **.ST** file in the same folder)* <br>
1.1. ST is only required for DBs with more than 1 .D file
2. Place to restore. <br>
3. Output LOG location. <br>

## For .BAT File:
1. Change DB path.<br>
2. Change PATH path.<br>

## How To Use:
Create a Task Scheduler to perform this backup every *x* days.<br>
Add this into your own program.<br>

**Don't forget to shutdown database before replacing with the backup!**
