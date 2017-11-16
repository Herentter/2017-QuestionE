function [CongestionBuffer,VarBuffer] = CongestionDegree(BattleFildDisA,BattleFildDisB,BattleFildDisC,Zpoint,Fbuffer,Congestiontt,squareLimit,VarBuffer)
%% 参数说明
%传入参数：
%BattleFildDisA
%BattleFildDisB
%BattleFildDisC
%           当前点的时间长度矩阵，尺寸130*130
%           分别对应A,B和C类发射器
%Zpoint：Z参数，2行矩阵
%       第一行表示Z点修正编号
%       第二行表示Z点空闲度
%Fbuffer：F点参数
%第一行为周转时间，第二行为炮位编号(F，真实编号不修正），第三行为出发点编号(D)，第四行为火炮种类
%这里需要调用第二行和第三行数据
%Congestiontt：       七行拥塞系数矩阵
%                   第一行为第一轮发射使用的炮击阵地编号（真实编号未修正）
%                   第二行为隶属的Z点编号（修正编号）
%                   第三行为Z点拥塞系数
%                   第四行为从属度（核心判断标准）*
%                   第五行为时间距离             *
%                   第六行为火炮类型
%VarBuffer: 两行矩阵
%           第一行为Z点修正编号
%           第二行对应点的方差（初值为0,空闲值为1）

%输出参数：
%CongestionBuffer： 七行拥塞系数矩阵
%                   第一行为第一轮发射使用的炮击阵地编号（真实编号未修正）     *
%                   第二行为隶属的Z点编号（修正编号）
%                   第三行为Z点拥塞系数
%                   第四行为从属度（核心判断标准）
%                   第五行为时间距离
%                   第六行为火炮类型                                        *

%% 计算拥塞系数E和从属度T
CongestionBuffer = Congestiontt;
%第一行记录每个Z点的
for i = 1:24
    CongestionBuffer(1,i) = Fbuffer(2,i);%选取炮击阵地编号（F，真实编号，未修正）
    CongestionBuffer(6,i) = Fbuffer(4,i);%写入火炮类型
    if(Fbuffer(4,i) == 1)%A类火炮
        for j = 1:size(Zpoint,2)%计算Zpoint(1,j)号Z点对i号炮位的从属度
            E = Zpoint(2,j);%提取空闲度
%             Var = Congestiontt(7,i);%提取距离方差（初值为0）
            Var = VarBuffer(2,j);%这里直接使用j，是因为VarBuffer和Zpoint的顺序完全相同
            count = 0;%计算注册点数
            for k = 1:size(Congestiontt,2)
                if(Congestiontt(2,k) == Zpoint(1,j))
                    count = count +1;
                end
            end
            Conjection = CongectionFunction(count,Var,E);%计算拥塞系数
            Dist = BattleFildDisA(Zpoint(1,j),Fbuffer(2,i)+8);%提取距离，准备计算从属度
            T=1/(Conjection*Conjection*sqrt(Dist));%从属度
            if(CongestionBuffer(4,i) == 0 || CongestionBuffer(4,i)<T)
                CongestionBuffer(4,i)=T;%修改从属度
                CongestionBuffer(2,i) = Zpoint(1,j);%隶属的Z点编号（修正编号）
                CongestionBuffer(3,i) = Conjection;%Z点拥塞系数
                CongestionBuffer(5,i) = Dist;%时间距离
            end
        end
    end
    if(Fbuffer(4,i) == 2)%B类火炮
        for j = 1:size(Zpoint,2)%计算Zpoint(1,j)号Z点对i号炮位的从属度
            E = Zpoint(2,j);%提取空闲度
%             Var = Congestiontt(7,i);%提取距离方差（初值为0）
            Var = VarBuffer(2,j);%这里直接使用j，是因为VarBuffer和Zpoint的顺序完全相同
            count = 0;%计算注册点数
            for k = 1:size(Congestiontt,2)
                if(Congestiontt(2,k) == Zpoint(1,j))
                    count = count +1;
                end
            end
            Conjection = CongectionFunction(count,Var,E);%计算拥塞系数
            Dist = BattleFildDisB(Zpoint(1,j),Fbuffer(2,i)+8);%提取距离，准备计算从属度
            T=1/(Conjection*Conjection*sqrt(Dist));%从属度
            if(CongestionBuffer(4,i) == 0 || CongestionBuffer(4,i)<T)
                CongestionBuffer(4,i)=T;%修改从属度
                CongestionBuffer(2,i) = Zpoint(1,j);%隶属的Z点编号（修正编号）
                CongestionBuffer(3,i) = Conjection;%Z点拥塞系数
                CongestionBuffer(5,i) = Dist;%时间距离
            end
        end
    end
    if(Fbuffer(4,i) == 3)%C类火炮
        for j = 1:size(Zpoint,2)%计算Zpoint(1,j)号Z点对i号炮位的从属度
            E = Zpoint(2,j);%提取空闲度
%             Var = Congestiontt(7,i);%提取距离方差（初值为0）
            Var = VarBuffer(2,j);%这里直接使用j，是因为VarBuffer和Zpoint的顺序完全相同
            count = 0;%计算注册点数
            for k = 1:size(Congestiontt,2)
                if(Congestiontt(2,k) == Zpoint(1,j))
                    count = count +1;
                end
            end
            Conjection = CongectionFunction(count,Var,E);%计算拥塞系数
            Dist = BattleFildDisC(Zpoint(1,j),Fbuffer(2,i)+8);%提取距离，准备计算从属度
            T=1/(Conjection*Conjection*sqrt(Dist));%从属度
            if(CongestionBuffer(4,i) == 0 || CongestionBuffer(4,i)<T)
                CongestionBuffer(4,i)=T;%修改从属度
                CongestionBuffer(2,i) = Zpoint(1,j);%隶属的Z点编号（修正编号）
                CongestionBuffer(3,i) = Conjection;%Z点拥塞系数
                CongestionBuffer(5,i) = Dist;%时间距离
            end
        end
    end
end
%% 根据新的隶属关系重新计算各个Z点的方差
%新的从属关系存放在CongestionBuffer中
ZBuffer = zeros(4,size(Zpoint,2));%存储各个Z点的总时间长度
%第一行为Z的修正编号
%第二行为时间长度和
%第三行为与该Z点相连的F点个数
%第四行为平方差和
ZBuffer(1,:) = Zpoint(1,:);
for i = 1:24
    for j = 1:size(Zpoint,2)
        if(CongestionBuffer(2,i) == ZBuffer(1,j))
            ZBuffer(2,j) = ZBuffer(2,j) + CongestionBuffer(5,i);
            ZBuffer(3,j) = ZBuffer(3,j) + 1;
        end
    end
end
for i = 1:24
    for j = 1:size(Zpoint,2)
        if(CongestionBuffer(2,i) == ZBuffer(1,j))
            ZBuffer(4,j) = ZBuffer(4,j) + (ZBuffer(2,j)/ZBuffer(3,j)-CongestionBuffer(5,i))*(ZBuffer(2,j)/ZBuffer(3,j)-CongestionBuffer(5,i));
        end
    end
end
for i = 1:size(VarBuffer,2)
    for j = 1:size(Zpoint,2)
        if(VarBuffer(1,i) == ZBuffer(1,j) && ZBuffer(3,j) ~= 0)
            VarBuffer(2,i) = ZBuffer(4,j)/ZBuffer(3,j);
        end
        if(VarBuffer(1,i) == ZBuffer(1,j) && ZBuffer(3,j) == 0)
            VarBuffer(2,i) = 0.5;
        end
    end
end
