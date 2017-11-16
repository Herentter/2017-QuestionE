function BattleFild = MapGenerator

%% 获取各节点坐标
D = xlsread('Locations',1,'B2:C3');
Z = xlsread('Locations',1,'B4:C9');
F = xlsread('Locations',1,'B10:C69');
J = xlsread('Locations',1,'B70:C131');

%% 绘制地图
plot(D(:,1),D(:,2),'og');hold on;
plot(Z(:,1),Z(:,2),'*r');
plot(F(:,1),F(:,2),'om');
plot(J(:,1),J(:,2),'oy');

%% 标记每个点的名称
%标记J点名称
for i = 1:62
    ch = num2str(i);
    te = ['J',ch];
    text(J(i,1)+1.5,J(i,2)-2,te,'color','m');
end
%标记D点名称
for i = 1:2
    ch = num2str(i);
    te = ['D',ch];
    text(D(i,1)+1.5,D(i,2)-2,te,'color','g');
end
%标记Z点名称
for i = 1:6
    ch = num2str(i);
    te = ['Z',ch];
    text(Z(i,1)+1.5,Z(i,2)-2,te,'color','r');
end

%% 添加连通图
%标记J点连通性
Jroad=zeros(62);
Jroad(26,27) = 1;
Jroad(24,26) = 1;
Jroad(23,24) = 1;
Jroad(22,23) = 1;
Jroad(21,22) = 1;
Jroad(12,32) = 1;
Jroad(12,13) = 1;
Jroad(13,32) = 1;
Jroad(3,32) = 1;
Jroad(2,3) = 1;
Jroad(1,2) = 1;
Jroad(2,47) = 1;
Jroad(47,48) = 1;
Jroad(3,48) = 1;
Jroad(3,4) = 1;
Jroad(3,33) = 1;
Jroad(32,33) = 1;
Jroad(4,33) = 1;
Jroad(4,50) = 1;
Jroad(4,5) = 1;
Jroad(47,48) = 1;
Jroad(5,49) = 1;
Jroad(49,50) = 1;
Jroad(50,53) = 1;
Jroad(53,56) = 1;
Jroad(56,60) = 1;
Jroad(60,62) = 1;
Jroad(59,62) = 1;
Jroad(53,59) = 1;
Jroad(53,55) = 1;
Jroad(55,59) = 1;
Jroad(58,59) = 1;
Jroad(55,58) = 1;
Jroad(54,55) = 1;
Jroad(54,57) = 1;
Jroad(57,58) = 1;
Jroad(58,61) = 1;
Jroad(33,34) = 1;
Jroad(5,34) = 1;
Jroad(34,36) = 1;
Jroad(34,35) = 1;
Jroad(5,6) = 1;
Jroad(6,36) = 1;
Jroad(14,35) = 1;
Jroad(13,14) = 1;
Jroad(14,21) = 1;
Jroad(14,15) = 1;
Jroad(23,25) = 1;
Jroad(24,25) = 1;
Jroad(15,25) = 1;
Jroad(15,16) = 1;
Jroad(16,39) = 1;
Jroad(16,17) = 1;
Jroad(17,18) = 1;
Jroad(18,19) = 1;
Jroad(19,20) = 1;
Jroad(39,40) = 1;
Jroad(40,42) = 1;
Jroad(38,42) = 1;
Jroad(8,42) = 1;
Jroad(42,45) = 1;
Jroad(9,45) = 1;
Jroad(8,9) = 1;
Jroad(6,7) = 1;
Jroad(7,8) = 1;
Jroad(9,10) = 1;
Jroad(10,11) = 1;
Jroad(8,52) = 1;
Jroad(7,52) = 1;
Jroad(16,39) = 1;
Jroad(6,51) = 1;
Jroad(44,45) = 1;
Jroad(10,45) = 1;
Jroad(11,46) = 1;
Jroad(45,46) = 1;
Jroad(44,46) = 1;
Jroad(43,44) = 1;
Jroad(19,43) = 1;
Jroad(19,31) = 1;
Jroad(30,31) = 1;
Jroad(29,31) = 1;
Jroad(28,29) = 1;
Jroad(29,30) = 1;
Jroad(28,30) = 1;
Jroad(27,28) = 1;
Jroad(18,41) = 1;
Jroad(18,29) = 1;
Jroad(20,31) = 1;
Jroad(15,37) = 1;
Jroad(13,21) = 1;
%计算J点间的距离
JDis = JroadDistance(Jroad,J);
%标记F点与J点之间的从属关系
FJlink = zeros(60,2);%第一列记录与F相连的J点编号，第二列记录两点间的距离
FJlink(16,1) = 27;
FJlink(15,1) = 27;
FJlink(14,1) = 27;
FJlink(17,1) = 27;
FJlink(13,1) = 26;
FJlink(12,1) = 26;
FJlink(9,1) = 24;
FJlink(8,1) = 24;
FJlink(7,1) = 23;
FJlink(4,1) = 22;
FJlink(5,1) = 22;
FJlink(6,1) = 22;
FJlink(1,1) = 21;
FJlink(2,1) = 21;
FJlink(3,1) = 21;
FJlink(10,1) = 25;
FJlink(11,1) = 25;
FJlink(18,1) = 28;
FJlink(19,1) = 28;
FJlink(21,1) = 30;
FJlink(22,1) = 30;
FJlink(20,1) = 29;
FJlink(23,1) = 31;
FJlink(40,1) = 41;
FJlink(41,1) = 44;
FJlink(42,1) = 44;
FJlink(43,1) = 46;
FJlink(36,1) = 39;
FJlink(37,1) = 40;
FJlink(38,1) = 40;
FJlink(39,1) = 40;
FJlink(34,1) = 38;
FJlink(35,1) = 38;
FJlink(31,1) = 37;
FJlink(33,1) = 37;
FJlink(32,1) = 37;
FJlink(29,1) = 36;
FJlink(30,1) = 36;
FJlink(57,1) = 61;
FJlink(58,1) = 61;
FJlink(59,1) = 62;
FJlink(60,1) = 62;
FJlink(55,1) = 60;
FJlink(56,1) = 60;
FJlink(52,1) = 56;
FJlink(53,1) = 56;
FJlink(51,1) = 53;
FJlink(48,1) = 49;
FJlink(49,1) = 49;
FJlink(50,1) = 50;
FJlink(46,1) = 48;
FJlink(47,1) = 48;
FJlink(44,1) = 47;
FJlink(45,1) = 47;
FJlink(27,1) = 35;
FJlink(28,1) = 35;
FJlink(26,1) = 34;
FJlink(25,1) = 33;
FJlink(24,1) = 32;
FJlink(54,1) = 59;
%计算F点与J点之间的距离
FJlink(:,2) = FJroadDistance(FJlink,F,J);
%绘制F-J的连通性
for i = 1:60
    plot( [F(i,1) J(FJlink(i,1),1)],[F(i,2) J(FJlink(i,1),2)],'-y');
end
%标记Z-J点连通性
ZJroad = zeros(6,62);
ZJroad(6,26) = 1;
ZJroad(6,25) = 1;
ZJroad(6,28) = 1;
ZJroad(6,16) = 1;
ZJroad(5,41) = 1;
ZJroad(5,44) = 1;
ZJroad(4,37) = 1;
ZJroad(4,38) = 1;
ZJroad(4,7) = 1;
ZJroad(3,9) = 1;
ZJroad(3,52) = 1;
ZJroad(3,57) = 1;
ZJroad(3,61) = 1;
ZJroad(2,51) = 1;
ZJroad(2,52) = 1;
ZJroad(2,54) = 1;
ZJroad(1,48) = 1;
ZJroad(1,4) = 1;
ZJroad(1,50) = 1;
%计算ZJ点之间的距离
ZJDis = ZJroadDistance(ZJroad,J,Z);
%D-J连通性
%这里存储的值就是对应的J点坐标
%第一行是与D-1相连的J点，第二行是与D-2相连的J点
DJ = zeros(2,62);
DJ(1,11) = 11;
DJ(1,10) = 10;
DJ(1,9) = 9;
DJ(2,12) = 12;
DJ(2,32) = 32;
DJ(2,3) = 3;
DJ(2,2) = 2;
%计算DJ点之间的距离
DJDis = DJroadDistance(DJ,D,J);
%D-Z点连通性
DZ = [1,3];%表示D1和Z3相连
len = (D(1,1)-Z(3,1))*(D(1,1)-Z(3,1))+(D(1,2)-Z(3,2))*(D(1,2)-Z(3,2));
DZDis = sqrt(len);
%绘制J点连通性
for i = 1:62
    for j = 1:62
        if(Jroad(i,j) ~= 0)
            plot( [J(i,1) J(j,1)] , [J(i,2) J(j,2)] , '-y');
        end
    end
end
%绘制Z-J点连通性
for i = 1:6
    for j = 1:62
        if(ZJroad(i,j) ~= 0)
            plot( [Z(i,1) J(j,1)] , [Z(i,2) J(j,2)] , '-y');
        end
    end
end
%绘制D-J点连通性
for i = 1:2
    for j = 1:62
        if(DJ(i,j) ~= 0)
            plot( [D(i,1) J(j,1)] , [D(i,2) J(j,2)] , '-y');
        end
    end
end
%绘制D-Z点连通性
plot( [D(1,1) Z(3,1)] , [D(1,2) Z(3,2)] , '-y');
%% 添加高速公路矩阵
%高速公路其实就是 J(1:11)和J(12:20)两条线
for i = 1:10
    plot( [ J(i,1) , J(i+1,1) ] , [ J(i,2) , J(i+1,2) ] , '-k' )
end
for i = 12:19
    plot( [ J(i,1) , J(i+1,1) ] , [ J(i,2) , J(i+1,2) ] , '-k' )
end
%设定坐标轴范围
axis([0 250 -50 200]);

%% 截止此时，各条路径已经输入内存
%% 各点之间的距离分别存储在FJlink,JDis,ZJDis,DJDis和DZDis中
%% 将整个地图130个节点之间的距离整理到同一个矩阵内
BattleFild = zeros(130);%这里存储了整张图所有点的连通性
%1~60为F点，61~122为J点，123~128为Z点，129~130为D点
%整理Z-D的连接
i=1;
j=3;
BattleFild(i+0,j+2) = DZDis;
%整理F-J的连接
for i = 1:60
	BattleFild(i+8,FJlink(i,1)+68) = FJlink(i,2);
end
%整理J-J的连接
for i = 1:62
    for j = 1:62
        BattleFild(i+68,j+68) = JDis(i,j);
    end
end
%整理Z-J的连接
for i = 1:6
    for j = 1:62
        BattleFild(i+2,j+68) = ZJDis(i,j);
    end
end
%整理D-J的连接
for i = 1:2
    for j = 1:62
        BattleFild(i,j+68) = DJDis(i,j);
    end
end
%将BattleFild转换成对称矩阵
for i = 1:130
    for j = i:130
        BattleFild(j,i)=BattleFild(i,j);
    end
end