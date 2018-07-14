 uses crt;

procedure goodsound;
var i:word;
begin
for i:=1 to 15 do
    begin
    sound(i*1000);
    delay(25);
    end;
nosound;
end;

procedure wrongsound;
var i:word;
begin
for i:=15 downto 1 do
    begin
    sound(i*10);
    delay(25);
    end;
nosound;
end;

begin
goodsound;
delay(200);
wrongsound;
end.