function Chousen = PointCStandOut(BattleFild,Fbuffer)
%% 参数说明
%输入数据：
%BattleFild 地图矩阵
%Fbuffer    第一轮炮击信息
%
%输出数据：
%Chousen    1*3矩阵，被选中的三个C点在Fbuffer中的位置
%% 开始计算
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
%计算最短路径，及其时间
[BattleFildDisC,BattleFildPathC ]  = Floyd(TimeFild4C);
[BattleFildDisB,BattleFildPathB ]  = Floyd(TimeFild4B);
[BattleFildDisA,BattleFildPathA ]  = Floyd(TimeFild4A);
[Zpoint,FEmputy] = FEmputyCluster(BattleFild,Fbuffer);

Fmid = Fbuffer;
Log = zeros(1,12);%记录每一轮的隶属度总和
for k = 1:12
    Fbuffer = Fmid;
    Fbuffer(2,k) = 0;
    %利用修正后的C点信息重新计算各点从属度]
    CongestionBuffer = zeros(6,24);
    VarBuffer = zeros(2,size(Zpoint,2));
    VarBuffer(1,:) = Zpoint(1,:);
    for i = 1:3
        [CongestionBuffer,VarBuffer] = CongestionDegree(BattleFildDisA,BattleFildDisB,BattleFildDisC,Zpoint,Fbuffer,CongestionBuffer,i,VarBuffer);
    end
    for j = 1:24
        if(CongestionBuffer(4,j)<Inf)
            Log(k) = Log(k) + CongestionBuffer(4,j);
        end
    end
end
Chousen = zeros(1,3);
Fbuffer = Fmid;
for i = 1:3%找出三个最大值
    [a,Chousen(i)] = max(Log);
    Log(Chousen(i)) = 0;
    CaculateRolle(8,mapss(Fbuffer(2,Chousen(i))+8,1),mapss(Fbuffer(2,Chousen(i))+8,2),'b');
end

%绘制被选中的点
A1=1;
A2=4;
B1=1;
B2=4;
C1=1;
C2=7;
for i = 1:size(Fbuffer,2)
    plot(mapss(Fbuffer(2,i)+8,1),mapss(Fbuffer(2,i)+8,2),'*g');
    if(Fbuffer(4,i) == 1)
        if(Fbuffer(3,i) == 1)
            te = num2str(A1);
            te = ['A',te];
            A1=A1+1;
        else
            te = num2str(A2);
            te = ['A',te];
            A2=A2+1;
        end
        text(mapss(Fbuffer(2,i)+8,1)+1.5,mapss(Fbuffer(2,i)+8,2)-2,te,'color','k');
    end
    if(Fbuffer(4,i) == 2)
        if(Fbuffer(3,i) == 1)
            te = num2str(B1);
            te = ['B',te];
            B1=B1+1;
        else
            te = num2str(B2);
            te = ['B',te];
            B2=B2+1;
        end
        text(mapss(Fbuffer(2,i)+8,1)+1.5,mapss(Fbuffer(2,i)+8,2)-2,te,'color','k');
    end
    if(Fbuffer(4,i) == 3)
        if(Fbuffer(3,i) == 1)
            te = num2str(C1);
            te = ['C',te];
            C1=C1+1;
        else
            te = num2str(C2);
            te = ['C',te];
            C2=C2+1;
        end
        text(mapss(Fbuffer(2,i)+8,1)+1.5,mapss(Fbuffer(2,i)+8,2)-2,te,'color','k');
    end
end