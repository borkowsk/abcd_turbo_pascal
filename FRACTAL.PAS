  program FRACTALe;
  uses crt,graph,GRAPH2;
  Var ster,tryb:integer;
      key:char;
  const jedenx:integer=100;
        jedeny:integer=100;
        jedenz:integer=100;
        RX:real=0.5;
        RY:real=0.5;
        maxnp=4;{najwieksza dlugosc paternu funkcji Lapunow}
  type fun3n= function(x,y:real):real;
  var f:fun3n;
      NUMBER:word;{ilosc powtorzen w funkcji lapunow}
      np:byte;{dlugosc paternu funkcji Lapunow}
      pattern:array[1..maxnp] of char;{patern funkcji Lapunow}
  procedure setup;
  begin
  write('JEDNOSTKA X W PIXELACH :');
  read(jedenx);

  write('JEDNOSTKA Y W PIXELACH :');
  read(jedeny);
  end;
  {$F+}
  FUNCTION XrazyY(X,Y:REAL):real;
  BEGIN
  xrazyy:=X*Y;
  END;
  FUNCTION sq(X,Y:REAL):real;
  BEGIN
  sq:=sqr(X*Y);
  END;
  FUNCTION sqrt2(X,Y:REAL):real;
  BEGIN
  sqrt2:=sqrt(abs(X*Y));
  END;
  FUNCTION x2plusY2(X,Y:REAL):real;
  BEGIN
  x2plusy2:=sqr(X)+sqr(y);
  END;
  FUNCTION sinxplussinY(X,Y:REAL):real;
  BEGIN
  sinxplussiny:=sin(X)+sin(y);
  END;
  FUNCTION cosxplussinY(X,Y:REAL):real;
  BEGIN
  cosxplussiny:=cos(X)+sin(y);
  END;
  FUNCTION cosxpluscosY(X,Y:REAL):real;
  BEGIN
  cosxpluscosy:=cos(X)+cos(y);
  END;
  FUNCTION sinx2plusY2(X,Y:REAL):real;
  BEGIN
  sinx2plusy2:=sin(sqrt(X*x+y*y));
  END;
  FUNCTION cosxrazycosY(X,Y:REAL):real;
  BEGIN
  cosxrazycosy:=cos(X)*cos(y);
  END;
  FUNCTION expxy(X,Y:REAL):real;
  BEGIN
  expxy:=exp(X*y);
  end;
  const maxN=10;
  aktN:word=10;
  var
  wsp:array[0..maxN] of real;
  yp:array[0..maxN] of real;
  xp:array[0..maxN] of real;
  procedure randwsp;
  var i:word;
  begin
  for i:=0 to aktN+1 do wsp[i]:=random*2-1;
  end;
  FUNCTION wiel(X,Y:REAL):real;
  CONST POM:REAL=0;
        pom2:real=0;
        pom3:real=0;
       i:integer=0;
       j:integer=0;
  BEGIN
  pom:=1;
  pom2:=1;
  xp[0]:=1;
  yp[0]:=1;
  for i:=1 to aktN do begin
                   pom:=pom*x;
                   pom2:=pom2*y;
                   yp[i]:=pom2;
                   xp[i]:=pom;
                   end;
      pom:=0;
      for j:=0 to aktN do
                     begin
                     POM:=wsp[j]*xp[j]*yp[aktN-j]+pom;
                     end;
  wiel:=POM;
  end;
  FUNCTION cosxrazyy(X,Y:REAL):real;
  BEGIN
  cosxrazyy:=cos(X)*y;
  END;
  FUNCTION cosxy(X,Y:REAL):real;
  BEGIN
  cosxy:=cos(X*y);
  end;

FUNCTION x2plussinY(X,Y:REAL):real;
  BEGIN
  x2plussiny:=sqr(X)+sin(y);
  END;

FUNCTION Lapunow(x,y:real):real;
var total,wx,aktr,aktrWX,log2:real;
    i:word;
begin
log2:=ln(2);
total:=0;
wx:=0.00000002;
for i:=1 to NUMBER do
       begin
       if pattern[i mod np]='0' then aktr:=x
                                else aktr:=y;
       if aktr=0 then begin
                      lapunow:=0;
                      exit;
                      end;
       aktrwx:=aktr*wx;
       wx:=aktrWx*(1-wx);
       total:=total+((ln(abs(aktr-2*aktrWx))/log2));
       end;
total:=total/NUMBER;
if total>0 then lapunow:=0
           else lapunow:=total;
end;

  {$F-}
  procedure SETLAPUNOW;
  var i:byte;
  begin
  writeln('USTALENIE PARAMETROW FUNKJI LAPUNOWA >');
  write('DLUGOSC PATERNU:');
  readln(np);
  write('PATERN ( 0 lub 1) :');
  for i:=0 to np-1 do begin pattern[i]:=readkey; write(pattern[i]);end;
  writeln;
  write('ILOSC ITERACJI :');
  read(NUMBER);
  f:=lapunow;
  end;

  procedure WYKRESY;
     var  x,y,lx,ly:integer;
        xr,yr:real;
       i,sx,sy,kreskax,kreskay:integer;
       sstr:string[3];
   begin
   drawborder;
    {*rysowanie ukladu wspolrzednych*}
    sx:=getmaxx div 2;
    sy:=getmaxy div 2;
    kreskax:=jedenx div 10;
    kreskay:=jedeny div 10;
    line(sx,0,sx,2*sy);
    outtextXY(sx-3,0,'^');          {*os OY*}
{ SKALOWANIE };
   i:=1;
   ly:=sy-jedeny;
   y:=sy+jedeny;
   repeat
   moveto(sx-kreskax,ly);
   lineto(sx+kreskax,ly);
   str(i,sstr);
   outtext(sstr);
   moveto(sx-kreskax,y);
   lineto(sx+kreskax,y);
   sstr:='-'+sstr;
   outtext(sstr);
   inc(i);
   ly:=ly-jedeny;
   y:=y+jedeny;
   until y>=2*sy;

   line(0,sy,2*sx,sy);
   outtextXY(2*sx-6,sy-3,'>');     {*os OX*}
   { SKALOWANIE };
   i:=1;
   lx:=sx-jedenx;
   x:=sx+jedenx;
   repeat
   moveto(x,sy+kreskay);
   lineto(x,sy-kreskay);
   moverel(0,kreskay*2);
      str(i,sstr);
   if textwidth(sstr)<jedenx then outtext(sstr);
   moveto(lx,sy+kreskay);
   lineto(lx,sy-kreskay);
   moverel(0,kreskay*2);
   sstr:='-'+sstr;
   if textwidth(sstr)< jedenx then outtext(sstr);
   inc(i);
   lx:=lx-jedenx;
   x:=x+jedenx;
   until x>=2*sx;

     {*rysowanie funkcji  *}
{   y:=sy;
   repeat
    x:=-sx;
    repeat
         xr:=x/jedenx;
         yr:=y/jedeny;
         setfillstyle(solidfill,round(f(xr,yr)));
         bar(x+sx-3,-y+sy-3,x+sx+2,-y+sy+2);
         if keypressed then exit;
    inc(x,5);
    until x>sx;
    dec(y,5);
    until Y<-sy;}{?????????????}
     {*rysowanie funkcji  *}
     moveto(-10,-10-sy);
    setlinestyle(dottedln,0,normwidth);
   for y:=sy downto -sy do
    for x:=-sx to sx do
    begin
         xr:=x/jedenx;
         yr:=y/jedeny;
       PUTPIXEL(x+sx,-y+sy,round(F(XR,YR)));
       if keypressed then exit;
    end;
{  setlinestyle(solidln,0,normwidth);
  repeat
         fractal(rx,ry);
         yr:=ry*jedeny;
          if abs(yr)<32767 then
                           y:=round(yr);
         xr:=rx*jedeny;
          if abs(xr)<32767 then
                           x:=round(xr);
         putpixel(x+sx,-y+sy,white);
  until  keypressed;}
  key:=readkey;
  key:=#0;
  outtextxy(getmaxX-196,getmaxY-16,'ESC - wyjscie z programu');
  outtextxy(getmaxX-208,getmaxY-8,'xxxxxxxxxxxxxxxxxxxxxxxxxx');
  key:=readkey;
  end;{ WYKRESY }
  procedure trzywymiary;
  var xr,yr,zr,xmax,ymax,xmin,ymin:real;
      x,y,xp,yp:integer;
  const sq22=1.4142135624;
begin
   drawborder;
       {*rysowanie funkcji  *}
   y:=sy;
   repeat
    x:=-sx;
    repeat
         xr:=x/jedenx;
         yr:=y/jedeny;
         zr:=f(xr,yr)*jedenz;
         xp:=round((xr-sq22*yr/2));
         yp:=round((-zr+sq22*y/2));
         setcolor(round(zr));
       lineto(xp,yp);
       if keypressed then exit;
    inc(x,5);
    until x>sx;
    dec(y,5);
    until Y<-sy;


  end;{trzy...}
  BEGIN
  randomize;
  aktN:=5;
  randwsp;
{ f:=cosxpluscosy;}
{ f:=wiel;}
{ f:=cosxy;}
{ f:=sinx2plusY2;}
{ f:=x2plusY2;}
{ f:=expxy;}
  setup;
  setlapunow;
{ graph2init('',nil);}
  graph2testinit('');

    wykresy;
{trzywymiary;}

  END.