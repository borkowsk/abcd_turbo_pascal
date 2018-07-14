PROGRAM FILLEDITOR;
USES crt,GRAPH;
CONST
 BIT1=1;
 BIT2=2;
 BIT3=4;
 BIT4=8;
 BIT5=16;
 BIT6=32;
 BIT7=64;
 BIT8=128;
TYPE OKTET=ARRAY[1..8] OF BOOLEAN;
VAR
  WZOREK:FILLPATTERNTYPE;
  TABLICA:ARRAY[1..8] OF OKTET;
  i,STER,TRYB,mx,my:integer;
  key:char;
function ZROBBYTE(TAB:OKTET):BYTE;
var pom:byte;
begin
pom:=0;
if tab[1] then pom:=bit8;
if tab[2] then pom:=pom+bit7;
if tab[3] then pom:=pom+bit6;
if tab[4] then pom:=pom+bit5;
if tab[5] then pom:=pom+bit4;
if tab[6] then pom:=pom+bit3;
if tab[7] then pom:=pom+bit2;
if tab[8] then pom:=pom+bit1;
zrobbyte:=pom;
end;
procedure ZROBTAB(BAJT:BYTE;VAR TAB:OKTET);
begin
tab[1]:=((bajt and bit8)<>0);
tab[2]:=((bajt and bit7)<>0);
tab[3]:=((bajt and bit6)<>0);
tab[4]:=((bajt and bit5)<>0);
tab[5]:=((bajt and bit4)<>0);
tab[6]:=((bajt and bit3)<>0);
tab[7]:=((bajt and bit2)<>0);
tab[8]:=((bajt and bit1)<>0);
end;
procedure DRUKTAB;
var i,j,k:integer;
begin
setviewport(mx div 2,my div 2,mx,my,true);
clearviewport;
outtext('12345678');
moveto(0,8);
for i:=1 to 8 do
    begin
    for j:=1 to 8 do if tablica[i,j] then outtext(#2)
                                     else outtext(#43);
    moveto(0,(1+i)*8);
    end;

end;
procedure READFILLPATTERN(VAR WYP:FILLPATTERNTYPE);
bEGIN
writeln('PODAWAJ KOLEYNE BAJTY WZORU');
WRITE('1:');READ(WYP[1]);
WRITE('2:');READ(WYP[2]);
WRITE('3:');READ(WYP[3]);
WRITE('4:');READ(WYP[4]);
WRITE('5:');READ(WYP[5]);
WRITE('6:');READ(WYP[6]);
WRITE('7:');READ(WYP[7]);
WRITE('8:');READ(WYP[8]);
WRITE('DOBRA !!!');
DELAY(300);
end;
function ZRObSTR(wyp:fillpatterntype):string;
VAr s:string;
   ms:string[4];
    i:byte;
begin
s:='';
s:='(';
for i:=1 to 8 do
    begin
    str(wyp[i],ms);
    s:=s+ms;
    if i<8 then s:=s+','
           else s:=s+')';
    end;
zrobstr:=s;
end;
procedure Keyowanie;
var a,b:byte;
    k:integer;
begin
key:=readkey;
if ord(key) in[49..57]
            then
            begin
            outtext('a='+key+'?');
            val(key,a,k);
            key:=readkey;
            if ord(key) in[49..57]
                        then
                        begin
                        outtext('b='+key+'?');
                        val(key,b,k);
                        key:=readkey;
                        outtext(key);
                        if key='1'then tablica[a,b]:=true
                                  else tablica[a,b]:=false;
                        wzorek[a]:=zrobbyte(tablica[a]);
                        end;
            end;

end;
BEGIN
        clrscr;
        writeln('                 ษอออออออออออออออออออออออออออออออออออออออออออออป');
        writeln('                 บ    PROGRAM F I L L E D I T O R  Version 1   บ');
        WRITELN('                 บ    #๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗๗#   บ');
        writeln('                 บ           Copyright(c)   1990               บ');
        writeln('                 บ          by  Wojciech Borkowski             บ');
        writeln('                 บ                   in                        บ');
        writeln('                 บ                UNIWERSITY                   บ');
        writeln('                 บ                    OF                       บ');
        writeln('                 บ                W a r s a w                  บ');
        writeln('                 บ                                             บ');
        writeln('                 บ                                             บ');
        writeln('                 บ                                             บ');
        writeln('                 บ                              Press any key !บ');
        writeln('                 ศอออออออออออออออออออออออออออออออออออออออออออออผ');
        key:=readkey;
detectgraph(ster,tryb);
initgraph(ster,tryb,'');
mx:=getmaxx;
my:=getmaxy;
outtext('G R A P H   S Y S T E M   I N I T I A L Y S E D ');
moveto(0,my div 2);
for i:=1 to mx div 8 do outtext(char(i));
moveto(0,my div 2 +10);
for i:=(mx div 8) +1 to 128 do outtext(char(i));
key:=readkey;
key:=#0;
restorecrtmode;

READFILLPATTERN(wzorek);
setgraphmode(tryb);
repeat
setviewport(0,0,mx,my,true);

setfillpattern(wzorek,black);
fillellipse(mx div 4,my div 4,100,66);
fillellipse(3*(mx div 4),my div 4,10,6);
for i:=1 to 8 do zrobtab(wzorek[i],tablica[i]);
druktab;
outtext('Podawaj cyfry 1..8 !');
moveto(0,(my div 2)-20);
outtextxy(0,(my div 2)-10,'fillpattern='+zrobstr(wzorek));
keyowanie;
until key=#27;
closegraph;
END.