clc
clear all
close all

mapss = xlsread('Locations',1,'B2:C131');%读取130个点的坐标
%% 绘制作战地图
figure(1);
set(0,'defaultfigurecolor','w');
BattleFild = MapGenerator();
title('战区地图');
%% 截至此时，我们已经将全部130个点的距离信息存入了对称矩阵：BattleFild（由MapGenerator返回）
%% 接下来，对这个矩阵进行操作即可进行我们所需的所有计算
%% 计算最佳炮击方案
figure(2);
BattleFild = MapGenerator();
%BattleFild为对称矩阵，标记了整张作战地图的全部邻接点距离
title('第一轮炮击点以及相关最佳路径');
Fbuffer = BestD4FirstShort(BattleFild);
%Fbuffer中存储的就是被选中的第一轮炮击的泡位
%第一行为周转时间，第二行为炮位编号(F，真实编号不修正），第三行为出发点编号(D)，第四行为火炮种类
%注意，炮位编号需要+8偏移才能对应BattleFild中的位置信息
%TimeTable = TimeTrace(Fbuffer,BattleFild);%获取第一阶段的时间表格
%使用xlswrite('D:\data',TimeTable)导出数据

figure(3);
BattleFild = MapGenerator();
%BattleFild为对称矩阵，标记了整张作战地图的全部邻接点距离
title('第一次打击完成后最佳装弹路径');
CongestionBuffer = BestD4SecondShort(BattleFild,Fbuffer);
%CongestionBuffer： 七行拥塞系数矩阵
%                   第一行为第一轮发射使用的炮击阵地编号（真实编号未修正）
%                   第二行为隶属的Z点编号（修正编号）
%                   第三行为Z点拥塞系数e
%                   第四行为从属度（核心判断标准）j
%                   第五行为时间距离
%                   第六行为火炮类型

figure(4);
MapGenerator();
for j = 1:24
    plot([mapss(CongestionBuffer(1,j)+8,1) mapss(CongestionBuffer(2,j),1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(CongestionBuffer(2,j),2)],'-g');
end
title('第一轮炮击位置与装载点间的聚类示意图');

figure(5);
BattleFild = MapGenerator();
%BattleFild为对称矩阵，标记了整张作战地图的全部邻接点距离
[Zpoint,FEmputy] = BestD4HoldPoint(BattleFild,Fbuffer,CongestionBuffer);
title('装弹之后二次打击的最佳路径');

figure(6);
MapGenerator();
for i = 1:size(FEmputy,2)
    plot([mapss(FEmputy(1,i)+8,1) mapss(FEmputy(2,i),1)],[mapss(FEmputy(1,i)+8,2) mapss(FEmputy(2,i),2)],'-r');
end
title('装弹完毕后第二轮发射点与装载点聚类图');

%计算附加新的Z点情况下的Z点选择策略
CongestionLog = ExtaExchange(BattleFild,Fbuffer);

%寻找最佳藏匿地点，以及最佳替换方案
figure(7);
BattleFild = MapGenerator();
HiddingPoint = LauncherHidding(BattleFild);
Chousen = PointCStandOut(BattleFild,Fbuffer);
title('新增C型载具的机动轨迹,以及被替换的C型发射器');

%选择被替换的C点
Chousen = PointCStandOut(BattleFild,Fbuffer);

figure(8);
BattleFild = MapGenerator();
title('负载均衡之后的调度方案');
FinalFbuffer = FinalFantasy(BattleFild);