  uses dos;
  var text:string;
  function ZmianaEXT(source:pathstr;ext:extstr):string;
  var kat:dirstr;
      naz:namestr;
      ext0:extstr;
  begin
  fsplit(source,kat,naz,ext0);
  ZmianaEXT:=kat+naz+'.'+ext;
  end;
  FUNCTION zmiennazw(sciezka:pathstr):pathstr;
  var
  skor:dirstr;
  nazwa:namestr;
  roz:extstr;
  i:byte;
  begin
  for i:=byte(sciezka[0]) downto 0 do sciezka[i]:=Upcase(sciezka[i]);
  Fsplit(sciezka,skor,nazwa,roz);
  if (length(nazwa)<8) then nazwa:=nazwa+'A'
                       else
                       begin
                       inc(nazwa[8]);
                       if nazwa[8]<'0' then nazwa[8]:='0';
                       if nazwa[8] in[':'..'@'] then nazwa[8]:='A';
                       i:=length(nazwa);
                       while(nazwa[i]>'Z') do
                             begin
                             nazwa[i]:='A';
                             dec(i);
                             if i=0 then i:=8
                                    else
                                    begin
                                    inc(nazwa[i]);
                                    if nazwa[i] in[':'..'@'] then nazwa[i]:='A';
                                    end;

                             end;
                       end;
  zmiennazw:=skor+nazwa+roz;
  end;

  begin
  repeat
  readln(text);
  write(text);
  {writeln(' ',zmiennazw(text));}
  writeln(' ',zmianaext(text,'exx'));
  until text='';
  end.