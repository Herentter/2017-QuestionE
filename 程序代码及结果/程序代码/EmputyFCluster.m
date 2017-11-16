function FEmputy = EmputyFCluster(BattleFildDis,Fbuffer,Zpoint)
%% 参数说明：
%传入值：
%Zpoint：二维矩阵
%       第一行Z点的修正编号
%       第二行为空闲系数,空闲系数越大，说明该点越空闲
%       这一设计是为了提升此函数的通用性，使得这个函数可以在第二问中依然发挥作用
%Fbuffer：   存储的就是被选中的第一轮炮击的泡位
%           第一行为周转时间，第二行为炮位编号(F，真实编号不修正），第三行为出发点编号(D)，第四行为火炮种类
%BattleFildDis：路径长度矩阵

%传出值：
%FEmputy:       三行矩阵,标记Z和F点之间的连接关系
%               第一行标记F点编号（真实编号）
%               第二行为该F所属的Z点编号（修正编号）
%               第三行为空闲从属度

%算法思想：
%这个算法不修正负载系数，只根初始化空的发射位与Z点之间的关系

%% 数据初始化
F = zeros(3,60);
%F中存储所有没有被使用的炮位
%第一行为炮位编号（F，真实编号未修正）
%第二行为隶属的Z点编号（修正编号）
%第三行为距离
for i = 1:60
    F(1,i) = i;
end
for i = 1:24
    for j = 1:size(F,2)
        if(Fbuffer(2,i) == F(1,j))
            F(:,j) = [];
            break
        end
    end
end
for i = 1:size(F,2)
    for j = 1:size(Zpoint,2)
        e = BattleFildDis(Zpoint(1,j),F(1,i)+8)*Zpoint(2,j)*Zpoint(2,j);%计算空闲从属度
        if(F(3,i) == 0 || F(3,i)<1/e)
            F(3,i) = 1/e;
            F(2,i) = Zpoint(1,j);
        end
    end
end

FEmputy = F;