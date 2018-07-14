program ta_cma;
Uses graph,graph2;
Type typwzoru=array[0..15] of word;
     image=record
           len,width:word;
           fill:array[1..$fff0] of byte;
           end;
const
     kolor1:byte=1;
     kolor2:byte=0;
     kolorC:byte=1;
     wzor1:typwzoru=(
         0,   1,   2,   4,   8,16,  32,  64, 128,
       256, 512,1024,2048,4096,$FFFF,$FFFF);
     wzor2:typwzoru=(
     $0000,$1111,$2222,$3333,$4444,$5555,$6666,$7777,
     $8888,$9999,$AAAA,$BBBB,$CCCC,$DDDD,$EEEE,$FFFF);
     wzor3:typwzoru=(
     $AAA1,$5552,$AAa3,$5554,$AAA5,$5556,$AAA7,$5558,
     $AAA9,$555a,$AAAb,$555c,$AAAd,$555e,$AAAf,$5550);
Type Cma=object
     X,Y,D:integer;
     sit:boolean;
     wzor:typwzoru;
     kolor1,kolor2,kolorC:byte;
     im:^image;
     constructor init(ld:integer);
     procedure   sets(lx,ly:integer);
     procedure   put(lx,ly:integer);
     procedure  uput;
     end;

constructor cma.init;
begin
D:=ld;
X:=0;Y:=0;sit:=false;
wzor:=wzor2;
kolor1:=1;kolor2:=0;kolorC:=1;
im:=nil;
end;

procedure cma.sets;
begin
X:=lX;Y:=lY;
end;

procedure cma.put(lX,lY:integer);
var i,p,q,s:integer;
begin
X:=lX;Y:=lY;

setlinestyle(SolidLn,0,NormWidth);
setcolor(kolorC);
setwritemode(XORput);
s:=d;
q:=y-s;
p:=d div 2;
line(x,q,x+p,q-p);
line(x,q,x-p,q-p);
setwritemode(NormalPut);
for i:=0 to d-1 do
    begin
    { q powinno byc < niz y }
    q:=y-s+(i*i div d);
    setcolor(kolor1);
    setlinestyle(UserBitLn,wzor[i mod 16],normwidth);
    line(x-i,q,x-i,y);
    line(x+i,q,x+i,y);
    setcolor(kolor2);
    setlinestyle(UserBitLn,not wzor[i mod 16],normwidth);
    line(x-i,q,x-i,y);
    line(x+i,q,x+i,y);
    end;
sit:=true;
end;

procedure cma.uput;
var d1:integer;
begin
d1:=d div 2;
sit:=false;
bar(X-d1,y,x+d1,y+d);
end;
const pojemnosc=10;
var a:word;
  cmy:array[1..pojemnosc] of cma;
begin
randomize;
graph2testinit('c:\tup\bin');
for a:=1 to mx do
  if a mod 200 >100 then
    begin
    {setlinestyle(UserBitLn,random($FFFF),normwidth);}
    line(a,1,a,my);
    end;
for a:=1 to pojemnosc do
    Cmy[a].init(32);

for a:=1 to pojemnosc do
    Cmy[a].put(random(mx),random(my));
repeat
cmy[1].uput;
put(random(
until false;
end.