# proot
This repository is an intended living place for my Praat scripts.
## To figure out
* Praat lets define lists: 
    ```
      x[n]=y
    ```
  and 
    ```
      x={a, b, ...}
    ``` 
  But I don't yet know whether I can define a function that will take these objects as input and return the number of 
  elements they contain.
  This exists for strings:
    ```
     a$="test"
     writeInfoLine: length(a$)
    ```
* Ultimately, I'd like the user to be able to specify a list of keywords, and the script to match those keywords in textgrid
  labels.
  For example: "Praat, extract those labels that include the string "Eek" and the string "vowelquality".
  All of this without the need for listing the keywords in an array within the code itself.
