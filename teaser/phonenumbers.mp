% phonenumbers.mp
% Metapost-Graphik
% Aufmacher-Bild zum Paket PHONENUMBERS
% 19. Oktober 2016

outputformat := "png";
outputtemplate := "%j.png";

beginfig(1);

f = 1; % Vergrößerungsfaktor

H = f*200; % Höhe
B = f*600; % Breite


%%%%%%%%%% WÄHLSCHEIBE %%%%%%%%%%

transform WSV; % Verschiebung der Wählscheibe
WSV = identity shifted (0.83B,0.5H);

WSIR = 0.26H; % Innenradius der Wählscheibe
WSAR = 0.45H; % Außenradius der Wählscheibe

pair KP; % Kreisposition

fill (0,0)--(B,0)--(B,H)--(0,H)--cycle withcolor white;
fill fullcircle scaled 2WSAR transformed WSV withcolor 0.3white;
fill fullcircle scaled 2WSIR transformed WSV withcolor 0.1white;
for i=1 upto 10:
	KP := (0,0.5[WSIR,WSAR]) rotated ((i-2)*180/7) transformed WSV;
	fill fullcircle scaled 0.14H shifted KP;
	if i=10: label("0" infont "cs-qhvr" scaled 2.0f,KP)
	else: label(decimal i infont "cs-qhvr" scaled 2.0f,KP) fi withcolor white;
endfor

z1 = (0,-0.9WSIR) rotated 45 transformed WSV;
z2 = (0,-1.05WSAR) rotated 45 transformed WSV;
z3 = (0,-1.05WSAR) rotated 55 transformed WSV;
z4 = (0,-0.9WSIR) rotated 55 transformed WSV;
fill z1--z2--z3--z4--cycle;


%%%%%%%%%% TELEFONHÖHRER %%%%%%%%%%

transform HT; % Hörertransformation
HT = identity rotated 20 shifted (0.43B,0.55H);
HHL = 0.5H; % Hörerhalblänge
HR = 0.2H; % Hörerradius
HB = 0.15H; % Hörerbreite
HLR = 0.017H; % Hörerlochradius
HKB = 0.03H; % Hörerkabelbreite
HWB = 0.06H; % Hörerwendelbreite

transform HKT; % Hörkreistransformation
HKT = identity shifted (HHL,0) transformed HT;

transform SKT; % Sprechkreistransformation
SKT = identity shifted (-HHL,0) transformed HT;

penpos.KA(HKB,-60); % Kabelanfang
penpos.KE(HKB,0); % Kabelende
z.KA=(-HHL-0.95HR,0) transformed HT;
z.K1=(0.27B,0.08H);
z.K2=(0.54B,0.22H);
z.KE=(0.64B,1/2HKB);
pickup pencircle scaled 0.3HKB;
path Kabel;
Kabel = (z.KA+0.1H*dir(195))..z.K1..z.K2..{down}z.KE;
pos := 0;
for i=1 upto 35:
  penpos.Ko[i](HKB,angle(direction pos of Kabel));
  penpos.Ku[i](HKB,angle(direction pos of Kabel));
  z.Ko[i] = point pos of Kabel+(0,1/2HWB) rotated angle(direction pos of Kabel);
  z.Ku[i] = z.Ko[i]+(0,-HWB) rotated angle(direction pos of Kabel);
  if i <= 8: pos := pos+1/8;
  else: if i <= 26: pos := pos+1/18;
  else: if i <= 28: pos := pos+0.11;
  else: if i <= 30: pos := pos+0.12;
  else: pos := pos+0.135; fi fi fi fi
endfor
penstroke z.KA.e--z.Ku[1].e;
for i=1 upto 35:
  if i>1: penstroke z.Ko[i].e--z.Ku[i].e; fi
  if i<35: penstroke z.Ku[i].e--z.Ko[i+1].e; fi
endfor
%pickup pencircle scaled 3;
%draw Kabel;
%pickup pencircle scaled 5;
%drawdot z.K1;
%drawdot z.K2;

fill fullcircle scaled 2HR transformed SKT;
fill fullcircle scaled 2HR transformed HKT;
fill (-HHL,HR)..(0,0.5HB)..(HHL,HR)--(HHL,-HR)..(0,-0.5HB)..(-HHL,-HR)--cycle transformed HT;
fill fullcircle scaled HLR transformed HKT withcolor white;
for i=0 upto 5: fill fullcircle scaled HLR shifted (0.2HR,0) rotated (i*60) transformed HKT withcolor white; endfor
fill fullcircle scaled HLR transformed SKT withcolor white;
for i=0 upto 5: fill fullcircle scaled HLR shifted (0,0.2HR) rotated (i*60) transformed SKT withcolor white; endfor
for i=0 upto 11: fill fullcircle scaled HLR shifted (0,0.4HR) rotated (i*30) transformed SKT withcolor white; endfor
for i=0 upto 17: fill fullcircle scaled HLR shifted (0,0.6HR) rotated (i*20) transformed SKT withcolor white; endfor


%%%%%%%%%% TELEFONZELLE %%%%%%%%%%

TZB=0.38H; % Telefonzellenbreite
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
TZV = identity shifted (0.015B,0.00H);

fill (0,0)--(TZB,0)--(TZB,TZRH)--(TZB-TZAE,TZRH)--(TZB-TZAE,TZRH+TZAH)--(TZB,TZRH+TZAH)--(TZB,TZRH+TZAH+TZBB){(-4,3)}..(0.5TZB,TZRH+TZAH+TZBH)..{(-4,-3)}(0,TZRH+TZAH+TZBB)--(0,TZRH+TZAH)--(TZAE,TZRH+TZAH)--(TZAE,TZRH)--(0,TZRH)--cycle transformed TZV withcolor (0.8,0.05,0.05);
for i=0 upto 2: for j=0 upto 5:
x1 := 0.5TZB-TZFA-1.5TZFB+i*(TZFB+TZFA);
y1 := 0.18TZRH+j*(TZFH+TZFA);
x2 := x1+TZFB;
y2 := y1+TZFH;
fill (x1,y1)--(x2,y1)--(x2,y2)--(x1,y2)--cycle transformed TZV withcolor 0.6white;
endfor endfor
x1 := 0.5TZB-0.5TZTB;
y1 := TZRH+0.5TZAH-0.5TZTH;
x2 := x1+TZTB;
y2 := y1+TZTH;
fill (x1,y1)--(x2,y1)--(x2,y2)--(x1,y2)--cycle transformed TZV withcolor 0.85white;
label("TELEPHONE" infont "LinBiolinumT-tlf-ot1--base" scaled 1.0f,(0.5TZB,TZRH+0.5TZAH)) transformed TZV;

endfig;
end
