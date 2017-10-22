%%%%%%%%%% TELEFONZELLE %%%%%%%%%%

def telefonzelle(expr Vergr,Verschx,Verschy) =

TZB=Vergr*76; % Telefonzellenbreite
TZRH=2.1TZB; % Telefonzellenrechteckhöhe
TZAH=0.19TZB; % Telefonzellenaufsatzhöhe
TZAE=0.05TZB; % Telefonzellenaufsatzeinschnürung
TZTH=0.7TZAH; % Telefonzellentextfeldhöhe
TZTB=0.74TZB; % Telefonzellentextfeldbreite
TZBH=0.26TZB; % Telefonzellenbogenhöhe
TZBB=0.05TZB; % Telefonzellenbogenbasis
TZFB=0.18TZB; % Telefonzellenfensterbreite
TZFH=0.11TZRH; % Telefonzellenfensterhöhe
TZFA=0.025TZB; % Telefonzellenfensterabstand

transform TZV; % Telefonzellenverschiebung
TZV = identity shifted (Verschx,Verschy);

fill (0,0)--(TZB,0)--(TZB,TZRH)--(TZB-TZAE,TZRH)--(TZB-TZAE,TZRH+TZAH)--(TZB,TZRH+TZAH)--(TZB,TZRH+TZAH+TZBB){(-4,3)}..(0.5TZB,TZRH+TZAH+TZBH)..{(-4,-3)}(0,TZRH+TZAH+TZBB)--(0,TZRH+TZAH)--(TZAE,TZRH+TZAH)--(TZAE,TZRH)--(0,TZRH)--cycle transformed TZV withcolor (0.8,0.05,0.05);
for i=0 upto 2:
	for j=0 upto 5:
		x1 := 0.5TZB-TZFA-1.5TZFB+i*(TZFB+TZFA);
		y1 := 0.18TZRH+j*(TZFH+TZFA);
		x2 := x1+TZFB;
		y2 := y1+TZFH;
		fill (x1,y1)--(x2,y1)--(x2,y2)--(x1,y2)--cycle transformed TZV withcolor 0.6white;
	endfor
endfor

x1 := 0.5TZB-0.5TZTB;
y1 := TZRH+0.5TZAH-0.5TZTH;
x2 := x1+TZTB;
y2 := y1+TZTH;
fill (x1,y1)--(x2,y1)--(x2,y2)--(x1,y2)--cycle transformed TZV withcolor 0.85white;
label("TELEPHONE" infont "LinBiolinumT-tlf-t1" scaled Vergr,(0.5TZB,TZRH+0.5TZAH)) transformed TZV;

enddef;
