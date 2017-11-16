function [Zpoint,FEmputy] = BestD4HoldPoint(BattleFild,Fbuffer,CongestionBuffer)
%% 参数说明
%CongestionBuffer   第二行为每辆车的去向
%                   第六行为每辆车的种类

%% 算法主体
[Zpoint,FEmputy] = FEmputyCluster(BattleFild,Fbuffer);
%二次打击点分配方案存储在FEmputy中
%空闲度存储在Zpoint中

%% 绘制连接图
mapss = xlsread('Locations',1,'B2:C131');%读取130个点的坐标
%FEmputy:       三行矩阵,标记Z和F点之间的连接关系
%               第一行标记F点编号（真实编号）
%               第二行为该F所属的Z点编号（修正编号）
%               第三行为空闲从属度
%调试代码，用于输出二次打击炮火位置的聚类示意图
% for i = 1:size(FEmputy,2)
%     plot([mapss(FEmputy(1,i)+8,1) mapss(FEmputy(2,i),1)],[mapss(FEmputy(1,i)+8,2) mapss(FEmputy(2,i),2)],'-g');
% end
[BattleFildDis,BattleFildPath ]  = Floyd(BattleFild);
F = FEmputy;
F(1,:) = F(1,:) +8;
Dis = zeros(1,size(F,2));
for i = 1:size(F,2)
    Dis(i) = BattleFildDis(F(1,i),F(2,i));
end
mid = [0 0];%第一个数表示序号，第二个数表示距离
for i = 1:size(F,2)
    if(F(2,i)==5 && Dis(i)>mid(2))
        mid(1) = i;
        mid(2) = Dis(i);
    end
end
F(:,mid(1)) = [];
Dis(mid(1)) = [];

for count = 1:5
    mid = [0 0];%第一个数表示序号，第二个数表示距离
    for i = 1:size(F,2)
        if(F(2,i)==6 && Dis(i)>mid(2))
            mid(1) = i;
            mid(2) = Dis(i);
        end
    end
    F(:,mid(1)) = [];
    Dis(mid(1)) = [];
end

for count = 1:2
    mid = [0 0];%第一个数表示序号，第二个数表示距离
    for i = 1:size(F,2)
        if(F(2,i)==7 && Dis(i)>mid(2))
            mid(1) = i;
            mid(2) = Dis(i);
        end
    end
    F(:,mid(1)) = [];
    Dis(mid(1)) = [];
end

for count = 1:4
    mid = [0 0];%第一个数表示序号，第二个数表示距离
    for i = 1:size(F,2)
        if(F(2,i)==8 && Dis(i)>mid(2))
            mid(1) = i;
            mid(2) = Dis(i);
        end
    end
    F(:,mid(1)) = [];
    Dis(mid(1)) = [];
end

for i = 1:size(F,2)
    if(F(1,i) ~= 59)
        Guidor(BattleFildPath,F(2,i),F(1,i));
    else
        GuidorG(BattleFildPath,4,59);
    end
end

%统计每个点每种类型的车有多少辆
CarDistri = zeros(3,6);%Z硬编码
for i = 1:size(CongestionBuffer,2)
    CarDistri(CongestionBuffer(6,i),CongestionBuffer(2,i)-2) = CarDistri(CongestionBuffer(6,i),CongestionBuffer(2,i)-2) + 1;
end

