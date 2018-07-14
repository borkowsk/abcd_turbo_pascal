program random_data_file_generator;
var f:text;
    nazwa:string;
    n,i:integer;
    przedzial:real;
    funkcja:char;
begin
randomize;
writeln('Podaj nazwe  n o w e g o  pliku:');
readln(nazwa);
writeln('Podaj typ funkcji (R-andom,L-inia):');
readln(funkcja);
funkcja:=UpCase(funkcja);
writeln('Przyjeto funkcje:',funkcja);
writeln('Liczba wartosci?');
readln(n);
writeln('Szerokosc przedzialu?');
readln(przedzial);
assign(f,nazwa);
rewrite(f);
for i:=1 to n do
       case funkcja of
       'R':writeln(f,(przedzial/2)-random*przedzial);
       'L':writeln(f,(przedzial/2)-(i/n)*przedzial);
       else
       writeln(f,(przedzial/2)-random*przedzial);
       end;
close(f);
end.
