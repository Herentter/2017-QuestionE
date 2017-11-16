function CongestionLog = ExtaExchange(BattleFild,Fbuffer)
%% 计算直连路径并读取位置数据
TimeFild4A = BattleFild/45;%计算A类发射车普通公路的速度
for i =1:20%计算高速公路的速度
    TimeFild4A(i+68,i+69) = BattleFild(i+68,i+69)/70;
    TimeFild4A(i+69,i+68) = TimeFild4A(i+68,i+69);
end
TimeFild4B = BattleFild/35;%计算B类发射车普通公路的速度
for i =1:20%计算高速公路的速度
    TimeFild4B(i+68,i+69) = BattleFild(i+68,i+69)/60;
    TimeFild4B(i+69,i+68) = TimeFild4B(i+68,i+69);
end
TimeFild4C = BattleFild/30;%计算C类发射车普通公路的速度
for i =1:20%计算高速公路的速度
    TimeFild4C(i+68,i+69) = BattleFild(i+68,i+69)/50;
    TimeFild4C(i+69,i+68) = TimeFild4C(i+68,i+69);
end
%% 计算最短路径，及其时间
[BattleFildDisC,BattleFildPathC ]  = Floyd(TimeFild4C);
[BattleFildDisB,BattleFildPathB ]  = Floyd(TimeFild4B);
[BattleFildDisA,BattleFildPathA ]  = Floyd(TimeFild4A);

%% 初始化Z点信息
%Zpoint = ones(2,6);%初始负载系数均为1
%           第一行记录Z点的修正编号
%           第二行记录Z点的空闲系数
%FEmputy:   第一行记录空的F点编号（真实编号，不修正）
%           第二行记录该点所隶属的Z点编号（修正编号）
%           第三行为路径空闲从属度
%传出值：
%DistributPlan: 三维矩阵,标记每个发射车发射之后前往装弹的Z点
%               第一行标记F点编号（真实编号,未修正）
%               第二行为该F所属的Z点编号（修正编号）
%               第三行标记该路径负载压力
%               第四行为路径长度

Zpoint = ones(2,8);
%重构Zpoint中的信息，加入新的Z点
for i = 1:6
    Zpoint(1,i) = i+2;
end

Jstack = [25 34 36 49 42];
Jstack = Jstack + 68;%将真实位置转换为修正位置

CongestionLog = zeros(5);

for t = 1:4
    for j = t+1:5
        Zpoint(1,7) = Jstack(t);
        Zpoint(1,8) = Jstack(j);
        CongestionBuffer = zeros(6,24);
        VarBuffer = zeros(2,size(Zpoint,2));
        VarBuffer(1,:) = Zpoint(1,:);
        for i = 1:3
            [CongestionBuffer,VarBuffer] = CongestionDegree(BattleFildDisA,BattleFildDisB,BattleFildDisC,Zpoint,Fbuffer,CongestionBuffer,i,VarBuffer);
        end
        CongestionLog(t,j) = sum(CongestionBuffer(3,:));
    end
end

CongestionLog
%调试代码，用于输出装弹路径聚类示意图
% figure(5);
% MapGenerator();
% for j = 1:24
%     plot([mapss(CongestionBuffer(1,j)+8,1) mapss(CongestionBuffer(2,j),1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(CongestionBuffer(2,j),2)],'-r');
% end