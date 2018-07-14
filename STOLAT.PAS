program stolat;
uses crt;
const
c1=33;
c2=65;
c3=131;
c4=262;
c5=523;
c6=1047;
c7=2093;
d1=37;
d2=73;
d3=147;
d4=294;
d5=587;
d6=1175;
d7=2349;
e1=41;
e2=82;
e3=165;
e4=330;
e5=659;
e6=1319;
e7=2637;
f1=44;
f2=87;
f3=175;
f4=349;
f5=698;
f6=1397;
f7=2794;
g1=49;
g2=98;
g3=196;
g4=392;
g5=784;
g6=1568;
g7=3136;
a1=55;
a2=110;
a3=220;
a4=440;
a5=880;
a6=1760;
a7=3520;
h1=62;
h2=123;
h3=247;
h4=494;
h5=988;
h6=1976;
h7=3951;
c8=4186;
osemka=500;
cnuta=1000;
pnuta=2000;
nuta=4000;
TYPE nut=record
         n:word;
         t:word;
         sl:string[10];
         end;
CONST
 stolattab:array[1..35] of nut =
((n:g4;t:cnuta;sl:'Sto '),
(n:e4;t:cnuta;sl:'lat !'#10#13),
(n:g4;t:cnuta;sl:'Sto '),
(n:e4;t:cnuta;sl:'lat !'#10#13),
(n:g4;t:cnuta;sl:'Niech '),
(n:a4;t:osemka;sl:'zy'),
(n:g4;t:osemka;sl:'je ,'),
(n:f4;t:osemka;sl:'zy'),
(n:e4;t:osemka;sl:'je '),
(n:f4;t:cnuta;sl:'nam '#10#13),
(n:0;t:osemka;sl:''),
(n:f4;t:cnuta;sl:'Sto '),
(n:d4;t:cnuta;sl:'lat ,'),
(n:f4;t:cnuta;sl:'Sto '),
(n:d4;t:cnuta;sl:'lat '#10#13),
(n:f4;t:cnuta;sl:'Niech '),
(n:g4;t:osemka;sl:'zy'),
(n:f4;t:osemka;sl:'je ,'),
(n:e4;t:osemka;sl:' zy'),
(n:d4;t:osemka;sl:'je'),
(n:e4;t:cnuta;sl:' nam !'#10#13),
(n:g4;t:cnuta;sl:'Jeszcze '),
(n:e4;t:cnuta;sl:'raz ,'),
(n:g4;t:cnuta;sl:' jeszcze '),
(n:e4;t:cnuta;sl:'raz ,'),
(n:g4;t:cnuta;sl:' niech '),
(n:c5;t:osemka;sl:'zy'),
(n:h4;t:osemka;sl:'je ,'),
(n:a4;t:osemka;sl:'zy'),
(n:g4;t:osemka;sl:'je '),
(n:a4;t:cnuta;sl:'nam !'#10#13),
(n:h4;t:pnuta;sl:'Niech '),
(n:a4;t:cnuta;sl:'zy'),
(n:h4;t:cnuta;sl:'je '),
(n:c5;t:pnuta;sl:'nam  !'#10#13));

procedure graj(var t;m:word);
var tab:array[1..1024] of nut absolute t;
    i:word;
    key:char;
begin
for i:=1 to m do
         begin
         sound(tab[i].n);
         write(tab[i].sl);
         delay(tab[i].t);
         if keypressed then
                           begin
                           key:=readkey;
                           if ((key=#27)
                              or(key='q')) then
                              begin
                              nosound;
                              halt;
                              end;
                            end;
         end;
nosound;
end;{graj}
begin
clrscr;
highvideo;
writeln(' S T O  L A T  !!!');
lowvideo;
graj(stolattab,35);
TEXTCOLOR(RED);
writeln(' P I O T R  !');
TEXTCOLOR(LIGHTGRAY);
DELAY(2000);
end.