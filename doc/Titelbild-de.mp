% phonenumbers package: German title picture
% Datum: 6. Mai 2025
outputtemplate := "%j.mps";

input latexmp;
input textpath;
input ../metapost/Wählscheibe;

color Telefonfarbe;
Telefonfarbe = (0.06,0.44,0.08);

setupLaTeXMP(packages="textpathmp,metalogo,tgbonum,isodate[ngerman]",
preamble="\setlogokern{La}{-0.21em}\setlogokern{aT}{0em}\setlogodrop{0.6ex}\newcommand*{\sperren}[1]{\sodef\sperrtext{}{1bp}{0.4em}{0.4em}\sperrtext{#1}}");

labeloffset := 3mm;

beginfig(1);

path HK[];
HK1 = reverse halfcircle scaled 10.5cm;
HK2 = halfcircle scaled 12cm rotated 180;

draw textpathRaw("\fontsize{45}{45}\selectfont\sperren{PHONENUMBERS}",HK1,0.5) withcolor Telefonfarbe;
draw textpathRaw("\fontsize{24}{24}\selectfont\sperren{Setzen von Telefonnummern mit} {\LaTeX}",HK2,0.5);

waehlscheibe(1.4,0,0);

label.top(textext("\fontsize{17}{17}\selectfont Version 2.6"),origin) withcolor white;
label.bot(textext("\fontsize{12}{12}\selectfont\today"),origin) withcolor white;

endfig;

end
