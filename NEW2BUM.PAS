program wybuch;
uses crt,graph,graph2;
var ekran:array[0..199,0..319] of byte absolute $A000:$0000;
procedure bum1(x,y:integer;n:word);
var i:word;
    oldcolor:word;
    n2:word;
    tab:array[0..1000] of pointtype;
begin
{sound(50);}
oldcolor:=getcolor;
if n>1000 then N:=1000;
n2:=n div 2;
setwritemode(Xorput);
for i:=0 to n do
    begin
    tab[i].X:=x+random(n)-n2;
    tab[i].Y:=y+random(n)-n2;
    line(x,y,tab[i].X,tab[i].Y);
{    sound(i div 4);}
    end;
for i:=n downto 0 do
    begin
    line(x,y,tab[i].x,tab[i].y);
{    sound(i div 4);  }
    end;

setcolor(oldcolor);
nosound;
end;

procedure bum2(x,y:integer;n:word);
var i:word;
    oldcolor,lockolor,modmax:word;
    ne,ne2:longint;
    ext:boolean;
    point:array[0..1000] of record
                         xp,yp,xo,yo,dx,dy:integer;
                         col:word;
                         end;
begin
{sound(50);}
if n>1000 then n:=1000;
oldcolor:=getcolor;
lockolor:=color[white];
modmax:=maxcolor+1;
if lockolor=0 then lockolor:=1;
setcolor(lockolor);
setwritemode(xorput);
ne:=n div 5;
for i:=0 to n do
    with point[i] do
    begin
    ne2:=random(nE);
    if(ne2<20)then
      ne2:=10+random(20);
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

repeat
ext:=true;

for i:=n downto 0 do

    with point[i] do
    begin
    setcolor(col);
    line(xo,yo,xp,yp);
    xo:=xp;
    yo:=yp;
    xp:=xp+dx;
    yp:=yp+dy;
    col:=(col+1) mod modmax;
    if(col=0) then col:=1;
    setcolor(col);
    line(xo,yo,xp,yp);
    if (xo>=0)and(xo<=mx)and(yo>=0)and(yo<=my) then
       ext:=false;
    end;
until ext;

setcolor(oldcolor);
end;

procedure bum3(x,y:integer;n:word);
var i,j:word;
    oldcolor,lockolor,modmax:word;
    stop:boolean;
    pom:real;
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
ne:=n div (random(25)+1);
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

repeat
stop:=true;
for i:=n downto 0 do

    with point[i] do
    begin
    setcolor(col);
    line(xo,yo,xp,yp);
    xo:=xp;
    yo:=yp;
    pom:=dx;
    dx:=round( pom-pom/2 );
    pom:=dy;
    dy:=round( pom-pom/2 );
    xp:=xp+dx;
    yp:=yp+dy;
    col:=(col+1) mod modmax;
    if(col=0) then col:=1;
    setcolor(col);
    line(xo,yo,xp,yp);
    if (abs(dx)>1) or (abs(dy)>1) then stop:=false;
    end;
until stop;

for i:=n downto 0 do

    with point[i] do
    begin
    setcolor(col);
    line(xo,yo,xp,yp);
    end;

setcolor(oldcolor);
end;

procedure bum4(x,y:integer;n:word);
var i,j:word;
    oldcolor,lockolor,modmax:word;
    stop:boolean;
    pom:real;
    byt:^byte;
    ne,ne2:longint;
    point:array[0..1000] of record
                         xo,yo,dx,dy:integer;
                         col:word;
                         end;
begin
{sound(50);}
if n>1000 then n:=1000;
oldcolor:=getcolor;
lockolor:=random(maxcolor);
modmax:=maxcolor+1;
if lockolor=0 then lockolor:=1;
ne:=n div (random(45)+1);
for i:=0 to n do
    with point[i] do
    begin
    ne2:=random(nE);
    dx:=round(sin(i)*ne2);
    dy:=round(cos(i)*ne2*xratio/yratio);
    xo:=x;
    yo:=y;
    xo:=x+dx;
    yo:=y+dy;
    col:=lockolor;
    if(xo<0)or(xo>319)or(yo<0)or(yo>199) then
                                         begin
                                         xo:=x;
                                         yo:=y;
                                         end;
    byt:=@ekran[yo,xo];
    byt^:=byt^ xor col;
    end;
nosound;

repeat
stop:=true;
for i:=n downto 0 do
    with point[i] do
    begin
    byt:=@ekran[yo,xo];
    byt^:=byt^ xor col;
    pom:=dx;
    dx:=round( pom-pom/2 );
    pom:=dy;
    dy:=round( pom-pom/2 );
    xo:=xo+dx;
    yo:=yo+dy;
    col:=(col+1) mod modmax;
    if(col=0) then col:=1;
    if(xo<0)or(xo>319)or(yo<0)or(yo>199) then
                                         begin
                                         xo:=x;
                                         yo:=y;
                                         end;
    if (abs(dx)>1) or (abs(dy)>1) then stop:=false;
    byt:=@ekran[yo,xo];
    byt^:=byt^ xor col;
    
    end;
until stop;

for i:=n downto 0 do

    with point[i] do
    begin
    byt:=@ekran[yo,xo];
    byt^:=byt^ xor col;
    end;

setcolor(oldcolor);
end;

procedure fillellipseP(x,y:integer;Xradius,Yradius:word);
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
setcolor(oldcolor);
end;

procedure fillellipse(x,y:integer;Xradius,Yradius:word);
var krokkolor,actkolor,i:word;
begin
krokkolor:=2*xradius div 8;
if krokkolor=0 then krokkolor:=1;
actkolor:=getcolor;
if actkolor<32 then actKolor:=32;
if actkolor>(32+24) then actkolor:=32+actkolor mod 24;

setcolor(actkolor);
for i:=xradius downto 0 do
    begin
    ellipse(x,y,90,270,i,yradius);
    if (i mod krokkolor)=0 then begin
                         actkolor:=(actkolor+24);
                         if actkolor>247 then actkolor:=16+random(8);
                         setcolor(actkolor);
                         end;
    end;
line(X,Y+Yradius,X,Y-Yradius);
for i:=1 to xradius do
    begin
    ellipse(x,y,270,90,i,yradius);
    if (i mod krokkolor)=0 then begin
                         actkolor:=(actkolor+24);
                         if actkolor>247 then actkolor:=16+random(8);
                         setcolor(actkolor);
                         end;
    end;
end;

const n:word=100;
procedure movescren;
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

procedure movescren13H;
const line:integer=0;
var   i:word;
      line1:integer;
      endline:integer;
begin
if line>319 then line:=0;
endline:=line+n;
if endline>319 then endline:=mx;

repeat
line1:=line+1;
for i:=0 to 199 do
               ekran[i,line]:=ekran[i,line1];
line:=line1;
if keypressed then exit;
until line>endline;

end;

procedure movescrenLEFT;
var i:word;
    ek:byte;
begin
for i:=0 to 199 do
 begin
 ek:=ekran[i,0];
 move(ekran[i,1],ekran[i,0],319);
 ekran[i,319]:=ek;
 end;
end;

procedure movescrenRIGHT;
var i:word;
    ek:byte;
begin
for i:=0 to 199 do
 begin
 ek:=ekran[i,319];
 move(ekran[i,0],ekran[i,1],319);
 ekran[i,0]:=ek;
 end;
end;

procedure movescrenUP;
var
    ek:array[0..319] of byte;
begin
 move(ekran[0,0],ek,320);
 move(ekran[1,0],ekran[0,0],320*199);
 move(ek,ekran[199,0],320);
end;

procedure movescrenDOWN;
var
    ek:array[0..319] of byte;
begin
 move(ekran[199,0],ek,320);
 move(ekran[0,0],ekran[1,0],320*199);
 move(ek,ekran[0,0],320);
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
graph2init('\tp\bgi',nil);
setbkcolor(color[1]);
n:=mx;
{setfillstyle(solidfill,color[1]);
bar(0,0,mx,my);}
for i:=1 to 5+random(100) do
                     begin
                     r:=50 div (random(50)+1) ;
                     col:=random(maxcolor+1);
                     setcolor(col);
                     fillellipse(random(mx)-r,random(my),r,round(r*xratio/yratio));
                     end;

setcolor(maxcolor);
putpixel(mx,0,lightred);
putpixel(0,0,lightred);
putpixel(0,my,lightred);
putpixel(mx,my,lightred);
repeat
case random(1) of
3:bum3(random(mx),random(my),5000 div (random(130)+1) );
2:bum2(random(mx),random(my),4000 div (random(450)+1) );
1:bum1(random(mx),random(my),2000 div (random(200)+1) );
0:bum4(random(mx),random(my),2000 div (random(100)+1) );
end;

{movescren;}
{movescren13h;}
{movescrenLEFT;}
movescrenright;
{movescrenUp;}
{movescrenDOWN;}
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