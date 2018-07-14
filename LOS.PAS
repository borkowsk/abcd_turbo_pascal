program losowanie;
uses CRT;
var
ile:integer;
begin
randomize;
writeln('Ile osob jest w grupie:');
readln(ile);
writeln('Odpowiada osoba nr ',random(ile)+1);
end.