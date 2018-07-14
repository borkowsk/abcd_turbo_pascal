program wybuch;
uses crt,graph,graph2;
const BGIPATH='\tup';
procedure bum(x,y:integer;n:word);
var i:word;
    oldcolor:word;
    n2:word;
begin
sound(50);
oldcolor:=getcolor;
n2:=n div 2;
for i:=0 to n do
    begin
    line(x,y,x+random(n)-n2,y+random(n)-n2);
    sound(i div 4);
    end;
    setcolor(0);
for i:=n downto 0 do
    begin
    line(x,y,x+random(n)-n2,y+random(n)-n2);
    sound(i div 4);
    end;
    setcolor(oldcolor);
    nosound;
end;

procedure bum3(x,y:integer;n:word);
var i,j:word;
    oldcolor,lockolor,modmax:word;
    ne,ne2:longint;
    point:array[0..1000] of record
                         xp,yp,xo,yo,dx,dy:integer;
                         col:word;
                         end;
begin
{sound(50);}
if n>1000 then n:=1000;
oldcolor:=getcolor;
lockolor:=random(maxcolor);
modmax:=maxcolor+1;
if lockolor=0 then lockolor:=1;
setcolor(lockolor);
setwritemode(xorput);
ne:=n div 25;
for i:=0 to n do
    with point[i] do
    begin
    ne2:=random(nE);
    dx:=round(sin(i)*ne2);
    dy:=round(cos(i)*ne2*xratio/yratio);
    xo:=x;
    yo:=y;
    xp:=x+dx;
    yp:=y+dy;
    col:=lockolor;
    line(x,y,xp,yp);
    end;
nosound;

for j:=0 to 32 do

for i:=n downto 0 do

    with point[i] do
    begin
    setcolor(col);
    line(xo,yo,xp,yp);
    xo:=xp;
    yo:=yp;
    dx:=round(dx-dx/2);
    dy:=round(dy-dy/2);
    xp:=xp+dx;
    yp:=yp+dy;
    col:=(col+1) mod modmax;
    if(col=0) then col:=1;
    setcolor(col);
    line(xo,yo,xp,yp);
    end;

for i:=n downto 0 do

    with point[i] do
    begin
    setcolor(col);
    line(xo,yo,xp,yp);
    end;

setcolor(oldcolor);
end;

procedure fillellipse(x,y:integer;Xradius,Yradius:word);
var i:word;
    oldcolor,actcolor:word;
begin
oldcolor:=getcolor;
actcolor:=oldcolor;

for i:=Xradius downto 0  do
        begin
        setcolor(actcolor);
        ellipse(x,y,90,270,i,Yradius);
        case actcolor of
        0..15:actcolor:=(actcolor+1) mod 16;
        16..32:actcolor:=(actcolor+1) mod 16 +16;
        33..255:begin
                actcolor:=(actcolor+1) mod 256;
                if actcolor<33 then actcolor:=33;
                end;
        end;
        end;

line(X,Y+Yradius,X,Y-Yradius);

for i:=0 to Xradius  do
        begin
        setcolor(actcolor);
        ellipse(x,y,270,90,i,Yradius);
        case actcolor of
        0..15:actcolor:=(actcolor+1) mod 16;
        16..32:actcolor:=(actcolor+1) mod 16 +16;
        33..255:begin
                actcolor:=(actcolor+1) mod 256;
                if actcolor<33 then actcolor:=33;
                end;
        end;
        end;
{fillellipse(random(mx)-r,random(my),r,round(r*xratio/yratio));}
setcolor(oldcolor);
end;

procedure movescren(n:word);
const line:integer=0;
var   i:word;
      line1:integer;
      endline:integer;
begin
if line>mx then line:=0;
endline:=line+n;
if endline>mx then endline:=mx;

repeat
line1:=line+1;
for i:=0 to my do
    putpixel(line,i,getpixel(line1,i));
line:=line1;
if keypressed then exit;
until line>endline;

end;

var i,r:longint;
    col:word;
begin
randomize;


if paramcount>0 then
           begin
           val(paramstr(1),i,col);
           if col<>0 then i:=0;

           if paramcount>1 then
              setuserdriver(paramstr(2),i)
              else
              setuserdriver('',i);
           end;
(*graph2testinit('\tup'){,nil)};*)
graph2init(BGIPATH,nil);
setbkcolor(color[1]);
maxcolor:=64;
setfillstyle(solidfill,color[1]);
bar(0,0,mx,my);
for i:=1 to 5+random(100) do
                     begin
                     r:=50 div (random(50)+1) ;
                     col:=random(maxcolor+1);
                     setcolor(col);
{                     fillellipse(random(mx)-r,random(my),r,round(r*xratio/yratio));}
                     fillellipse(random(mx-2*r)+r,random(my-2*r)+r,r,round(r*xratio/yratio));
                     end;

setcolor(maxcolor);

repeat
bum3(random(mx),random(my),5000 div (random(500)+1) );
movescren(sx div 8);
if random(100)=0 then
                     begin
                     r:=50 div (random(50)+1) ;
                     col:=random(maxcolor+1);
                     setcolor(col);
                     fillellipse(mx-r,random(my),r,round(r*xratio/yratio));
                     setcolor(maxcolor);
                     end;

until keypressed;

end.