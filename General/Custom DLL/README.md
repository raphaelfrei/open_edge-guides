# How to Use Custom DLLs into Progress
Once you get into Progress, you'll notice that some external integrations into the app are kinda buggy.<br>
I had some issues when trying to set up [my DLL](https://github.com/raphaelfrei/open_edge-guides/tree/main/Password%20and%20Encryption/Microsoft%20Azure%20Login) to work, and with this procedure I've managed to get it working.

### How To Use:
- **1st:** Copy the DLL into the bin folder *(In my case - **C:\dlc117\bin**)*;<br>
- **2st:** Create an **assemblies.xml** file with the **ProAsmRef** app *(Located into **bin** folder too)*;<br>
- **3st:** This was when I started having issues with the DLL. You're gonna need to make some tests to check on which folder Progress will read the **assemblies.xml** file. Those 3 are the folders that I needed to copy the XML:
    - 'C:\dlc117\bin\'
    - 'C:\dlc117\'
    - 'C:\dlc117w\'
    - If none works, try copying the file into other folders and test.
    
To run the DLL from your code, do this:
````progress
// DLL created with C# on VS Studio
NAMESPACE.CLASS:METHOD(INPUT PARAMETERS).

// If the method returns any value, you can set it to a variable...
DEF VAR i_status AS CHAR NO-UNDO.
i_status = NAMESPACE.CLASS:METHOD(INPUT).

// Example with my custom DLL (Link above):
i_status = RF.CONTROL:AzureLogin(i_user, i_pass, i_domn).
````
