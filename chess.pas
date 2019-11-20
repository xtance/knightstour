//v = vertical (Y), H = horizontal (X)
var t:array[1..8,1..8] of boolean;
y,x,count:integer;
function draw():integer;
begin
    writeln;
    writeln('Матрица (',count,' посещено), последний ход: X[',x,'], Y[',y,']');
    var v,h:integer;
    for v:=1 to 8 do begin
      writeln;
      for h:=1 to 8 do
      if (h = x) and (y = v) and (t[v,h])  then write('[@]')
      else if (t[v,h]) then write('[X]') else write('[ ]');
    end;
    writeln;
    draw:=0;
end;

function mark(y1,x1:integer):integer;
begin
    x:=x1;y:=y1;count+=1;
    t[y,x]:=true;
    draw();
    mark:=0;
end;

function getp(y1,x1:integer):integer;
var v,h,variants:integer;
begin
    variants:=0;
    for v:=-2 to 2 do for h:=-2 to 2 do
    begin
               if (v = 0) or (h = 0) then continue;
               if (x1+h>=1) and (x1+h<=8) and (y1+v>=1) and (y1+v<=8) then
               if (not t[y1+v,x1+h]) and (abs(h) <> abs(v)) then variants+=1;
    end;
    writeln('Вариантов у точки [',x1,',',y1,'] : ',variants);
    getp:=variants;
end;

begin
    var v,h,ny,nx,variants,res:integer;
    for v:=1 to 8 do for h:=1 to 8 do t[v,h]:=false;
    repeat
    writeln('Введите стартовую позицию X Y: '); read(nx,ny);
    until (nx>=1) and (nx<=8) and (ny>=1) and (ny<=8);
    mark(ny,nx);
    repeat
      variants:=1337;
      for v:=-2 to 2 do for h:=-2 to 2 do
      begin
           if (v = 0) or (h = 0) then continue;
           if (x+h>=1) and (x+h<=8) and (y+v>=1) and (y+v<=8) then
           if (not t[y+v,x+h]) and (abs(h) <> abs(v)) then
           begin
              res:=getp(y+v,x+h);
              if (res <= variants) then
              begin
                    variants:=res;
                    ny:=y+v; nx:=x+h;
              end;
           end;
      end;
      mark(ny,nx);
    until (count = 64);
end.