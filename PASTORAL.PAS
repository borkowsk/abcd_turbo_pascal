program pastoral;
uses crt;
const

c1=33;
c2=65;
c3=131;
c4=262;
c5=523;
c6=1047;
c7=2093;
c8=4186;

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

cis0=18;
cis1=35;
cis2=69 ;
cis3=139 ;
cis4=278  ;
cis5=554   ;
cis6=1109   ;
cis7=2217    ;
dis1=39;
dis2=77 ;
dis3=156 ;
dis4=311  ;
dis5=622   ;
dis6=1245   ;
dis7=2489    ;

eis1=42;
eis2=84 ;
eis3=170 ;
eis4=339  ;
eis5=678   ;
eis6=1357   ;
eis7=2714    ;

fis1=46;
fis2=92 ;
fis3=185 ;
fis4=370  ;
fis5=740   ;
fis6=1480   ;
fis7=2960    ;

gis1=52;
gis2=104;
gis3=208 ;
gis4=415  ;
gis5=831   ;
gis6=1661   ;
gis7=3322    ;

ais1=58       ;
ais2=116       ;
ais3=233        ;
ais4=466         ;
ais5=932          ;
ais6=1865          ;
ais7=3729           ;

his1=63;
his2=127;
his3=254 ;
his4=508  ;
his5=1017  ;
his6=2034   ;
his7=4067    ;

osemka=187;
cnuta=375;
pnuta=750;
nuta=1500;

TYPE nut=record
         n:word;
         t:word;
         sl:string[10];
         end;
CONST
 stolattab:array[1..35] of nut =
(
(n:g4;t:cnuta;sl:'Sto '),
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

CONST
 pastoraltab:array[1..69] of nut =
(
(n:fis4;t:osemka;sl:'Pa'),
(n:g4;t:osemka;sl:'stu'),
(n:a4;t:cnuta+osemka;sl:'szko'),
(n:h4;t:osemka;sl:'wie '),

(n:a4;t:osemka;sl:'bra'),
(n:gis4;t:osemka;sl:'cia '),
(n:a4;t:cnuta;sl:'mi'),
(n:fis4;t:cnuta;sl:'li, '),

(n:fis4;t:osemka;sl:'gdzie'),
(n:g4;t:osemka;sl:'scie '),
(n:a4;t:cnuta+osemka;sl:'pod '),
(n:h4;t:osemka;sl:'ten '),

(n:a4;t:osemka;sl:'czas '),
(n:gis4;t:osemka;sl:'cho'),
(n:a4;t:cnuta+osemka;sl:'dzi'),
(n:fis4;t:cnuta+osemka;sl:'li'#10#13),

(n:0;t:osemka;sl:''),

(n:a4;t:osemka;sl:'Po '),
(n:a4;t:osemka;sl:'pod'),
(n:g4;t:cnuta;sl:'le'),
(n:e4;t:cnuta;sl:'siu '),

(n:d4;t:osemka;sl:'na '),
(n:e4;t:osemka;sl:'do'),
(n:fis4;t:cnuta;sl:'li'),
(n:fis4;t:cnuta;sl:'nie '),

(n:a4;t:osemka;sl:'sta'),
(n:a4;t:osemka;sl:'ne'),
(n:g4;t:cnuta;sl:'li '),
(n:e4;t:cnuta;sl:'w ge'),

(n:d4;t:osemka;sl:'stej '),
(n:e4;t:osemka;sl:'krze'),
(n:fis4;t:cnuta;sl:'wi'),
(n:fis4;t:cnuta;sl:'nie'#10#13),

(n:d4;t:cnuta;sl:'pasc '),
(n:fis4;t:cnuta;sl:'o'),
(n:g4;t:cnuta;sl:'wie'),

(n:a4;t:pnuta;sl:'czki'),
(n:0;t:cnuta;sl:', '),

(n:a4;t:cnuta;sl:'pasc '),
(n:g4;t:cnuta;sl:'o'),
(n:g4;t:cnuta;sl:'wie'),

(n:fis4;t:pnuta;sl:'czki '),
(n:0;t:cnuta;sl:'!!!'#10#13),

(n:a4;t:osemka;sl:'Po '),
(n:a4;t:osemka;sl:'pod'),
(n:g4;t:cnuta;sl:'le'),
(n:e4;t:cnuta;sl:'siu '),

(n:d4;t:osemka;sl:'na '),
(n:e4;t:osemka;sl:'do'),
(n:fis4;t:cnuta;sl:'li'),
(n:fis4;t:cnuta;sl:'nie '),

(n:a4;t:osemka;sl:'sta'),
(n:a4;t:osemka;sl:'ne'),
(n:g4;t:cnuta;sl:'li '),
(n:e4;t:cnuta;sl:'w ge'),

(n:d4;t:osemka;sl:'stej '),
(n:e4;t:osemka;sl:'krze'),
(n:fis4;t:cnuta;sl:'wi'),
(n:fis4;t:cnuta;sl:'nie'#10#13),

(n:d4;t:cnuta;sl:'pasc '),
(n:fis4;t:cnuta;sl:'o'),
(n:g4;t:cnuta;sl:'wie'),

(n:a4;t:pnuta;sl:'czki'),
(n:0;t:cnuta;sl:', '),

(n:a4;t:cnuta;sl:'pasc '),
(n:g4;t:cnuta;sl:'o'),
(n:g4;t:cnuta;sl:'wie'),

(n:fis4;t:pnuta;sl:'czki '),
(n:0;t:cnuta;sl:'!!!'#10#13#10#13)
);

CONST
 pastoraltab1:array[1..69] of nut =
(
(n:fis4 ;t:osemka;sl:'A '),
(n:g4   ;t:osemka;sl:'gdy '),
(n:a4   ;t:cnuta+osemka;sl:'pol'),
(n:h4   ;t:osemka;sl:'noc '),

(n:a4;t:osemka;sl:'nas'),
(n:gis4;t:osemka;sl:'ta'),
(n:a4;t:cnuta;sl:'pi'),
(n:fis4;t:cnuta;sl:'la, '),

(n:fis4;t:osemka;sl:'Jas'),
(n:g4;t:osemka;sl:'nosc '),
(n:a4;t:cnuta+osemka;sl:'z nie'),
(n:h4;t:osemka;sl:'ba '),

(n:a4;t:osemka;sl:'u'),
(n:gis4;t:osemka;sl:'de'),
(n:a4;t:cnuta+osemka;sl:'rzy'),
(n:fis4;t:cnuta+osemka;sl:'la .'#10#13),

(n:0;t:osemka;sl:''),

(n:a4;t:osemka;sl:'Pas'),
(n:a4;t:osemka;sl:'tusz'),
(n:g4;t:cnuta;sl:'ko'),
(n:e4;t:cnuta;sl:'wie '),

(n:d4;t:osemka;sl:'sie '),
(n:e4;t:osemka;sl:'pos'),
(n:fis4;t:cnuta;sl:'pa'),
(n:fis4;t:cnuta;sl:'li, '),

(n:a4;t:osemka;sl:'Na'),
(n:a4;t:osemka;sl:'gle '),
(n:g4;t:cnuta;sl:'sie '),
(n:e4;t:cnuta;sl:'po'),

(n:d4;t:osemka;sl:'pod'),
(n:e4;t:osemka;sl:'ry'),
(n:fis4;t:cnuta;sl:'wa'),
(n:fis4;t:cnuta;sl:'li '#10#13),

(n:d4;t:cnuta;sl:'co '),
(n:fis4;t:cnuta;sl:'sie  '),
(n:g4;t:cnuta;sl:'dzie'),

(n:a4;t:pnuta;sl:'je '),
(n:0;t:cnuta;sl:', '),

(n:a4;t:cnuta;sl:'co '),
(n:g4;t:cnuta;sl:'sie '),
(n:g4;t:cnuta;sl:'dzie'),

(n:fis4;t:pnuta;sl:'je '),
(n:0;t:cnuta;sl:'!!!'#10#13),

(n:a4;t:osemka;sl:'Pas'),
(n:a4;t:osemka;sl:'tusz'),
(n:g4;t:cnuta;sl:'ko'),
(n:e4;t:cnuta;sl:'wie '),

(n:d4;t:osemka;sl:'sie '),
(n:e4;t:osemka;sl:'pos'),
(n:fis4;t:cnuta;sl:'pa'),
(n:fis4;t:cnuta;sl:'li, '),

(n:a4;t:osemka;sl:'Na'),
(n:a4;t:osemka;sl:'gle '),
(n:g4;t:cnuta;sl:'sie '),
(n:e4;t:cnuta;sl:'po'),

(n:d4;t:osemka;sl:'pod'),
(n:e4;t:osemka;sl:'ry'),
(n:fis4;t:cnuta;sl:'wa'),
(n:fis4;t:cnuta;sl:'li '#10#13),

(n:d4;t:cnuta;sl:'co '),
(n:fis4;t:cnuta;sl:'sie '),
(n:g4;t:cnuta;sl:'dzie'),

(n:a4;t:pnuta;sl:'je '),
(n:0;t:cnuta;sl:', '),

(n:a4;t:cnuta;sl:'co '),
(n:g4;t:cnuta;sl:'sie '),
(n:g4;t:cnuta;sl:'dzie'),

(n:fis4;t:pnuta;sl:'je '),
(n:0;t:cnuta;sl:'!!!'#10#13)

);
 przybierzeli:array[1..68] of nut =
(
(n:d5   ;t:osemka;sl:'Przy'),
(n:cis5 ;t:osemka;sl:'bie'),
(n:d5;t:osemka;sl:'rze'),
(n:e5;t:osemka;sl:'li  '),

(n:fis5;t:osemka;sl:'do '),
(n:e5;t:osemka;sl:'Be'),
(n:fis5;t:osemka;sl:'tle'),
(n:g5;t:osemka;sl:'jem '),

(n:a5;t:cnuta;sl:'pa'),
(n:h5;t:cnuta;sl:'ste'),

(n:a5;t:cnuta;sl:'rze, '),
(n:0;t:cnuta;sl:#10#13),

(n:d5   ;t:osemka;sl:'Gra'),
(n:cis5 ;t:osemka;sl:'jac '),
(n:d5;t:osemka;sl:'sko'),
(n:e5;t:osemka;sl:'czno '),

(n:fis5;t:osemka;sl:'Dzie'),
(n:e5;t:osemka;sl:'cia'),
(n:fis5;t:osemka;sl:'te'),
(n:g5;t:osemka;sl:'czku '),

(n:a5;t:cnuta;sl:'na '),      
(n:h5;t:cnuta;sl:'li'),

(n:a5;t:cnuta;sl:'rze ,'),
(n:0;t:cnuta+osemka;sl:#10#13),

(n:d6   ;t:cnuta;sl:'Chwa'),
(n:a5   ;t:osemka;sl:'la '),
(n:a5   ;t:osemka;sl:'na '),

(n:h5   ;t:osemka;sl:'wy'),
(n:a5;t:osemka;sl:'so'),
(n:g5;t:osemka;sl:'kos'),
(n:fis5;t:osemka;sl:'ci, '),

(n:g5;t:cnuta;sl:'Chwa'),
(n:g5;t:osemka;sl:'la '),
(n:g5;t:osemka;sl:'na '),

(n:a5;t:osemka;sl:'wy'),
(n:g5;t:osemka;sl:'so'),
(n:fis5;t:osemka;sl:'kos'),
(n:e5;t:osemka;sl:'ci, '#10#13),

(n:fis5;t:cnuta;sl:'A '),
(n:g5;t:cnuta;sl:'po'),

(n:a5;t:cnuta;sl:'koj '),
(n:0;t:cnuta;sl:'...'#10#13),

(n:fis5;t:cnuta;sl:'Na '),
(n:e5;t:cnuta;sl:'zie'),

(n:d5;t:cnuta;sl:'mi '),
(n:0;t:cnuta;sl:'!!!'#10#13),

(n:d6   ;t:cnuta;sl:'Chwa'),
(n:a5   ;t:osemka;sl:'la '),
(n:a5   ;t:osemka;sl:'na '),

(n:h5   ;t:osemka;sl:'wy'),
(n:a5;t:osemka;sl:'so'),
(n:g5;t:osemka;sl:'kos'),
(n:fis5;t:osemka;sl:'ci, '),

(n:g5;t:cnuta;sl:'Chwa'),
(n:g5;t:osemka;sl:'la '),
(n:g5;t:osemka;sl:'na '),

(n:a5;t:osemka;sl:'wy'),
(n:g5;t:osemka;sl:'so'),
(n:fis5;t:osemka;sl:'kos'),
(n:e5;t:osemka;sl:'ci, '#10#13),

(n:fis5;t:cnuta;sl:'A '),
(n:g5;t:cnuta;sl:'po'),

(n:a5;t:cnuta;sl:'koj '),
(n:0;t:cnuta;sl:'...'#10#13),

(n:fis5;t:cnuta;sl:'Na '),
(n:e5;t:cnuta;sl:'zie'),

(n:d5;t:cnuta;sl:'mi '),
(n:0;t:cnuta;sl:'!!!'#10#13)
);

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
         nosound;
         delay(100);

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
var out :text;
    key :char;
begin
clrscr;
highvideo;

{assign(out,'cisy.pas');
rewrite(out);
writeln(out,'cis1=',round(sqrt(c1*d1)));
writeln(out,'cis2=',round(sqrt(c2*d2)));
writeln(out,'cis3=',round(sqrt(c3*d3)));
writeln(out,'cis4=',round(sqrt(c4*d4)));
writeln(out,'cis5=',round(sqrt(c5*d5)));
writeln(out,'cis6=',round(sqrt(c6*d6)));
writeln(out,'cis7=',round(sqrt(c7*d7)));
writeln(out,'dis1=',round(sqrt(e1*d1)));
writeln(out,'dis2=',round(sqrt(e2*d2)));
writeln(out,'dis3=',round(sqrt(e3*d3)));
writeln(out,'dis4=',round(sqrt(e4*d4)));
writeln(out,'dis5=',round(sqrt(e5*d5)));
writeln(out,'dis6=',round(sqrt(e6*d6)));
writeln(out,'dis7=',round(sqrt(e7*d7)));
writeln(out,'eis1=',round(sqrt(e1*f1)));
writeln(out,'eis2=',round(sqrt(e2*f2)));
writeln(out,'eis3=',round(sqrt(e3*f3)));
writeln(out,'eis4=',round(sqrt(e4*f4)));
writeln(out,'eis5=',round(sqrt(e5*f5)));
writeln(out,'eis6=',round(sqrt(e6*f6)));
writeln(out,'eis7=',round(sqrt(e7*f7)));
writeln(out,'fis1=',round(sqrt(f1*g1)));
writeln(out,'fis2=',round(sqrt(f2*g2)));
writeln(out,'fis3=',round(sqrt(f3*g3)));
writeln(out,'fis4=',round(sqrt(f4*g4)));
writeln(out,'fis5=',round(sqrt(f5*g5)));
writeln(out,'fis6=',round(sqrt(f6*g6)));
writeln(out,'fis7=',round(sqrt(f7*g7)));
writeln(out,'gis1=',round(sqrt(a1*g1)));
writeln(out,'gis2=',round(sqrt(a2*g2)));
writeln(out,'gis3=',round(sqrt(a3*g3)));
writeln(out,'gis4=',round(sqrt(a4*g4)));
writeln(out,'gis5=',round(sqrt(a5*g5)));
writeln(out,'gis6=',round(sqrt(a6*g6)));
writeln(out,'gis7=',round(sqrt(a7*g7)));
writeln(out,'ais1=',round(sqrt(a1*h1)));
writeln(out,'ais2=',round(sqrt(a2*h2)));
writeln(out,'ais3=',round(sqrt(a3*h3)));
writeln(out,'ais4=',round(sqrt(a4*h4)));
writeln(out,'ais5=',round(sqrt(a5*h5)));
writeln(out,'ais6=',round(sqrt(a6*h6)));
writeln(out,'ais7=',round(sqrt(a7*h7)));
writeln(out,'ais1=',round(sqrt(a1*h1)));
writeln(out,'ais2=',round(sqrt(a2*h2)));
writeln(out,'ais3=',round(sqrt(a3*h3)));
writeln(out,'ais4=',round(sqrt(a4*h4)));
writeln(out,'ais5=',round(sqrt(a5*h5)));
writeln(out,'ais6=',round(sqrt(a6*h6)));
writeln(out,'ais7=',round(sqrt(a7*h7)));
writeln(out,'his1=',round(sqrt(c2*h1)));
writeln(out,'his2=',round(sqrt(c3*h2)));
writeln(out,'his3=',round(sqrt(c4*h3)));
writeln(out,'his4=',round(sqrt(c5*h4)));
writeln(out,'his5=',round(sqrt(c6*h5)));
writeln(out,'his6=',round(sqrt(c7*h6)));
writeln(out,'his7=',round(sqrt(c8*h7)));
close(out);}

HIGHVIDEO;
writeln('....PRZYBIERZELI...');
LOWVIDEO;
graj(przybierzeli,68);
TEXTCOLOR(lightRED);
writeln(' -------- ');
WRITELN('Mam grac ???');
key:=readkey;
if key='n'  then halt;
clrscr;
highvideo;
writeln('... PASTORALKA BESKIDZKA ...');
lowvideo;
graj(pastoraltab,69);
graj(pastoraltab1,69);
TEXTCOLOR(RED);
writeln(' -------- ');
TEXTCOLOR(LIGHTGRAY);
DELAY(2000);
end.



