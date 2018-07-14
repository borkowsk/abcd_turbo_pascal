program paleta;
uses graph,crt,graph2;
type
    RGBrec=record
           R,G,B:integer;
           end;
    RGBobj=object
            RGBcol:array[0..15] of RGBrec;
            NR:byte;
            skok,Yskok:integer;
            key:char;
            procedure View;
            procedure SetEGApalette;
            procedure set0palette;
            procedure Editpalette;
            end;
const EGAcol:array[0..15] of rgbrec=(
      (R:$00;G:$00;B:$00),{black}
      (R:$00;G:$00;B:$fc),{blue}
      (R:$24;G:$fc;B:$24),{gren}
      (R:$00;G:$fc;B:$fc),{cyan}
      (R:$fc;G:$14;B:$14),{red}
      (R:$b0;G:$00;B:$fc),{Magenta}
      (R:$70;G:$48;B:$00),{brown}
      (R:$c4;G:$c4;B:$c4),
      (R:$34;G:$34;B:$34),
      (R:$00;G:$00;B:$70),
      (R:$00;G:$70;B:$00),
      (R:$00;G:$70;B:$70),
      (R:$70;G:$00;B:$00),
      (R:$70;G:$00;B:$70),
      (R:$fc;G:$fc;B:$24),
      (R:$fc;G:$fc;B:$fc));
procedure RGBobj.View;
var I:byte;
begin
fullport;
drawborder;
skok:=round(mx/(maxcolor+1));
Yskok:=round(skok*xratio/yratio);
for i:=0 to maxcolor do
    begin
    setfillstyle(1,i);
    bar(i*skok,0,(i+1)*skok,my);
{    fillellipse((i+1)*skok,Yskok*2,skok,Yskok);}
    end;
setbkcolor(0);
end;
procedure RGbobj.editPalette;
begin
NR:=1;
repeat
setfillstyle(solidfill,black);
bar(0,sy,mx,my);
line((Nr+1)*skok,sY,(nr+1)*skok,sY+skok);
line((Nr+1)*skok,sY,(nr)*skok,sY+skok);
line((Nr+1)*skok,sY,(nr+2)*skok,sY+skok);
moveto(0,sY+skok+5);
outtext('COLOR NR '+int2str(NR));
moveto(0,sY+skok+15);
outtext('RED:'+int2str(rgbcol[nr].R)+' GREEN:'+int2str(rgbcol[nr].G)+' BLUE:'+int2str(rgbcol[nr].B));
key:=readkey;
if key=#0 then
begin
key:=readkey;
case ord(key) of
77:inc(nr);
75:dec(nr);
71:begin
   inc(rgbcol[nr].R);
   setRGBpalette(nr,rgbcol[nr].R,rgbcol[nr].G,rgbcol[nr].B);
        end;
73:begin
   inc(rgbcol[nr].g);
   setRGBpalette(nr,rgbcol[nr].R,rgbcol[nr].G,rgbcol[nr].B);
        end;
79:begin
   inc(rgbcol[nr].B);
   setRGBpalette(nr,rgbcol[nr].R,rgbcol[nr].G,rgbcol[nr].B);
        end;
119:begin
   dec(rgbcol[nr].R);
   setRGBpalette(nr,rgbcol[nr].R,rgbcol[nr].G,rgbcol[nr].B);
        end;
132:begin
   dec(rgbcol[nr].g);
   setRGBpalette(nr,rgbcol[nr].R,rgbcol[nr].G,rgbcol[nr].B);
        end;
117:begin
   dec(rgbcol[nr].B);
   setRGBpalette(nr,rgbcol[nr].R,rgbcol[nr].G,rgbcol[nr].B);
        end;
72:begin
   inc(rgbcol[nr].R);
   inc(rgbcol[nr].G);
   inc(rgbcol[nr].B);
   setRGBpalette(nr,rgbcol[nr].R,rgbcol[nr].G,rgbcol[nr].B);
        end;
80:begin
   dec(rgbcol[nr].R);
   dec(rgbcol[nr].G);
   dec(rgbcol[nr].B);
   setRGBpalette(nr,rgbcol[nr].R,rgbcol[nr].G,rgbcol[nr].B);
        end;
end;{case}
if nr<0 then nr:=0;
if nr>maxcolor then nr:=maxcolor;
end;
until key=#27;
end;
procedure RGBobj.SetEGAPalette;
var I:byte;
    r:integer;
begin
for i:=0 to maxcolor do
    begin
    rgbcol[i]:=EGAcol[i];
    setRGBpalette(i,rgbcol[i].R,rgbcol[i].G,rgbcol[i].B);
    r:=graphresult;
    if r<>0 then begin
                 sound(300);
                 delay(130);
                 nosound;
                 end;
    end;
end;
procedure RGBobj.Set0Palette;
var I:byte;
    r:integer;
const zerocol:RGBrec=(r:0;g:0;b:0);
begin
for i:=0 to maxcolor-1 do
    begin
    rgbcol[i]:=zerocol;
    setRGBpalette(i,0,0,0);
    r:=graphresult;
    if r<>0 then begin
                 sound(300);
                 delay(130);
                 nosound;
                 end;
    end;
end;
var rob:RGBobj;
begin{MAIN}
graph2TestInit('');
Rob.View;
repeat until keypressed;
rob.key:=readkey;
rob.set0palette;
rob.editPalette;
closegraph;
end.