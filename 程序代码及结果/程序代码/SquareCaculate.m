function anw = SquareCaculate(a,b)
%计算a的b+1次方
anw = a;
for i = 1:b
    anw = a*anw;
end