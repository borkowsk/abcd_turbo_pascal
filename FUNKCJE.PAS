
program funkcje2and3;
  {*program rysuje funkcje i liczy jej calke w zadanym przedziale
         metoda Simpsona'a
          *WOJCIECH BORKOWSKI & ANNA MOKWA  1991*}
{$N+}
{$E+}
uses crt,graph,graph2;
  type
      funkcjatyp=function(x:extended):extended;
   var

      simps:boolean;
      cyfra:string;
      key:char;
      typ:byte;
      funkcja:funkcjatyp;
      skok,kon:extended;
  const zakonczenie:boolean=false;
        pocz:real=-1;
        zakr:real=2;
        ilpasow:word=10;
        jedenx:integer=150;
        jedeny:integer=250;
   {$F+}
   function x3(x:extended):extended;
   begin
   x3:=x*x*x;
   end;
   function odw(x:extended):extended;
   begin
   if x<>0 then
           odw:=1/x
           else
           odw:=0;
   end;
   function odwkw(x:extended):extended;
   begin
   if x<>0 then
           odwkw:=1/sqr(x)
           else
           odwkw:=0;
   end;
   function odwsz(x:extended):extended;
   begin
   if x<>0 then
           odwsz:=1/(x*sqr(x))
           else
           odwsz:=0;
   end;
   function odwpier(x:extended):extended;
   begin
   if x>0 then
           odwpier:=1/sqrt(x)
           else
           odwpier:=0;
   end;
   function odwln(x:extended):extended;
   var p:extended;
   begin
   if x>0 then p:=ln(x)
          else p:=0.0000000001;
   if p<>0 then odwln:=1/p
           else
           odwln:=0;
   end;
   function odwexp(x:extended):extended;
   begin
           odwexp:=1/exp(x)
   end;
   function odwarc(x:extended):extended;
   begin
   if x<>0 then
           odwarc:=1/arctan(x)
           else
           odwarc:=0;
   end;
   function xsin1x(x:extended):extended;
   begin
   if x=0 then xsin1x:=0
          else xsin1x:=x*sin(1/x);
   end;
   function odwsin(x:extended):extended;
   var p:extended;
   begin
   p:=sin(x);
   if p=0 then odwsin:=0
          else odwsin:=1/p;
   end;
   function odwcos(x:extended):extended;
   var p:extended;
   begin
   p:=cos(x);
   if p=0 then odwcos:=0
          else odwcos:=1/p;
   end;
   function xcos1x(x:extended):extended;
   begin
   if x=0 then xcos1x:=0
          else xcos1x:=x*cos(1/x);
   end;
   function xsinx(x:extended):extended;
   begin
        xsinx:=x*sin(x);
   end;
   function xcosx(x:extended):extended;
   begin
      xcosx:=x*cos(x);
   end;
   function xcoskwx(x:extended):extended;
   begin
      xcoskwx:=x*sqr(cos(x));
   end;
   function sinxcosx2(x:extended):extended;
   begin
      sinxcosx2:=sin(x)*cos(sqr(x));
   end;
   function sinx2cosx(x:extended):extended;
   begin
      sinx2cosx:=sin(sqr(x))*cos(x);
   end;
   function sinx2cosx2(x:extended):extended;
   begin
      sinx2cosx2:=sin(sqr(x))*cos(sqr(x));
   end;
   function usr(x:extended):extended;
   begin
        usr:=sin(x/2)*sin(x)*sin(x/5);
   end;
   function standard(x:extended):extended;
   begin
        case typ of
        1:standard:=x;
        7:standard:=sin(x);
        8:standard:=cos(x);
        6:standard:=exp(x);
        2:standard:=sqr(x);
        9:standard:=arctan(x);
        4:if x<0 then standard:=0
                   else standard:=sqrt(x);
        5:if x>0 then standard:=ln(x)
                   else standard:=0;
        else standard:=1;
        end;
        end;
   {$F-}
   procedure WYBOR;
   begin
   writeln(' Funkcje do wyboru');
   writeln(' +---A------B-------C-------D--------E----------F------------------');
   Writeln(' 1 x       1/x                              xsin(1/x)');
   writeln(' 2 x*x     1/xý                             xcos(1/x) ');
   writeln(' 3 x*x*x   1/(x*x*x)                        xsin(x)');
   writeln(' 4 sqrt(x) 1/sqrt(x)                        xcos(x)');
   writeln(' 5 ln(x)   1/ln(x)                          xcosý(x)');
   writeln(' 6 exp(x)  1/exp(x)                         sin(x)cos(xý) ');
   writeln(' 7 sin(x)  1/sin(x)                         sin(xý)cos(x)  ');
   writeln(' 8 cos(x)  1/cos(x)                         sin(xý)cos(xý)');
   writeln(' 9 arctg(x)1/arctg(x)                       sin(x)sin(x/2)sin(x/5)');
   write(' Podaj funkcje :  ');
   typ:=0;
   repeat
     KEY:=READKEY;
     key:=upCASE(KEY);
     case key of
     'A':typ:=0;
     'B':typ:=10;
     'C':typ:=20;
     'D':typ:=30;
     'E':typ:=40;
     'F':typ:=50;
     else begin
          writeln('Wcisneles ',key,'.Chyba sie pomyliles.Wcisnij A,B,C,D,E lub F');
          key:=#255;
          end;
     end;
   until key<>#255;
   write(key);
   repeat
     KEY:=READKEY;
     write(key);
     case key of
     '1':typ:=typ+1;
     '2':typ:=typ+2;
     '3':typ:=typ+3;
     '4':typ:=typ+4;
     '5':typ:=typ+5;
     '6':typ:=typ+6;
     '7':typ:=typ+7;
     '8':typ:=typ+8;
     '9':typ:=typ+9;
     else begin
          writeln('Wcisneles ',key,'.Chyba sie pomyliles.Wcisnij cyfre od 1 do 9');
          key:=#255;
          end;
     end;
     writeln;
   until key<>#255;
     case typ of
      3:funkcja:=x3;
     11:funkcja:=odw;
     12:funkcja:=odwkw;
     13:funkcja:=odwsz;
     14:funkcja:=odwpier;
     15:funkcja:=odwln;
     16:funkcja:=odwexp;
     17:funkcja:=odwsin;
     18:funkcja:=odwcos;
     19:funkcja:=odwarc;
     51:funkcja:=xsin1x;
     52:funkcja:=xsinx;
     53:funkcja:=xcosx;
     54:funkcja:=xcos1x;
     55:funkcja:=xcoskwx;
     56:funkcja:=sinxcosx2;
     57:funkcja:=sinx2cosx;
     58:funkcja:=sinx2cosx2;
     59:funkcja:=usr;
     else
       funkcja:=standard;
     end{ CASE TYP };
   end{ WYBOR };

   procedure USTAL_ZAKRES;
    begin
          writeln(' Zakres od ',pocz,' do',pocz+zakr,'. (t/n)');
          key:=readkey;
          if key='n'then
                    begin
                    write('Poczatek zakresu :');
                    read(pocz);
                    write('Rozmiar : ');
                    read(zakr);
                    end;
          writeln(' Ilosc pasow ',ilpasow,'. (t/n)');
          key:=readkey;
          if key='n'then
                    begin
                    write('Nowa ilosc pasow  :');
                    read(ilpasow);
                    end;
          skok:=zakr/ilpasow;
          kon:=pocz+zakr;
          writeln('Nowy zakres od',pocz,' do',pocz+zakr,'.');
          writeln('Szerokosc pasa :',skok);

       writeln('Press any key !');
       key:=readkey;
    end;

  function CALKATrap(a,b:extended;LFUN:FUNKCJATYP):extended;
  Begin
  calkatrap:=(b-a)*(lfun(a)+lfun(b))/2;
  End;
  function CALKASimps(a,b:extended;lfun:funkcjatyp):extended;
  begin
  calkasimps:=((b-a)/6)*(lfun(a)+4*lfun((a+b)/2)+lfun(b));
  end;
  procedure WYKRESY;
   var  x,y,lx,ly:integer;
        xr1,xr2,yr,summa:extended;
        i,kreskax,kreskay:integer;
        sstr:string[3];
   begin
    {*rysowanie ukladu wspolrzednych*}
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
   moveto(-10,-10-sy);
   y:=-sy*2;
   setlinestyle(dottedln,0,normwidth);
   for x:=-sx to sx do
    begin
        xr1:=x/jedenx;
        yr:=funkcja(xr1);
        yr:=yr*jedeny;
        if abs(yr)<32767 then
                           y:=round(yr);
       lineto(x+sx,-y+sy);
    end;
   {*Rysowanie calki*}
     moveto(0,sy);
     setlinestyle(dottedln,0,normwidth);
     summa:=0;
     yr:=0;
     xr1:=pocz;
     for i:=0 to ilpasow do
         begin
         yr:=summa;
         yr:=yr*jedeny;
         if abs(yr)<32767 then
                          y:=round(yr);
                          x:=round(xr1*jedenx)+sx;
         lineto(x,-y+sy);
         line(x,sy,x,-round(funkcja(xr1)*jedeny)+sy);
         setviewport(0,0,sx-1,8,true);
         clearviewport;
         str(summa:18:10,cyfra);
         outtext('Calka='+cyfra);
         setviewport(0,0,2*sx,2*sy,false);
         moveto(x,-y+sy);
         xr2:=xr1+skok;
         if simps then summa:=summa+calkasimps(xr1,xr2,funkcja)
                  else summa:=summa+calkatrap(xr1,xr2,funkcja);
         xr1:=xr2;
         end;
  outtextxy(getmaxX-196,getmaxY-16,'ESC - wyjscie z opcji z-zakonczenie');
  outtextxy(getmaxX-208,getmaxY-8,'t-ak samo f-unkcja w-ymiar');
  end;{ WYKRESY }
  {PROGRAM GLOWNY}
  begin
  clrscr;
{  graph2testInit('');}
  graph2init('',nil);
  restorecrtmode;
  repeat
  if key='z' then zakonczenie:=true
           else
           begin
  if key<>'t'then
             begin
  if key<>'w'then wybor;
  if key<>'f'then
           begin
           writeln('Podaj jednostke :');
           write('x: ');
           read(jedenx);
           write('y: ');
           read(jedeny);
           end;
             end;
writeln('Wybierz metode trapezow czy Simpsona (t/s)');
  key:=readkey;
  key:=upcase(key);
  if key='s'then simps:=true
            else simps:=false;
  ustal_zakres;

  setgraph2mode(mode);
  wykresy;
  key:=readkey;
  restorecrtmode;
           end;{blok wykonania}
  until zakonczenie;
  closegraph;
  end.
