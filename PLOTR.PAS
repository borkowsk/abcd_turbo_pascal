program timeplot_interactiv;
uses graph,copy1;
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
      LabStart:word=1;         {poczatek wartosci Label}
      LabLen:word=255;         {szerokosc wartosci Label - do wycinania}
      MultVal:word=2;          {ilosc pixeli na wartosc w opcji MUL}
      MultipleMaxVal:word=320; {ale nie wiecej niz tyle wartosci na ekranie}
      NOTOVERWRITE:boolean=TRUE;
      wait_on:boolean=TRUE;    {czekanie po wydrukach tekstowych}

{ zmienne i parametry konfiguracyjne dla procedur graficznych }
var mx:integer;{ najwieksza wspolzedna X ekranu }
    my:integer;{ najwieksza wspolrzedna Y ekranu }
    mc:word;   { najwyzszy numer koloru }
const     color:integer=LIGHTRED;{ kolor wykresu }
       pix_only:boolean=FALSE;   { sposob rysowania wykresu }
         multiX:boolean=FALSE;   { nie upychanie wszystkiego na jednym wykresie }
      forceGrid:boolean=TRUE;    { siatka skali - przy pixelach wylanczone }


procedure draw(beg,en:integer);forward; { wlasciwe rysowanie }
procedure multidraw;forward;            { rysowanie na wielu ekranach }

function  error_kom(KOD:longint):string;
{ Komunikaty o bledach wejscia/wyjscia }
Var stringer:string[30];
    small:string[3];
Begin
case kod of
-14:stringer:=('B’‘dny numer czcionki');
-13:stringer:=('B’‘dny zbi¢r czcionki');
-12:stringer:=('Graficzny b’†d I\O ');
-11:stringer:=('Inny b’†d graficzny');
-10:stringer:=('Nie ma takiego trybu' );
-9:stringer:=('Brak pami‘ci dla czcionki');
-8:stringer:=('Brak zbioru *.CHR');
-7:stringer:=('Brak pami‘ci do wype’niania');
-6:stringer:=('Brak pami‘ci do wype’niania');
-5:stringer:=('Brak pami‘ci dla sterownika');
-4:stringer:=('B’‘dny zbi¢r sterownika');
-3:stringer:=('Nie znaleziono sterownika');
-2:stringer:=('Niew’ažciwy sprz‘t graficzny');
-1:stringer:=('Nie zainstalowano sterownika');
0:stringer:=('O.K.');
2:stringer:=('NIE MA TAKIEGO ZBIORU');
3:stringer:=('NIE MA TAKIEJ SCIE¡KI');
4:stringer:=('ZA DUZO OTWAR• PLIK£W');
5:stringer:=('DOSTP ZABRONIONY');
6:stringer:=('BLDNA OPERACJA');
12:stringer:=('BœDNY KOD DOSTPU');
15:stringer:=('BœEDNY ZNAK NAPDU');
100:stringer:=('BœDNY ODCZYT DYSKU');
101:stringer:=('BœDNY ZAPIS DYSKU');
102:stringer:=('BœDNY ZAPIS DYSKU');
103:stringer:=('PLIK NIE OTWARTY');
104:stringer:=('PLIK NIE OTWARTY DO WEJ˜CIA');
105:stringer:=('PLIK NIE OTWARTY DO WYJ˜CIA');
106:stringer:=('NIEWœA˜CIWA POSTA• LICZBY');
160:stringer:=('AWARIA URZDZENIA ');
else begin
    STR(KOD,SMALL);
    stringer:=CONCAT('BœD I/O N# ',small);
    end;
end;
error_kom:=stringer;
end;{ errorKOM }
{--------------------------------------------------------------------}
{$F+}
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
writeln('I/O error: ',error_kom(ecode));
end;
{$F-}
function MyInitGraph(var grDriver:integer;var grMode:integer):boolean;
var ErrCode: Integer;
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
      MyInitGraph:=TRUE; {SUKCES!}
     end
     else
     begin
     Writeln('Graphics error:', GraphErrorMsg(ErrCode));
     MyInitGraph:=FALSE; { CoS NIE TAK!}
     end;
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
writeln('Format polecenia:      plot <file_name> [option_list]');
writeln('    gdzie mozliwe opcje to:');
writeln(' -I     - tryb interakcyjny - zamiast nazwy pliku!');
writeln(' MINnn  ustawianie maksymalnej i minimalnej');
writeln(' MAXnn  wartosci na wykresie (nn)');
writeln(' YATnn-ll pozycje wartosci w pliku nn-kolumna ll-dlugosc');
writeln(' PIX - wyswietlanie wartosci w postaci pikseli');
writeln(' MULn - tryb wieloekranowy dla duzych plikow, nn pixeli/wartosc');
writeln(' OVRnn - nakladanie przy trybie MUL, najwieksza liczba wartosci na ekran');
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
writeln(' PRNpath - sciezka do drukarki. - brak drukowania');
writeln(' NWT - wylanczenie czekania po wczytaniu danych ');
writeln('Opcje moga wystepowac wielokrotnie. Przetwarzane sa kolejno !');
writeln('P o g a n i a n i e  p r o g r a m u  z a  p o m o c a ENTER');
end;

procedure writeanghelp;{ opis funkcji programu po angielsku }
begin
writeln('USAGE:      plot <file_name> [option_list]');
writeln(' possible option are:');
writeln(' -I     - interactive mode - replaced file name!');
writeln(' MINnn  Set fixed maximal or minimal value');
writeln(' MAXnn           on the plot (nn)');
writeln(' YATnn-ll - Set value field position nn-column ll-width');
writeln(' PIX(-) - Plot only pixels - or plot lines');
writeln(' MULnn - Turn multi-screen mode on. nn- pixels/value');
writeln(' OVRnn - Turn overwrite mode on, nn- values per screen');
writeln(' GR+/- Turn gridlines on/off. If PIX mode is on - default is GR-');
writeln(' COLnn - Set color of value line. nn is from this set: ');
writeln('    Black         0  DarkGray       8');
writeln('    Blue          1  LightBlue      9');
writeln('    Green         2  LightGreen    10');
writeln('    Cyan          3  LightCyan     11');
writeln('    Red           4  LightRed      12');
writeln('    Magenta       5  LightMagenta  13');
writeln('    Brown         6  Yellow        14');
writeln('    LightGray     7  White         15');
writeln(' BGIpath - path to BGI drivers ');
writeln(' PRNpath - patch to printer. (-) Turn printing off');
writeln(' NWT(-)  - no wait after operation. ');
writeln('Program are parsing options from left to right !');
writeln('P R E S S  ENTER IF YOU WONT THE NEXT SCREEN!');
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
               writeln('Reading data from file ',name)
               else
               writeln('Data from file ',name,' append to existed.');
{ otwarcie pliku }
{$I-} {kontrola I/O OFF}
assign(afile,name);
reset(afile);
if ioerror then exit;
{czytanie }
while not eof(afile) do
      begin
      readln(afile,bufor);
      inc(linecount);
      GetXval(bufor,value,ecode);
      if ecode=0 then begin {liczba OK}
                 inc(currindex); { na puste miejsce }
                 if currindex>maxindex then begin
                                        writeln('Out space in value array!');
                                        halt(1);
                                        end;
                 bigtable[currindex]:=value; { zapamientanie wartosci }
                 if value>maxvalue then maxvalue:=value;
                 if value<minvalue then minvalue:=value;
                 end
                 else begin { liczba nie OK }
                 writeln('INVALID DATA FIELD!: line ',linecount,' at ',Xstart+ecode);
                 inc(nonconv);
                 end;
      if ioerror then exit;
      end;
close(afile);
if ioerror then exit;
{$I+} {kontrola I/O ON}

writeln('Line in file:',linecount);
writeln('Array contains ',currindex,' values.');
writeln('Min=',minvalue,' Max=',maxvalue);
SetMaxVal(maxvalue);{ Ustawianie globalnych Min i Max }
SetMinVal(minvalue);
{informacje w wypadku  blendow}
if nonconv<>0 then
              writeln('In file are ',nonconv,' bad data lines.');
if wait_on then begin
           writeln('Press ENTER');
           readln;
           end;
end;

procedure LoopMode(name:string);
var afile:text;
    bufor,key:string;
    value:real;
    nonconv:integer;   {liczba linii nie nadajacych sie do konwersji}
    linecount:integer; {liczba linii w ogule wczytanych }
    ecode:integer;     {pozycja blendu}
    suma_kwadratow:real;
    suma_wartosci:real;
    srednia,stddeviation:real;
    licznikgrupy:longint;

    function BlockContinue(var afile:text;var key:string;var bufor:string):boolean;
    { Funkcja sprawdza czy dana linia zawiera klucz - jesli bufor jest
      pusty to wczytuje linie z pliku afile, jesli klucz jest pusty
      to zmienia warosc klucza i zwraca TRUE }
    var pom:string;
    begin
    if bufor='' then { trzeba przeczytac nowa linia }
        readln(afile,bufor);
    pom:=copy(bufor,LabStart,LabLen); { czytanie wartosci klucza }
    if key='' then begin              { Jesli zupelnie nowy klucz}
                   BlockContinue:=True;
                   key:=pom;
                   end
              else                    { Jesli stary klucz }
              if key=pom then BlockContinue:=true
                         else BlockContinue:=false;
    end;
var grDriv,grMode:integer;
label myexit; { wyjscie z funkcji z zamknieciem grafiki }
begin
if (GetMaxval=MinReal)or
   (GetMinVal=MaxReal) then begin
                       writeln('Undefined Min or Max value!');
                       exit;
                       end;
if not MyInitGraph(grDriv,grMode) then exit { blad inicjacji grafiki }
                                  else restorecrtmode; { do tekstowego }
writeln('Reading file ',name);

{ otwarcie pliku }
{$I-} {kontrola I/O OFF}
assign(afile,name);
reset(afile);
if ioerror then goto myexit;
nonconv:=0;linecount:=0;ecode:=0; {inicjalizacja zminnych}
bufor:='';{ Wymusza przeczytanie nowej lini}

repeat {czytanie }
suma_kwadratow:=0; { zmienne do statystyki }
suma_wartosci:=0;
licznikgrupy:=0;
key:='';{ Wymusza ustalenie nowego klucza }
currindex:=0; { Tablica jest wypelniana od poczatku dla kazdej grupy }
while (not eof(afile))and( BlockContinue(afile,key,bufor) ) do { przetwarzanie grupy }
      begin
      inc(linecount);
      inc(licznikgrupy);
      GetXval(bufor,value,ecode);
      if ecode=0 then begin {liczba OK}
                 inc(currindex); { na puste miejsce }
                 if currindex>maxindex then begin
                                        writeln('Out of data space!');
                                        halt(1);
                                        end;
                 bigtable[currindex]:=value; { zapamientanie wartosci }
                 { obliczenie wartosci pomocniczych }
                 suma_kwadratow:=suma_kwadratow+value*value;
                 suma_wartosci:=suma_wartosci+value;
                 end
                 else begin { liczba nie OK }
                 writeln('INVALID DATA FIELD!: line ',linecount,' at ',Xstart+ecode);
                 inc(nonconv);
                 end;
      if ioerror then goto myexit;
      bufor:=''; { wymuszenie przeczytania nowej lini }
      end;
if currindex<>0 then begin { rysowanie }
                writeln('Line from file: ',linecount);
                writeln('In this group ',licznikgrupy,' values');
                srednia:=suma_wartosci/licznikgrupy;
                stddeviation:=sqrt(
                                   suma_kwadratow-licznikgrupy*srednia*srednia
                                   /
                                   licznikgrupy-1
                                   );
                writeln('mean=',srednia,' s.d=',stddeviation);
                {informacje w wypadku  blendow}
                if nonconv<>0 then
                              writeln('In file are ',nonconv,' bad data lines.');
                if wait_on then begin
                           writeln('Wcisnij ENTER');
                           readln;
                           end;
                setgraphmode(grMode);
                draw(1,currindex);
                moveto(mx div 3,1);
                outtext('Key:'+key);
                moveto(mx div 3,my-10);
                outtext('mean=');outreal(srednia);
                outtext(' s.d=');outreal(stddeviation);
                bufor:='';
                if wait_on then readln(bufor);
                if (length(bufor)=0) and (copypath<>'-') then
                           hardcopy(false,copymode);
                restorecrtmode;
                end;
until eof(afile); { powtarzanie az do konca pliku! }

close(afile);
if ioerror then exit;
myexit:
{$I+} {kontrola I/O ON}
closegraph;
end;

procedure plotdata;
{ zawiadywanie rysowaniem wykresu }
var
 grDriver: Integer;
 grMode: Integer;
 bufor:string[2];
begin
if MyInitGraph(grDriver,grMode) then
   begin
   if multiX then begin { wykres na wielu ekranach }
              multidraw;
              end
              else begin { wszystko na jednym wykresie }
              draw(1,currindex);
              readln(bufor);
              if (length(bufor)=0) and (copypath<>'-') then
                           hardcopy(false,copymode);
              end;
   CloseGraph;
   end;
end;

procedure draw(beg,en:integer);
var jedenx,jedeny:real;
    i,x,y:integer;
    maxvalue,minvalue:real;
begin
maxvalue:=GetMaxVal;
minvalue:=GetMinVal;
if maxvalue<>minvalue then jedeny:=(my-10)/(maxvalue-minvalue)
                      else jedeny:=(my-10)/(maxvalue/10);
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
    bufor:string[2];
begin
krok:=round(currindex/(mx/multval));
beg:=1;
if MultipleMaxVal>0 then begin {uwzglednienie ograniczenia}
                         en:=beg+MultipleMaxVal;
                         end
                         else  {ile wejdzie }
                         en:=round(mx/multval);
while beg<=currindex do begin
   draw(beg,en);
   setcolor(WHITE);
   moveto(mx div 3,0);
   if NOTOVERWRITE then begin
      outtext('From ');outint(beg);outtext(' to ');outint(en);
      end;
   outtext(' File: '+filename);
   beg:=en+1;
   if MultipleMaxVal>0 then begin {uwzglednienie ograniczenia}
                         en:=beg+MultipleMaxVal;
                         end
                         else  {ile wejdzie }
                         en:=en+round(mx/multval);
   readln(bufor);
   if NOTOVERWRITE and (length(bufor)=0) and (copypath<>'-') then
                           hardcopy(false,copymode);
   if NOTOVERWRITE then clearviewport
                   else begin
                   color:=9+(color+1)mod 7;
                   if (length(bufor)=0) and (copypath<>'-') then
                           hardcopy(false,copymode);
                   end;
   end;
end;



procedure ParseOption(s:string); { Ustawiane opcji wg stringow lini wywolania }

   procedure SetYAT(s:string;var ecod:integer);
   {writeln(' YATnn-ll pozycje X w pliku nn-kolumna ll-dlugosc');}
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
                  writeln('Value field start fro ',Xstart,',and has ',Xlen,' characters.');
                  exit;
                  end;{ nie ma wiecej do czytania}
   s:=p;
   b:=pos('-',s)+1;
   s:=copy(s,b,255);
   val(s,Xlen,ecod);
   if ecod<>0 then begin
                   Xlen:=255;
                   writeln('Reseting default value of value lenght: ',Xlen,' !');
                   end;
   end;

var ecode:integer;
begin
if pos('YAT',s)<>0 then begin { gdzie jest X }
   SetYAT(s,ecode);
   if ecode<>0 then
               writeln('Bad argument for option YAT!');
   end
   else
if pos('MIN',s)<>0 then begin { Fixed Minimum }
   s:=copy(s,pos('N',s)+1,255);
   val(s,FixMin,ecode);
   if ecode<>0 then writeln('Bad minimum!');
   end
   else
if pos('MAX',s)<>0 then begin { Fixed Maximum }
   s:=copy(s,pos('X',s)+1,255);
   val(s,FixMax,ecode);
   if ecode<>0 then writeln('Bad maximum!');
   end
   else
if pos('COL',s)<>0 then begin { kolory }
   s:=copy(s,pos('L',s)+1,2);
   val(s,color,ecode);
   if ecode<>0 then writeln('Bad color!');
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
   s:=copy(s,pos('L',s)+1,3);
   if length(s)>0 then begin
         val(s,MultVal,ecode);
         if ecode<>0 then writeln('Bad argument for option MUL!');
         end;
   if MultVal=0 then begin  { z powrotem default }
                     multix:=FALSE;
                     MultVal:=2;
                     end;
   end
   else
if pos('OVR',s)<>0 then begin { wiele ekranow }
   NOTOVERWRITE:=FALSE;
   s:=copy(s,pos('R',s)+1,3);
   if length(s)>0 then begin
         val(s,MultipleMaxVal,ecode);
         if ecode<>0 then writeln('Bad argumant for option OVR!');
         end;
   if MultipleMaxVal=0 then begin  { z powrotem default }
                     NOTOVERWRITE:=TRUE;
                     MultipleMaxVal:=320;
                     end;
   end
   else
if pos('PIX-',s)<>0 then begin { wylancz tryb pixelowy }
   pix_only:=FALSE;
   end
   else
if pos('PIX',s)<>0 then begin { tryb pixelowy }
   pix_only:=TRUE;
   forceGrid:=FALSE;
   end
   else
if pos('NWT-',s)<>0 then begin { czekanie }
   wait_on:=TRUE;
   end
   else
if pos('NWT',s)<>0 then begin { brak czekania }
   wait_on:=FALSE;
   end
   else
{writeln(' PRNpath - sciezka do drukarki. - brak drukowania');}
if pos('PRN',s)<>0 then begin { sciezka do BGI }
   s:=copy(s,pos('N',s)+1,255);
   copypath:=s;
   end
   else
if pos('BGI',s)<>0 then begin { sciezka do BGI }
   s:=copy(s,pos('I',s)+1,255);
   BGIpath:=s;
   end
   else
   writeln('BAD OPTION!!!',s);
end;

procedure SetGroupLabel(s:string);
var p:string;
    b,e:word;
    ecod:integer;
begin
ecod:=0;
p:=s;
b:=1;
e:=pos('-',s);
if e=0 then e:=255;
s:=copy(s,b,e-b);
val(s,LabStart,ecod);
if  ecod<>0 then exit;{blad!}
if  e=255 then begin
               writeln('Field "LABEL" start from ',LabStart,', and has ',LabLen,' characters.');
               exit;
               end;{ nie ma wiecej do czytania}
s:=p;
b:=pos('-',s)+1;
s:=copy(s,b,255);
val(s,LabLen,ecod);
if ecod<>0 then begin
                LabLen:=255;
                writeln('Reseting default value of LABEL lenght: ',Xlen,' !');
                end;
end;

procedure Interactiv;
{ Interakcyjny tryb pracy }
  procedure localhelp;
  begin
  writeln('h - help for global options');
  writeln('s <option>    - set global option');
  writeln('r <file_name> - read a file');
  writeln('a <file_name> - append to existing data');
  writeln('g <nn-ll> - set group label for loop mode');
  writeln('n <file_name> - set file name for loop mode');
  writeln('v             - list values of global options');
  writeln('p             - plot');
  writeln('l             - start loop mode');
  writeln('q             - E X I T ');
  end;

  procedure listparam;
  begin
  writeln('BGI path: ',BGIpath);
  writeln('Printer path: ',copypath);
  writeln('Last File name: ',filename);
  writeln('Data table contains: ',currindex,' values.');
  writeln('Max plot value: ',GetMaxVal);
  writeln('Min plot value: ',GetMinVal);
  writeln('Value field from: ',Xstart,'-',Xlen);
  writeln('Label field from: ',LabStart,'-',LabLen);
  if MultiX then writeln('Multi screen mode. ',MultVal,' pixels/value');
  if not NOTOVERWRITE then writeln('Over Write. ',MultipleMaxVal,'value/screen');
  end;

var command:string;
          c:char;
begin
writeln('PLOT IN INTERACTIV MODE: <?> for local help, <h> option help');
repeat
write('PLOT: ');
readln(command);
if length(command)>=1 then c:=command[1]{ nazwa komendy }
                      else c:=' ';
command:=copy(command,pos(' ',command)+1,255);
case c of
'?':localhelp;
'h':writeanghelp;
'v':listparam;
's':parseoption(command);
'p':if currindex<>0 then plotdata;
'r':begin filename:=command;currindex:=0;loaddata(command);end;
'a':begin filename:=command;loaddata(command);end;
'n':filename:=command;
'g':SetGroupLabel(command);
'l':LoopMode(filename);
'q':exit;
else writeln('?');
end {case};
until false;
end;
var i:integer;      { pomocnicza zmienne}
begin
{ copy1 }
SetErrorHandler(ioerror);
filename:=paramstr(1);
if filename=''then begin
                   writeln('Nie podano nazwy pliku danych! /? wyswietla help.');
                   exit;
                   end;
if (filename='-?')or(filename='-h')or(filename='/?') then begin
                                                     writeanghelp;
                                                     exit;
                                                     end;
if (filename='-?p')or(filename='-hp')or(filename='/?p') then begin
                                                     writehelp;
                                                     exit;
                                                     end;


for i:=2 to paramcount do
         ParseOption(paramstr(i));

if filename='-I' then begin
                 Interactiv;
                 exit;
                 end;

loaddata(filename);
if currindex<>0 then plotdata;
end.

