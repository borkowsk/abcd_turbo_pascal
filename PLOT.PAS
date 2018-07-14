program timeplot;
uses graph;
const maxindex=2000; {Najwieksza dopuszczalna liczba lini w pliku danych}
      MaxReal=1.7e38;
      MinReal=-1.7e38;
var   bigtable:array[0..maxindex] of real;{ tablica na dane }
const BGIpath:string[128]=' ';    { sciezka do BGI }
      { glowne zmienne }
const filename:string[128]='???'; { nazwa pliku z danymi }
const currindex:integer=0; {ilosc faktycznie wczytanych danych}
      _minvalue:real=MaxReal;{ najmniejsza wartosc w pliku }
      _maxvalue:real=MinReal;{ najwieksza wartosc w pliku }


      { parametry konfiguracyjne }
const FixMax:real=MinReal;
      FixMin:real=MaxReal;
      Xstart:word=1;           {poczatek wartosci X}
      Xlen:word=255;           {szerokosc wartosci X - do wycinania}
      MultVal:word=2;          {ilosc pixeli na wartosc w opcji MUL}
      wait_on:boolean=TRUE;    {czekanie po wydrukach tekstowych}

function ioerror:boolean;
{ funkcja kontroli I/O -moze zostac rozbudowana }
var ecode:integer;
begin
ecode:=ioresult;
if ecode = 0 then begin
             ioerror:=false;
             exit;
             end;
ioerror:=true;
writeln('Blad wejscia/wyjscie nr ',ecode);
end;

procedure  GetXval(line:string;var value:real;var ecode:integer);
{wczytuje X z odpowiedniej kolumny}
begin
line:=copy(line,Xstart,Xlen);
val(line,value,ecode);
end;

procedure SetMaxVal(v:real);
begin
_maxvalue:=v;
end;

procedure SetMinVal(v:real);
begin
_minvalue:=v;
end;
function  GetMaxVal:real;
{ Zwraca faktyczny Max lub zafixowany }
begin
if FixMax>MinReal then GetMaxVal:=FixMax
                  else GetMaxVal:=_maxvalue;
end;

function  GetMinVal:real;
{ Zwraca faktyczny Min lub zafiksoawany }
begin
if FixMin<MaxReal then GetMinVal:=FixMin
                  else GetMinVal:=_minvalue;
end;

procedure outreal(r:real);
var s:string;
begin
str(r,s);outtext(s);
end;

procedure outint(l:longint);
var s:string;
begin
str(l,s);outtext(s);
end;

procedure writehelp;{ opis funkcji programu }
begin
writeln('Format polecenia:');
writeln;
writeln('     plot <file_name> [option_list]');
writeln;
writeln('gdzie mozliwe opcje to:');
writeln(' MINnn  ustawianie maksymalnej i minimalnej');
writeln(' MAXnn  wartosci na wykresie (nn)');
writeln(' XATnn-ll pozycje X w pliku nn-kolumna ll-dlugosc');
writeln(' PIX - wyswietlanie wartosci w postaci pikseli');
writeln(' MULn - tryb wieloekranowy dla duzych plikow, nn pixeli/wartosc');
writeln(' GR+/- wyswietlanie siatki skali - PIX resetuje ten parametr ');
writeln(' COLnn - zmiana koloru wykresu a nn to numer koloru: ');
writeln('    Black         0  DarkGray       8');
writeln('    Blue          1  LightBlue      9');
writeln('    Green         2  LightGreen    10');
writeln('    Cyan          3  LightCyan     11');
writeln('    Red           4  LightRed      12');
writeln('    Magenta       5  LightMagenta  13');
writeln('    Brown         6  Yellow        14');
writeln('    LightGray     7  White         15');
writeln(' BGIpath - sciezka do sterownikow BGI');
writeln(' NWT - wylanczenie czekania po wczytaniu danych ');
writeln('Opcje moga wystepowac wielokrotnie. Przetwarzane sa kolejno !');
writeln('P o g a n i a n i e  p r o g r a m u  z a  p o m o c a ENTER');
end;



procedure loaddata(name:string);{ ladowanie danych z pliku }
var afile:text;
    bufor:string;
    value:real;
    nonconv:integer;   {liczba linii nie nadajacych sie do konwersji}
    linecount:integer;{liczba linii w ogule wczytanych }
    ecode:integer;     {pozycja blendu}
    maxvalue,minvalue:real;
begin
maxvalue:=MinReal;
minvalue:=MaxReal;
nonconv:=0;linecount:=0;ecode:=0; {inicjalizacja}

if currindex=0 then               {informacja w wypadku powtornego czytania}
               writeln('Wczytuje dane z pliku ',name)
               else
               writeln('Dane z pliku ',name,' dopisuje do istniejacych.');
{ otwarcie pliku }
{$I-} {kontrola I/O OFF}
assign(afile,name);
reset(afile);
if ioerror then halt(2);
{czytanie }
while not eof(afile) do
      begin
      readln(afile,bufor);
      inc(linecount);
      GetXval(bufor,value,ecode);
      if ecode=0 then begin {liczba OK}
                 inc(currindex); { na puste miejsce }
                 if currindex>maxindex then begin
                                        writeln('Brak miejsca w tablicy!');
                                        halt(1);
                                        end;
                 bigtable[currindex]:=value; { zapamientanie wartosci }
                 if value>maxvalue then maxvalue:=value;
                 if value<minvalue then minvalue:=value;
                 end
                 else begin { liczba nie OK }
                 writeln('BLEDNY FORMAT LICZBY!: linia ',linecount,' pozycja ',ecode);
                 inc(nonconv);
                 end;
      if ioerror then halt(2);
      end;
close(afile);
if ioerror then halt(2);
{$I+} {kontrola I/O ON}

writeln('Przeczytano ',linecount,' linii.');
writeln('Tablica ma ',currindex,' wartosci.');
writeln('Min=',minvalue,' Max=',maxvalue);
SetMaxVal(maxvalue);{ Ustawianie globalnych Min i Max }
SetMinVal(minvalue);
{informacje w wypadku  blendow}
if nonconv<>0 then
              writeln('W pliku wykryto ',nonconv,' blednych linii.');
if wait_on then begin
           writeln('Wcisnij ENTER');
           readln;
           end;
end;

{ zmienne i parametry konfiguracyjne dla procedur graficznych }
var
mx:integer;{ najwieksza wspolzedna X ekranu }
my:integer;{ najwieksza wspolrzedna Y ekranu }
mc:word;   { najwyzszy numer koloru }
const
color:integer=LIGHTRED;{ kolor wykresu }
pix_only:boolean=FALSE; { sposob rysowania wykresu }
multiX:boolean=FALSE; { nie upychanie wszystkiego na jednym wykresie }
forceGrid:boolean=TRUE; { siatka skali - przy pixelach wylanczone }

procedure draw(beg,en:integer);forward;{wlasciwe rysowanie}
procedure multidraw;forward;           {rysowanie na wielu ekranach}

procedure plotdata;
{ zawiadywanie rysowaniem wykresu }
var
 grDriver: Integer;
 grMode: Integer;
 ErrCode: Integer;
begin
 grDriver := Detect;
 InitGraph(grDriver, grMode,BGIpath);
 ErrCode := GraphResult;
 if ErrCode = grOk then
 begin  { Do graphics }
 mx:=getmaxx;
 my:=getmaxy;
 mc:=getmaxcolor;
 if color>mc then color:=mc;
 if multiX then begin { wykres na wielu ekranach }
              multidraw;
              end
              else begin { wszystko na jednym wykresie }
              draw(1,currindex);
              readln;
              end;
 CloseGraph;
 end
 else
   Writeln('Graphics error:', GraphErrorMsg(ErrCode));
end;

procedure draw(beg,en:integer);
var jedenx,jedeny:real;
    i,x,y:integer;
    maxvalue,minvalue:real;
begin
maxvalue:=GetMaxVal;
minvalue:=GetMinVal;
jedeny:=(my-10)/(maxvalue-minvalue);
jedenx:=mx/(en-beg);
if en>currindex then en:=currindex; { zabezpieczenie gdy zafiksowana skala }
{ linie dla wartosci }
if forceGrid then begin
   setcolor(LIGHTBLUE);
   setlinestyle(UserBitLn,$1111,NormWidth);
   i:=round(minvalue);
   while i<maxvalue do begin
         y:=round( (maxvalue-i) * jedeny );
         line(0,y,mx,y);
         inc(i);
         end;
   end;

{ os X ukladu }
setcolor(WHITE);
setlinestyle(UserBitLn,$FFFF,NormWidth);
y:=round( maxvalue * jedeny );
line(0,y,mx,y);
line(mx-10,y-5,mx,y);
line(mx-10,y+5,mx,y);
{ poczatkowa pozycja kursora graficznego }
y:=round((maxvalue-bigtable[beg])*jedeny);
moveto(0,y);
{ rysowanie wartosci }
for i:=beg to en do begin
    x:=round( (i-beg)*jedenx );
    y:=round((maxvalue-bigtable[i])*jedeny);
    if forceGrid then begin
                setlinestyle(UserBitLn,$1111,NormWidth);
                setcolor(1);line(x,0,x,my);
                end;
    if pix_only then putpixel(x,y,color)
                else begin
                setlinestyle(SolidLn,0,NormWidth);
                setcolor(color);lineto(x,y);
                end;
    end;
{ krotki opis }
setcolor(LIGHTGRAY);
moveto(0,0);outreal(GetMaxVal);
moveto(0,my-10);outreal(GetMinVal);
end;

procedure multidraw;
var beg,en,krok:integer;
begin
krok:=round(currindex/(mx/multval));
beg:=1;
en:=round(mx/multval);
while beg<=currindex do begin
   draw(beg,en);
   setcolor(WHITE);
   moveto(mx div 3,0);
   outtext('Od ');outint(beg);outtext(' do ');outint(en);outtext(' Plik: '+filename);
   beg:=en+1;
   en:=en+round(mx/multval);
   readln;
   clearviewport;
   end;
end;


procedure ParseOption(s:string); { Ustawiane opcji wg stringow lini wywolania }

   procedure SetXat(s:string;var ecod:integer);
   {writeln(' XATnn-ll pozycje X w pliku nn-kolumna ll-dlugosc');}
   var p:string;
       b,e:word;
   begin
   ecod:=0;
   p:=s;
   b:=pos('T',s)+1;
   e:=pos('-',s);
   if e=0 then e:=255;
   s:=copy(s,b,e-b);
   val(s,Xstart,ecod);
   if  ecod<>0 then exit;{blad!}
   if  e=255 then begin
                  writeln('Pole X od kolumny ',Xstart,' na ',Xlen,' znakow.');
                  exit;
                  end;{ nie ma wiecej do czytania}
   s:=p;
   b:=pos('-',s)+1;
   s:=copy(s,b,255);
   val(s,Xlen,ecod);
   if ecod<>0 then begin
                   Xlen:=255;
                   writeln('Przyjeto maksymalna dlugosc pola ',Xlen,' !');
                   end;
   end;

var ecode:integer;
begin
if pos('XAT',s)<>0 then begin { gdzie jest X }
   SetXat(s,ecode);
   if ecode<>0 then
               writeln('Bledna wartosci opcji XAT!');
   end
   else
if pos('MIN',s)<>0 then begin { Fixed Minimum }
   s:=copy(s,pos('N',s)+1,255);
   val(s,FixMin,ecode);
   if ecode<>0 then writeln('Bledna wartosc Minimum!');
   end
   else
if pos('MAX',s)<>0 then begin { Fixed Maximum }
   s:=copy(s,pos('X',s)+1,255);
   val(s,FixMax,ecode);
   if ecode<>0 then writeln('Bledna wartosc Maximum!');
   end
   else
if pos('COL',s)<>0 then begin { kolory }
   s:=copy(s,pos('L',s)+1,2);
   val(s,color,ecode);
   if ecode<>0 then writeln('Bledna wartosc koloru!');
   end
   else
if pos('GR+',s)<>0 then begin { grid wlanczony }
   forceGrid:=TRUE;
   end
   else
if pos('GR-',s)<>0 then begin { grid wylanczony }
   forceGrid:=FALSE;
   end
   else
if pos('MUL',s)<>0 then begin { wiele ekranow }
   multiX:=TRUE;
   s:=copy(s,pos('L',s)+1,2);
   if length(s)>0 then begin
         val(s,MultVal,ecode);
         if ecode<>0 then writeln('Bledna wartosc dla opcji MUL!');
         end;
   end
   else
if pos('PIX',s)<>0 then begin { tryb pixelowy }
   pix_only:=TRUE;
   forceGrid:=FALSE;
   end
   else
if pos('NWT',s)<>0 then begin { brak czekania }
   wait_on:=FALSE;
   end
   else
if pos('BGI',s)<>0 then begin { sciezka do BGI }
   s:=copy(s,pos('I',s)+1,255);
   BGIpath:=s;
   end
   else
   writeln('Bledna opcja ',s);
end;


var i:integer;      { pomocnicza zmienne}
begin
filename:=paramstr(1);
if filename=''then begin
                   writeln('Nie podano nazwy pliku danych! /? wyswietla help.');
                   exit;
                   end;
if (filename='-?')or(filename='-h')or(filename='/?') then begin
                                                     writehelp;
                                                     exit;
                                                     end;
for i:=2 to paramcount do
         ParseOption(paramstr(i));

loaddata(filename);
if currindex<>0 then plotdata;
end.

