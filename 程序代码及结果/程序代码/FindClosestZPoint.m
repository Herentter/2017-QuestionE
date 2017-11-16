function ZDistributPlan = FindClosestZPoint(BattleFildDis,Fbuffer,Zpoint)
%% 参数说明：
%传入值：
%Zpoint：二维矩阵
%       第一行Z点的修正编号
%       第二行为负载系数,负载系数越大，说明压力越大
%       这一设计是为了提升此函数的通用性，使得这个函数可以在第二问中依然发挥作用
%Fbuffer:一维矩阵，要计算隶属关系的F点，传入F点真实编号，不修正
%BattleFildDis：与F点载具种类对应的时间长度矩阵

%传出值：
%ZDistributPlan:四行矩阵,标记每个发射车发射之后前往装弹的Z点
%               第一行标记F点编号（真实编号）
%               第二行为该F所属的Z点编号（修正编号）
%               第三行标记该路径负载压力
%               第四行为路径长度

%算法思想：
%这个算法不修正负载系数，只根据距离和负载系数简单计算从属关系
%本算法存在的意义是简化主算法代码，增强代码可读性

Fadjust = 8;%F点偏移量，单独抽出这个变量是为了方便调试

%% 根据不同型号导弹车的速度，计算其与Z点之间的从属关系
%假定BattleFild,BattleFildPath已经是F点载具对应的路径和时间信息
%因此无需考虑不同车辆速度差异
%ZDistributPlan包含两行
%第一行存储始发F点编号（真实编号，不修正）
%第二行存储Z点编号（BattleField修正编号）
%第三行存储负载度

Fbuffer = Fbuffer + Fadjust;%将Fbuffer统一修正为修正编号
Zbuffer = zeros(3,size(Fbuffer,2));
%第一行存储F点真实
%第二行存储Z点修正编号
%第三行存储负载压力（E = S*P)
%第四行为路径长度
for i = 1:size(Fbuffer,2)%i为第i个F
    count = 0;
    for j = Zpoint(1,1:size(Zpoint,2))%j为Z的修正编号
        count = count + 1;
        %计算负载度
        e = BattleFildDis(Fbuffer(i),j)*Zpoint(2,count);
        if(Zbuffer(3,i) == 0 || Zbuffer(3,i)>e)
            Zbuffer(3,i) = e;%更新F点(真实编号)到第j个Z的负载度
            Zbuffer(2,i) = j;
            Zbuffer(1,i) = Fbuffer(i)-Fadjust;%从修正编号变为真实编号
            Zbuffer(4,i) = BattleFildDis(Fbuffer(i),j);
        end
    end
end

ZDistributPlan = Zbuffer;
