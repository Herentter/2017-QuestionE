function [Zpoint,FEmputy] = FEmputyCluster(BattleFild,Fbuffer)

%使用模拟退火算法和空闲均衡策略，求出最佳炮位与Z点之间的对应关系

T0 = 120;%初始温度
q = 0.8;%降温速率

Zpoint = ones(2,6);
for i =1:6
    Zpoint(1,i) = i+2;
end
[BattleFildDis,BattleFildPath ]  = Floyd(BattleFild);

while T0>sum(Zpoint(2,:))%使用模拟退火算法进行聚类优化
    FEmputy = EmputyFCluster(BattleFildDis,Fbuffer,Zpoint);%每次计算空闲度之后，都对炮击位置重新分配
    Zpoint = LeisureDegree(BattleFildDis,FEmputy,Zpoint);%反复迭代计算空闲度
    T0 = T0 * q;
end

%以下为调试语句，用于输出退火结果
% mapss = xlsread('Locations',1,'B2:C131');%读取130个点的坐标
% MapGenerator();
% for i = 1:size(FEmputy,2)
%     plot([mapss(FEmputy(1,i)+8,1) mapss(FEmputy(2,i),1)],[mapss(FEmputy(1,i)+8,2) mapss(FEmputy(2,i),2)],'-g');
% end