# File Encryption and Decryption with Progress 4GL

Function to encrypt and decrypt files with Progress 4GL - This works with any file extension.

## How to Use:

The program has two modes:
1. Encrypt file
2. Decrypt file

To call the program:

````
RUN Func-File-DeEncrypt.p(INPUT 0,         // Program mode - 1 for ENCRYPT, 2 for DECRYPT
                          INPUT "",        // Input file
                          INPUT "",        // Output file
                          OUTPUT logical,  // TRUE if suceeds, FALSE if any errors
                          OUTPUT character // Error description if available
                          ).
````

## How it Works:

### Encryption:

It takes the bytes from the file and encrypts with BASE-64 encoding.<br>
It calculates the HASH from the file with MD5 and appends the value at end of file.<br>
After this, it calculates how many digits the hash code have and append to the end of file, on format ````"999999"````.

### Decryption:

Separate the file into three variables:
> 1. Hash code size;
> 2. File content;
> 3. Hash code

With this, encodes the ````VAR 2```` with MD5 and verifies if it's the same as ````VAR3````.<br>
If TRUE, output the file to the variable specified on calling the program.

## Result:

If succeeds, return ````TRUE```` and ````FILE ENCRYPTED/DECRYPTED````, otherwhise returns ````FALSE```` and ````error_info````.
