% phonenumbers.mp
% Metapost-Graphik
% Aufmacher-Bild zum Paket PHONENUMBERS
% 19. Oktober 2016

outputformat := "png";
outputtemplate := "%j.png";

f = 1; % Vergrößerungsfaktor

H = f*200; % Höhe
B = f*600; % Breite

input ../metapost/Telefonhörer
input ../metapost/Telefonzelle
input ../metapost/Wählscheibe

beginfig(1);

fill (0,0)--(B,0)--(B,H)--(0,H)--cycle withcolor white;

telefonzelle(f,0.015B,0.00H);
telefonhoerer(f,0.43B,0.5515H);
waehlscheibe(f,0.83B,0.5H);

endfig;
end
