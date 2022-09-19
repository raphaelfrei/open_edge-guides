# Export Table Contents to CSV
Create custom CSV records based on tables.

### How To Use:
- Edit EXPORT PROCEDURE database call to your current database:
  - Like *'i_topdata'* for details from the report;
  - First *EXPORT DELIMITER* to the name of the fields; *(Not the field itself, like the NAME header from the field firstname)*
  - Edit FOR EACH block to your table;
  - Second *EXPORT DELIMITER* to the fields from the table; *(Matching the first EXPORT)*

Code:

````progress
// Responsable to create new lines into the file
CHR(13)

//You can use this to ask the user to select the output folder:
SYSTEM-DIALOG GET-FILE i_filepath
            FILTERS "CSV (Comma delimited) (*.csv)" "*.csv"
            INITIAL-FILTER 1
            ASK-OVERWRITE
            SAVE-AS
            TITLE "Export Report"
            DEFAULT-EXTENSION ".csv"
            UPDATE OKPressed.
````
