uses crt,crt2;
var map:pointer;
    size:word;
    i:word;
    key:char;
procedure randscr;
var i,j:byte;
begin
for j:=1 to getymax do
    for i:=1 to getXmax do
       scrbuff^[j][i].asc:=char(random(256));
end;
const windbad:windowtype=(x1:3;y1:3;x2:3;y2:3);
      windbad2:windowtype=(x1:30;y1:3;x2:63;y2:36);
var oldwindow:windowtype;

begin{PROGRAM}
enviroment(font8x8+co80);
delay(3000);
gotoxy(1,1);
fullscr;
clrscr;
randomize;
lowvideo;
randscr;
fillscr('A');
fillbar(1,1,35,20,#177);
crtkom(2,getymax-3,crt2errorMSg(crt2result),#7,7);
DrawborderingWindow(getXmax-10,getYmax-10,10,10,#5,16*magenta+green);
textattr:=lightgray*16+yellow;
writeln(crtmodeinf);
writeln(textattrinf);
highvideo;
writeln(textattrinf);
lowvideo;
crtkom(20,getymax-3,crt2errorMSg(crt2result),#7,7);

DrawborderingWindow(2,2,22,15,#5,16*magenta+green);
crtkom(2,getymax-3,crt2errorMSg(crt2result),#7,7);
crtstatus;
inversBW(false);

key:=readkey;
end.