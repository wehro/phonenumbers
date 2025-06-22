The phonenumbers package is a LaTeX package for typesetting telephone numbers.

The package is available on CTAN: https://ctan.org/pkg/phonenumbers

The latest changes can be found at the end of the manual.

# Makefile

All files needed for the CTAN package are created by the Makefile.

Run `make manual` to get the English and the German manual as PDF files in the `doc` directory.

Run `make tex` to get the files needed by TeX in the `tex` directory. For local tests move all files `tex/phonenumbers*` to a place where TeX can find them, e. g. `TEXMFHOME/tex/latex/phonenumbers/`.

Run `make ctan` to create a ZIP archive `phonenumbers.zip` for CTAN upload.

# Contributions

If you want to contribute support for the telephone numbers of a further country, try to perform some of the following steps:

1. Look for the relevant documents of your national telecommunications authority: there should at least be a list of area codes/dialling codes (geographic and non-geographic, where non-geographic mainly means mobile phone numbers) and a document describing the the structure and the possible lengths (number of digits) of the phone numbers. This document might be called National Numbering Plan or similar.

2. Look for further sources containing useful information concerning the telephone numbers of your country, e. g. Wikipedia articles.

3. Add the documents to the file `doc/references.bib`, which contains the references used in the manual.

4. Prepare CSV files (tab-separated) containing the area codes and their meanings based on the model of the files in the `data` directory. Replace spaces occuring in place names and other descriptions by tilde signs.

5. If you know some expl3, prepare the TeX code for your country, which has to define commands for testing if a given number is valid according to the national rules and commands for outputting numbers according to a national structuring scheme. Look for a country with similar rules which is already supported, copy the corresponding `tex/tex-code-XY.def` file, and adapt it for your country.

6. If you know some expl3, make the necessary changes in the main package code `tex/tex-code-main.def`.

7. Make the necessary changes in the Makefile.

8. Add a new chapter for your country to the manual `doc/manual-en.tex` based on the existing chapters for other countries. Please try to use reserved numbers not in real use (drama numbers) for the documentation if possible.

9. If you know German, translate the documentation to German and add it to the file `doc/manual-de.tex`.

10. Fork the repository and create a pull request or send the files by email to the package maintainer using the address given in the manual.
