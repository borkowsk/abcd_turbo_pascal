#include "ptoc.h"


#include "graph.h"
/*#include "graph2.h"*/
/*#include "crt.h"*/


integer x,y;
word c;
real r;

int main(int argc, const char* argv[])
{

pio_initialize(argc, argv);
graph2init("",nil);
Randomize();

do {
x=1+Random(mx);
y=1+Random(my);
r=abs(x-y);
c=round(maxcolor*sqrt(r));
putpixel(x,y,c);
} while (!keypressed());

return EXIT_SUCCESS;
}
