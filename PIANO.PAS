program gama;
uses crt,dos,graph,graph2;
const
c0=16;
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

osemka=500;
cnuta=1000;
pnuta=2000;
nuta=4000;

TYPE nut=record
         n:word;
         t:word;
         sl:string[10];
         end;
const gamatab:array[1..49] of nut=
(
{(n:c1;t:cnuta;sl:'c1 '),}
(n:d1;t:cnuta;sl:'d1 '),
(n:e1;t:cnuta;sl:'e1 '),
(n:f1;t:cnuta;sl:'f1 '),
(n:g1;t:cnuta;sl:'g1 '),
(n:a1;t:cnuta;sl:'a1 '),
(n:h1;t:cnuta;sl:'h1 '),
(n:c2;t:cnuta;sl:'c2 '#10#13),
{(n:c2;t:cnuta;sl:'c2 '),}
(n:d2;t:cnuta;sl:'d2 '),
(n:e2;t:cnuta;sl:'e2 '),
(n:f2;t:cnuta;sl:'f2 '),
(n:g2;t:cnuta;sl:'g2 '),
(n:a2;t:cnuta;sl:'a2 '),
(n:h2;t:cnuta;sl:'h2 '),
(n:c3;t:cnuta;sl:'c3 '#10#13),
{(n:c3;t:cnuta;sl:'c3 '),  }
(n:d3;t:cnuta;sl:'d3 '),
(n:e3;t:cnuta;sl:'e3 '),
(n:f3;t:cnuta;sl:'f3 '),
(n:g3;t:cnuta;sl:'g3 '),
(n:a3;t:cnuta;sl:'a3 '),
(n:h3;t:cnuta;sl:'h3 '),
(n:c4;t:cnuta;sl:'c4 '#10#13),
{(n:c4;t:cnuta;sl:'c4 '),}
(n:d4;t:cnuta;sl:'d4 '),
(n:e4;t:cnuta;sl:'e4 '),
(n:f4;t:cnuta;sl:'f4 '),
(n:g4;t:cnuta;sl:'g4 '),
(n:a4;t:cnuta;sl:'a4 '),
(n:h4;t:cnuta;sl:'h4 '),
(n:c5;t:cnuta;sl:'c5 '#10#13),
{(n:c5;t:cnuta;sl:'c5 '),}
(n:d5;t:cnuta;sl:'d5 '),
(n:e5;t:cnuta;sl:'e5 '),
(n:f5;t:cnuta;sl:'f5 '),
(n:g5;t:cnuta;sl:'g5 '),
(n:a5;t:cnuta;sl:'a5 '),
(n:h5;t:cnuta;sl:'h5 '),
(n:c6;t:cnuta;sl:'c6 '#10#13),
{(n:c6;t:cnuta;sl:'c6 '),}
(n:d6;t:cnuta;sl:'d6 '),
(n:e6;t:cnuta;sl:'e6 '),
(n:f6;t:cnuta;sl:'f6 '),
(n:g6;t:cnuta;sl:'g6 '),
(n:a6;t:cnuta;sl:'a6 '),
(n:h6;t:cnuta;sl:'h6 '),
(n:c7;t:cnuta;sl:'c7 '#13#10),
{(n:c7;t:cnuta;sl:'c7 '),  }
(n:d7;t:cnuta;sl:'d7 '),
(n:e7;t:cnuta;sl:'e7 '),
(n:f7;t:cnuta;sl:'f7 '),
(n:g7;t:cnuta;sl:'g7 '),
(n:a7;t:cnuta;sl:'a7 '),
(n:h7;t:cnuta;sl:'h7 '),
(n:c8;t:cnuta;sl:'c8 '));

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
var
  Int1CSave : Pointer;
  licznik:integer;
  petlik,x,y:longint;
{$F+,S-,W-}
procedure initcosik(c:integer);
begin
petlik:=0;
x:=random(mx);
y:=random(my);
setcolor(c);
end;

procedure cosik;
begin
if petlik<MAXINT then
      begin
      circle(x,y,petlik);
      inc(petlik);
      circle(x,y,petlik);
      inc(petlik);
      circle(x,y,petlik);
      inc(petlik);
      end;
end;

procedure kasowanie;
  begin
    if licznik>0 then dec(licznik);
    if licznik=0 then begin
                      nosound;
                      PETLIK:=maxint;
                      end;
  end;

procedure TimerHandler; interrupt;
    { Timer ISR }
    {*** Refer to DDK and DPMI Specs for creating ISR's ***}
begin
kasowanie;
cosik;
end;

{$F-,S+}
var
key:char;
tanuta:integer;
begin
clrscr;
highvideo;
graph2init('c:\bp\bgi',nil);
GetIntVec($1C,Int1CSave);
SetIntVec($1C,Addr(TimerHandler));
randomize;
repeat
if keypressed then
   begin
   key:=readkey;
   case key of
   '!':tanuta:=cis0;
   '@':tanuta:=cis1;
   '#':tanuta:=dis1;
   '$':tanuta:=eis1;
   '%':tanuta:=fis1;
   '^':tanuta:=gis1;
   '&':tanuta:=ais1;
   '*':tanuta:=his1;
   '(':tanuta:=cis2;
   ')':tanuta:=dis2;
   '_':tanuta:=eis2;
   '+':tanuta:=fis2;
   '|':tanuta:=gis2;
   'Q':tanuta:=c1;
   'W':tanuta:=d1;
   'E':tanuta:=e1;
   'R':tanuta:=f1;
   'T':tanuta:=g1;
   'Y':tanuta:=a1;
   'U':tanuta:=h1;
   'I':tanuta:=c2;
   'O':tanuta:=d2;
   'P':tanuta:=e2;
   '{':tanuta:=f2;
   '}':tanuta:=g2;
   'A':tanuta:=0;
   'S':tanuta:=cis2;
   'D':tanuta:=dis2;
   'F':tanuta:=eis2;
   'G':tanuta:=fis2;
   'H':tanuta:=gis2;
   'J':tanuta:=ais2;
   'K':tanuta:=his2;
   'L':tanuta:=cis3;
   ':':tanuta:=dis3;
   '"':tanuta:=eis3;
   'Z':tanuta:=c2;
   'X':tanuta:=d2;
   'C':tanuta:=e2;
   'V':tanuta:=f2;
   'B':tanuta:=g2;
   'N':tanuta:=a2;
   'M':tanuta:=h2;
   '<':tanuta:=c3;
   '>':tanuta:=d3;
   '?':tanuta:=e3;
   '1':tanuta:=cis3;
   '2':tanuta:=cis4;
   '3':tanuta:=dis4;
   '4':tanuta:=eis4;
   '5':tanuta:=fis4;
   '6':tanuta:=gis4;
   '7':tanuta:=ais4;
   '8':tanuta:=his4;
   '9':tanuta:=cis5;
   '0':tanuta:=dis5;
   '-':tanuta:=eis5;
   '=':tanuta:=fis5;
   '\':tanuta:=gis5;
   'q':tanuta:=c4;
   'w':tanuta:=d4;
   'e':tanuta:=e4;
   'r':tanuta:=f4;
   't':tanuta:=g4;
   'y':tanuta:=a4;
   'u':tanuta:=h4;
   'i':tanuta:=c5;
   'o':tanuta:=d5;
   'p':tanuta:=e5;
   '[':tanuta:=f5;
   ']':tanuta:=g5;
   'a':tanuta:=his4;
   's':tanuta:=cis5;
   'd':tanuta:=dis5;
   'f':tanuta:=eis5;
   'g':tanuta:=fis5;
   'h':tanuta:=gis5;
   'j':tanuta:=ais5;
   'k':tanuta:=his5;
   'l':tanuta:=cis6;
   ';':tanuta:=dis6;
   '''':tanuta:=eis6;
   'z':tanuta:=c5;
   'x':tanuta:=d5;
   'c':tanuta:=e5;
   'v':tanuta:=f5;
   'b':tanuta:=g5;
   'n':tanuta:=a5;
   'm':tanuta:=h5;
   ',':tanuta:=c6;
   '.':tanuta:=d6;
   '/':tanuta:=e6;
   ' ':begin nosound;tanuta:=0;licznik:=0;end;
   else begin while keypressed do key:=readkey; (* Flush buffer *) end;
   end;{case}
   initcosik(tanuta);
   sound(tanuta);
   licznik:=18;
   cosik;
   end;
until key=#27;
SetIntVec($01C,Int1CSave);
restorecrtmode;
nosound;
lowvideo;
TEXTCOLOR(LIGHTRED);
writeln(' KONIEC !');
TEXTCOLOR(LIGHTGRAY);
end.