%%%%%%%%% TELEFONHÖHRER %%%%%%%%%%

def telefonhoerer(expr V,x,y) =

HHL = V*100; % Hörerhalblänge
HR = 0.4HHL; % Hörerradius
HB = 0.3HHL; % Hörerbreite
HLR = 0.034HHL; % Hörerlochradius
HKB = 0.06HHL; % Hörerkabelbreite
HWB = 0.12HHL; % Hörerwendelbreite
HDR = 20; % Hörerdrehwinkel

transform HT; % Hörertransformation
HT = identity rotated HDR shifted (x,y);

penpos.KA(HKB,-80+HDR); % Kabelanfang
z.KA=(-HHL-0.95HR,0) transformed HT;
z.K1=((-HHL-0.95HR,0)+0.2HHL*dir(175)) transformed HT;
z.K2=(-1.22HHL,-0.56HHL) transformed HT;
z.K3=(0.39HHL,-0.85HHL) transformed HT;
z.KE=(0.82HHL,-1.44HHL) transformed HT; % Kabelende

%pickup pencircle scaled 0.3HKB;

path Kabel;
Kabel = z.K1..z.K2..z.K3..{dir(-110+HDR)}z.KE;

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

fill (-HHL,HR)..(0,0.5HB)..(HHL,HR)--(HHL,-HR)..(0,-0.5HB)..(-HHL,-HR)--cycle transformed HT;

transform HKT; % Hörkreistransformation
HKT = identity shifted (HHL,0) transformed HT;

fill fullcircle scaled 2HR transformed HKT;
fill fullcircle scaled HLR transformed HKT withcolor white;
for i=0 upto 5: fill fullcircle scaled HLR shifted (0.2HR,0) rotated (i*60) transformed HKT withcolor white; endfor

transform SKT; % Sprechkreistransformation
SKT = identity shifted (-HHL,0) transformed HT;

fill fullcircle scaled 2HR transformed SKT;
fill fullcircle scaled HLR transformed SKT withcolor white;
for i=0 upto 5: fill fullcircle scaled HLR shifted (0,0.2HR) rotated (i*60) transformed SKT withcolor white; endfor
for i=0 upto 11: fill fullcircle scaled HLR shifted (0,0.4HR) rotated (i*30) transformed SKT withcolor white; endfor
for i=0 upto 17: fill fullcircle scaled HLR shifted (0,0.6HR) rotated (i*20) transformed SKT withcolor white; endfor

enddef;
