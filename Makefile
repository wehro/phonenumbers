.PHONY: ctan manual

ctan: manual
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
