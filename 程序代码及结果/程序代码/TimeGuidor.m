function table = TimeGuidor(Path,TimeDis,Begin,End,delay)
%返回一个行向量，时间点和位置编号交替进行
%制图函数
%给定起点，终点和Path矩阵，绘制最短路径
%起点和终点都是修正编号
count = 1;
next = Path(Begin,End);
table(count) = TimeDis(Begin,next) + delay;
table(count + 1) = next;
while(next ~= End)
    count = count + 2;
    k = next;
    next = Path(next,End);
    table(count) = TimeDis(k,next) + table(count-2);
    table(count + 1) = next;
end
for i = 1:2:size(table,2)
    if(table(i + 1)<68)%只保留J点信息
        table(i) = [];
        table(i) = [];
    end
end
