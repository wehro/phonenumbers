%%%%%%%%%% WÄHLSCHEIBE %%%%%%%%%%

def waehlscheibe(expr V,x,y) =

WSIR = V*52; % Innenradius der Wählscheibe
WSAR = V*90; % Außenradius der Wählscheibe

transform WSV; % Verschiebung der Wählscheibe
WSV = identity shifted (x,y);

fill fullcircle scaled 2WSAR transformed WSV withcolor 0.3white;
fill fullcircle scaled 2WSIR transformed WSV withcolor 0.1white;

pickup pencircle scaled 1.5bp;
draw fullcircle scaled (2WSAR+3bp) transformed WSV;
draw fullcircle scaled 2WSAR transformed WSV withcolor 0.5white;
draw fullcircle scaled 2WSIR transformed WSV withcolor 0.5white;

pair WSZKP; % Wählscheibenziffernkreisposition

pickup pencircle scaled 1bp;

for i=1 upto 10:
	WSZKP := (0,0.5[WSIR,WSAR]) rotated ((i-2)*180/7) transformed WSV;
	fill fullcircle scaled 0.32WSAR shifted WSZKP;
	draw fullcircle scaled 0.32WSAR shifted WSZKP withcolor 0.5white;
	if i=10: label("0" infont "rm-qhvr" scaled (V*2.0),WSZKP)
	else: label(decimal i infont "rm-qhvr" scaled (V*2.0),WSZKP) fi withcolor white;
endfor

pair P[];
P1 = (0,-0.9WSIR) rotated 45 transformed WSV;
P2 = (0,-1.05WSAR) rotated 45 transformed WSV;
P3 = (0,-1.05WSAR) rotated 55 transformed WSV;
P4 = (0,-0.9WSIR) rotated 55 transformed WSV;
fill P1--P2--P3--P4--cycle;

enddef;
