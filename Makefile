.PHONY: ctan manual tex

VERSION = 2.7-dev

ctan: manual tex
	mkdir phonenumbers
	cp README.ctan phonenumbers/README
	mkdir phonenumbers/doc
	cp doc/Literatur.bib phonenumbers/doc/
	cp doc/phonenumbers-de.pdf phonenumbers/doc/
	cp doc/phonenumbers-de.tex phonenumbers/doc/
	cp doc/phonenumbers-en.pdf phonenumbers/doc/
	cp doc/phonenumbers-en.tex phonenumbers/doc/
	mkdir phonenumbers/tex
	cp tex/phonenumbers.sty phonenumbers/tex/
	cp tex/phonenumbers-*.def phonenumbers/tex/
	zip -r phonenumbers.zip phonenumbers
	rm -r phonenumbers

manual:
	cd doc && mpost Telefonhoerer
	cd doc && mpost Britische_Zelle
	cd doc && mpost Titelbild-de.mp
	cd doc && mpost Titelbild-en.mp
	cd doc && lualatex phonenumbers-de.tex
	cd doc && lualatex phonenumbers-en.tex
	cd doc && biber phonenumbers-de
	cd doc && biber phonenumbers-en
	cd doc && mpost Titelbild-de.mp
	cd doc && mpost Titelbild-en.mp
	cd doc && lualatex phonenumbers-de.tex
	cd doc && lualatex phonenumbers-en.tex
	cd doc && lualatex phonenumbers-de.tex
	cd doc && lualatex phonenumbers-en.tex

define write-locale-module =
echo "% phonenumbers package: phonenumbers-$1.def" > $@
echo "% Module for $2 telephone numbers" >> $@
echo "% Author: K. Wehr" >> $@
echo "% Version: $(VERSION)" >> $@
echo "% Date: `date -I`" >> $@
printf "\\clist_const:Nn \\c_phone_$1_ortsvorwahlen_clist {" >> $@
sed -e "s/\t.*/,/" -e "$$ s/,/}/" < data/geographic-area-codes-$1.csv >> $@
if [ ! -z "$3" ]; then\
  printf "\\clist_const:Nn \\c_phone_$1_obligatorische_ortsvorwahlen_clist {" >> $@;\
  grep -P "^[^\t]*\t[^\t]*\t$3(\t|$$)" < data/geographic-area-codes-$1.csv | sed -e "s/\t.*/,/" -e "$$ s/,/}/" >> $@;\
fi
printf "\\clist_const:Nn \\c_phone_$1_sondervorwahlen_clist {" >> $@
sed -e "s/\t.*/,/" -e "$$ s/,/}/" < data/non-geographic-area-codes-$1.csv >> $@
cut -f 1,2 < data/geographic-area-codes-$1.csv | sed "s/\([^t]*\)\t\(.*\)/\\\tl_const:cn {c_phone_$1_ortsname_\1_tl} {\2}/" >> $@
cut -f 1,2 < data/non-geographic-area-codes-$1.csv | sed "s/\([^t]*\)\t\(.*\)/\\\tl_const:cn {c_phone_$1_ortsname_\1_tl} {\2}/" >> $@
echo >> $@ # empty line
cat tex/tex-code-$1.def >> $@
endef

tex/phonenumbers-AT.def: data/geographic-area-codes-AT.csv data/non-geographic-area-codes-AT.csv tex/tex-code-AT.def
	$(call write-locale-module,AT,Austrian)

tex/phonenumbers-DE.def: data/geographic-area-codes-DE.csv data/non-geographic-area-codes-DE.csv tex/tex-code-DE.def
	$(call write-locale-module,DE,German)

tex/phonenumbers-FR.def: data/geographic-area-codes-FR.csv data/non-geographic-area-codes-FR.csv tex/tex-code-FR.def
	$(call write-locale-module,FR,French)

tex/phonenumbers-UK.def: data/geographic-area-codes-UK.csv data/non-geographic-area-codes-UK.csv tex/tex-code-UK.def
	$(call write-locale-module,UK,British,national)

tex/phonenumbers-US.def: data/geographic-area-codes-US.csv data/non-geographic-area-codes-US.csv tex/tex-code-US.def
	$(call write-locale-module,US,North American,10D)

tex: tex/phonenumbers-AT.def tex/phonenumbers-DE.def tex/phonenumbers-FR.def tex/phonenumbers-UK.def tex/phonenumbers-US.def
