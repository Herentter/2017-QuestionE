function CongestionBuffer = BestD4SecondShort(BattleFild,Fbuffer)
%% 计算直连路径并读取位置数据
mapss = xlsread('Locations',1,'B2:C131');%读取130个点的坐标
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
[Zpoint,FEmputy] = FEmputyCluster(BattleFild,Fbuffer);

%% 初步计算Z点与各个发射位之间的隶属关系
%Fbuffer,分别找到A,B和C发射器对应的F点
%FA存储A类发射器所在F点的真实编号，不修正
%FB存储B类发射器所在F点的真实编号，不修正
%FC存储C类发射器所在F点的真实编号，不修正
FA = [];
FB = [];
FC = [];
for i = 1:size(Fbuffer,2)
    if(Fbuffer(4,i) == 1)
        FA = [FA Fbuffer(3,i)];
    end
    if(Fbuffer(4,i) == 2)
        FB = [FB Fbuffer(3,i)];
    end
    if(Fbuffer(4,i) == 3)
        FC = [FC Fbuffer(3,i)];
    end
end
%分别计算ABC三类发射器所隶属的中转点
DistributPlanA = FindClosestZPoint(BattleFildDisA,FA,Zpoint);
DistributPlanB = FindClosestZPoint(BattleFildDisB,FB,Zpoint);
DistributPlanC = FindClosestZPoint(BattleFildDisC,FC,Zpoint);
%传出值：
%DistributPlan: 三维矩阵,标记每个发射车发射之后前往装弹的Z点
%               第一行标记F点编号（真实编号,未修正）
%               第二行为该F所属的Z点编号（修正编号）
%               第三行标记该路径负载压力
%               第四行为路径长度

CongestionBuffer = zeros(6,24);
VarBuffer = zeros(2,size(Zpoint,2));
VarBuffer(1,:) = Zpoint(1,:);
for i = 1:3
    [CongestionBuffer,VarBuffer] = CongestionDegree(BattleFildDisA,BattleFildDisB,BattleFildDisC,Zpoint,Fbuffer,CongestionBuffer,i,VarBuffer);
end
%调试代码，用于输出装弹路径聚类示意图
% figure(6);
% MapGenerator();
% for j = 1:24
%     plot([mapss(CongestionBuffer(1,j)+8,1) mapss(CongestionBuffer(2,j),1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(CongestionBuffer(2,j),2)],'-g');
% end

for j = 1:24
    if(CongestionBuffer(6,j) == 1)%A类车
        i = CongestionBuffer(2,j);%i为目的地地址（修正地址，无需偏移）
        count = 0;
        k = BattleFildPathA(CongestionBuffer(1,j)+8,i);%K为下一点编号
        plot( [mapss(CongestionBuffer(1,j)+8,1) mapss(k,1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(k,2)],'-r');
        while(k~= i)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPathA(k,i),1)],[mapss(k,2) mapss(BattleFildPathA(k,i),2)],'-r');
            k = BattleFildPathA(k,i);
        end
    end
    if(CongestionBuffer(6,j) == 2)%B类车
        i = CongestionBuffer(2,j);%i为目的地地址（修正地址，无需偏移）
        count = 0;
        k = BattleFildPathB(CongestionBuffer(1,j)+8,i);%K为下一点编号
        plot( [mapss(CongestionBuffer(1,j)+8,1) mapss(k,1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(k,2)],'-r');
        while(k~= i)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPathB(k,i),1)],[mapss(k,2) mapss(BattleFildPathB(k,i),2)],'-r');
            k = BattleFildPathB(k,i);
        end
    end
    if(CongestionBuffer(6,j) == 3)%C类车
        i = CongestionBuffer(2,j);%i为目的地地址（修正地址，无需偏移）
        count = 0;
        k = BattleFildPathC(CongestionBuffer(1,j)+8,i);%K为下一点编号
        plot( [mapss(CongestionBuffer(1,j)+8,1) mapss(k,1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(k,2)],'-r');
        while(k~= i)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPathC(k,i),1)],[mapss(k,2) mapss(BattleFildPathC(k,i),2)],'-r');
            k = BattleFildPathC(k,i);
        end
    end
end
%     plot([mapss(CongestionBuffer(1,j)+8,1) mapss(CongestionBuffer(2,j),1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(CongestionBuffer(2,j),2)],'-g');
%         i = Fbuffer(2,t);
%         count = 0;
%         k = BattleFildPath(1,i+8);
%         plot( [mapss(1,1) mapss(k,1)],[mapss(1,2) mapss(k,2)],'-g');
%         while(k~= i+8)
%             count = count + 1;
%             plot( [mapss(k,1) mapss(BattleFildPath(k,i+8),1)],[mapss(k,2) mapss(BattleFildPath(k,i+8),2)],'-g');
%             k = BattleFildPath(k,i+8);
%         end


