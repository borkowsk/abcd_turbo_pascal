program KODTEST;
uses crt;
var I,J,N:word;
begin
clrscr;
n:=0;
for j:=0 to 11 do
    for I:=1 to 22 do
                begin
                gotoxy(j*6+1,i);
                write(n:3,'-');
                highvideo;
                write(chr(n),' ');
                lowvideo;
                inc(n);
                if N>255 then begin
                              gotoxy(1,23);
                              halt(0);
                              end;
                end;

end.