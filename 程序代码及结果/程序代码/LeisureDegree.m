function Zpoint = LeisureDegree(BattleFildDis,FEmputy,Zpoint)

%% 参数说明：
%传入值：
%Zpoint：二维矩阵
%       第一行Z点的修正编号
%       第二行为待修正的空闲系数,空闲系数越大，说明该点越空闲
%       这一设计是为了提升此函数的通用性，使得这个函数可以在第二问中依然发挥作用
%FEmputy:       三行矩阵,标记Z和F点之间的连接关系
%               第一行标记F点编号（真实编号）
%               第二行为该F所属的Z点编号（修正编号）
%               第三行为路径长度
%BattleFildDis：路径长度矩阵
%
%本函数用于计算各个Z点的空闲度

%% 函数主体
Zpoint(2,:) = 1;
for i = 1:size(FEmputy,2)
    for j = 1:size(Zpoint,2)
        if(FEmputy(2,i) == Zpoint(1,j))
            Zpoint(2,j) = Zpoint(2,j) + 1/BattleFildDis(FEmputy(1,i)+8,FEmputy(1,j));
        end
    end
end