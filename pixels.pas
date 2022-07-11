program pixels;
uses graph,graph2,crt;

var x,y:integer;
    c:word;
    r:real;

BEGIN

graph2init('',nil);
randomize;

repeat
x:=1+random(mx);
y:=1+random(my);
r:=abs(x-y);
c:=round(maxcolor*sqrt(r));
putpixel(x,y,c);
until keypressed;

END.
