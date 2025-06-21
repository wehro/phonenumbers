.PHONY: ctan manual tex

VERSION = 2.7-dev

define write-manual =
echo "% phonenumbers package: phonenumbers-$1.tex" > doc/phonenumbers-$1.tex
echo "% $2 manual" >> doc/phonenumbers-$1.tex
echo "% Author: K. Wehr" >> doc/phonenumbers-$1.tex
echo "% Version: $(VERSION)" >> doc/phonenumbers-$1.tex
echo "% Date: `date -I`" >> doc/phonenumbers-$1.tex
cat doc/manual-$1.tex >> doc/phonenumbers-$1.tex
endef

define write-title =
sed -e "s/LANG/$2/" \
-e "s/TITLE/$3/" \
-e "s/VERSION/$(VERSION)/" \
-e "s/DATE/`date -I`/" < doc/title.mp > doc/title-$1.mp
endef

manual:
	echo "% phonenumbers package: phonenumbers.bib" > doc/phonenumbers.bib
	echo "% References for the manual" >> doc/phonenumbers.bib
	echo "% Author: K. Wehr" >> doc/phonenumbers.bib
	echo "% Version: $(VERSION)" >> doc/phonenumbers.bib
	echo "% Date: `date -I`" >> doc/phonenumbers.bib
	cat doc/references.bib >> doc/phonenumbers.bib
	cd doc && mpost receiver
	cd doc && mpost british-phone-box
	$(call write-title,de,ngerman,Setzen von Telefonnummern mit)
	cd doc && mpost title-de.mp
	cd doc && mpost title-de.mp
	$(call write-title,en,UKenglish,Typesetting telephone numbers with)
	cd doc && mpost title-en.mp
	cd doc && mpost title-en.mp
	$(call write-manual,de,German)
	cd doc && lualatex phonenumbers-de.tex
	cd doc && biber phonenumbers-de
	cd doc && lualatex phonenumbers-de.tex
	cd doc && lualatex phonenumbers-de.tex
	$(call write-manual,en,English)
	cd doc && lualatex phonenumbers-en.tex
	cd doc && biber phonenumbers-en
	cd doc && lualatex phonenumbers-en.tex
	cd doc && lualatex phonenumbers-en.tex

define write-locale-module =
echo "% phonenumbers package: phonenumbers-$1.def" > tex/phonenumbers-$1.def
echo "% Module for $2 telephone numbers" >> tex/phonenumbers-$1.def
echo "% Author: K. Wehr" >> tex/phonenumbers-$1.def
echo "% Version: $(VERSION)" >> tex/phonenumbers-$1.def
echo "% Date: `date -I`" >> tex/phonenumbers-$1.def
printf "\\clist_const:Nn \\c_phone_$1_ortsvorwahlen_clist {" >> tex/phonenumbers-$1.def
sed -e "s/\t.*/,/" -e "$$ s/,/}/" < data/geographic-area-codes-$1.csv >> tex/phonenumbers-$1.def
if [ ! -z "$3" ]; then\
  printf "\\clist_const:Nn \\c_phone_$1_obligatorische_ortsvorwahlen_clist {" >> tex/phonenumbers-$1.def;\
  grep -P "^[^\t]*\t[^\t]*\t$3(\t|$$)" < data/geographic-area-codes-$1.csv | sed -e "s/\t.*/,/" -e "$$ s/,/}/" >> tex/phonenumbers-$1.def;\
fi
printf "\\clist_const:Nn \\c_phone_$1_sondervorwahlen_clist {" >> tex/phonenumbers-$1.def
sed -e "s/\t.*/,/" -e "$$ s/,/}/" < data/non-geographic-area-codes-$1.csv >> tex/phonenumbers-$1.def
cut -f 1,2 < data/geographic-area-codes-$1.csv | sed "s/\([^t]*\)\t\(.*\)/\\\tl_const:cn {c_phone_$1_ortsname_\1_tl} {\2}/" >> tex/phonenumbers-$1.def
cut -f 1,2 < data/non-geographic-area-codes-$1.csv | sed "s/\([^t]*\)\t\(.*\)/\\\tl_const:cn {c_phone_$1_ortsname_\1_tl} {\2}/" >> tex/phonenumbers-$1.def
echo >> tex/phonenumbers-$1.def # empty line
cat tex/tex-code-$1.def >> tex/phonenumbers-$1.def
endef

tex:
	echo "% phonenumbers package: phonenumbers.sty" > tex/phonenumbers.sty
	echo "% LaTeX package for formatting telephone numbers" >> tex/phonenumbers.sty
	echo "% Author: K. Wehr" >> tex/phonenumbers.sty
	echo "% Version: $(VERSION)" >> tex/phonenumbers.sty
	echo "% Date: `date -I`" >> tex/phonenumbers.sty
	echo "% This work may be distributed and/or modified under the" >> tex/phonenumbers.sty
	echo "% conditions of the LaTeX Project Public License, either version 1.3" >> tex/phonenumbers.sty
	echo "% of this license or (at your option) any later version." >> tex/phonenumbers.sty
	echo "% The latest version of this license is in" >> tex/phonenumbers.sty
	echo "%   https://www.latex-project.org/lppl.txt" >> tex/phonenumbers.sty
	echo "% and version 1.3c or later is part of all distributions of LaTeX" >> tex/phonenumbers.sty
	echo "% version 2008 or later." >> tex/phonenumbers.sty
	echo "\\NeedsTeXFormat{LaTeX2e}[2022-06-01]" >> tex/phonenumbers.sty
	echo "\\ProvidesExplPackage {phonenumbers} {`date -I`} {$(VERSION)} {Telephone number package}" >> tex/phonenumbers.sty
	cat tex/tex-code-main.def >> tex/phonenumbers.sty
	$(call write-locale-module,AT,Austrian)
	$(call write-locale-module,DE,German)
	$(call write-locale-module,FR,French)
	$(call write-locale-module,UK,British,national)
	$(call write-locale-module,US,North American,10D)

ctan: manual tex
	mkdir phonenumbers
	LANG=en_GB.UTF-8 && sed -e "s/VERSION/$(VERSION)/" -e "s/DATE/`date +'%-d %B %Y'`/" < README.ctan > phonenumbers/README
	mkdir phonenumbers/doc
	cp doc/phonenumbers.bib phonenumbers/doc/
	cp doc/phonenumbers-de.pdf phonenumbers/doc/
	cp doc/phonenumbers-de.tex phonenumbers/doc/
	cp doc/phonenumbers-en.pdf phonenumbers/doc/
	cp doc/phonenumbers-en.tex phonenumbers/doc/
	mkdir phonenumbers/tex
	cp tex/phonenumbers.sty phonenumbers/tex/
	cp tex/phonenumbers-*.def phonenumbers/tex/
	zip -r phonenumbers.zip phonenumbers
	rm -r phonenumbers
