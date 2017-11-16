function Guidor(Path,Begin,End)
%制图函数
%给定起点，终点和Path矩阵，绘制最短路径
%起点和终点都是修正编号
mapss = xlsread('Locations',1,'B2:C131');%读取130个点的坐标
next = Path(Begin,End);
plot([mapss(Begin,1) mapss(next,1)],[mapss(Begin,2) mapss(next,2)],'-g');
while(next ~= End)
    k = next;
    next = Path(next,End);
    plot([mapss(k,1) mapss(next,1)],[mapss(k,2) mapss(next,2)],'-g');
end