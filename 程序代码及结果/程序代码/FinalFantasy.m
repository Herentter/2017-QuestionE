function Fbuffer = FinalFantasy(BattleFild)

%% 这里使用基于Floyd算法的一次成型遗传算法，本算法将第一问抽象为TSP问题的变体
%% 计算直连路径并读取位置数据
% [ BattleFildDis , BattleFildPath ] = Floyd(BattleFild);%不考虑高速公路的情况下计算的最短路径
mapss = xlsread('Locations',1,'B2:C131');%读取130个点的坐标
weight = 1.6;
Hweight = 1.1;
%截止此时，TimeFild4A，TimeFild4B,TimeFild4C内
%分别存储了ABC三种发射车在个段公路上机动所需的时间


%% 绘制C型发射车的迁移路径
TimeFild4C = BattleFild/30;%计算C类发射车普通公路的速度
for i =1:20%计算高速公路的速度
    TimeFild4C(i+68,i+69) = BattleFild(i+68,i+69)*Hweight/50*weight;
    TimeFild4C(i+69,i+68) = TimeFild4C(i+68,i+69);
end
[ BattleFildDis , BattleFildPath ] = Floyd(TimeFild4C);
% 塞选首批发射的24个点
%塞选出距离D1最近的6个点
count = 1;
sta = zeros(4,6);%第三行标记起始点编号，第四行标记发射器类型
for i = 1:60
    if(BattleFildDis(1,8+i)<BattleFildDis(2,8+i))
        if(count<=size(sta,2))%此时栈还没有满
            sta(2,count)=i;
            sta(1,count)=BattleFildDis(1,8+i);
            count = count + 1;
        else
            [a b] = sort(sta,2);
            sta(2,:) = sta(2,b(1,:));
            sta(1,:) = a(1,:);
            if(sta(1,size(sta,2))>BattleFildDis(1,8+i))
                sta(2,size(sta,2))=i;
                sta(1,size(sta,2))=BattleFildDis(1,8+i);
            end
        end
    end
end
% for i = 1:size(staC,2)%调试语句，用于显示本轮被选中的点
%     plot(mapss(staC(2,i)+8,1),mapss(staC(2,i)+8,2),'*g');
% end
sta(3,:) = 1;%所有点都来自D1
sta(4,:) = 3;%C型发射器
Fbuffer = sta;%Fbuffer用于记录最终被选中的点
%塞选出距离D2最近的6个点
count = 1;
sta = zeros(2,6);
for i = 1:60
    if(BattleFildDis(1,8+i)>BattleFildDis(2,8+i))
        if(count<=size(sta,2))%此时栈还没有满
            sta(2,count)=i;
            sta(1,count)=BattleFildDis(2,8+i);
            count = count + 1;
        else
            [a b] = sort(sta,2);
            sta(2,:) = sta(2,b(1,:));
            sta(1,:) = a(1,:);
            if(sta(1,size(sta,2))>BattleFildDis(2,8+i))
                sta(2,size(sta,2))=i;
                sta(1,size(sta,2))=BattleFildDis(2,8+i);
            end
        end
    end
end
% for i = 1:size(staC,2)%调试语句，用于显示本轮被选中的点
%     plot(mapss(staC(2,i)+8,1),mapss(staC(2,i)+8,2),'*g');
% end
sta(3,:) = 2;%所有点都来自D2
sta(4,:) = 3;%C型发射器
Fbuffer = [ Fbuffer sta ];%存入Buffer

%绘制行进轨迹
%第三行标记起始点编号，第四行标记发射器类型
for t = 1:12
    if(Fbuffer(3,t) == 1)
        %绘制来自D1点的周转轨迹
        i = Fbuffer(2,t);
        count = 0;
        k = BattleFildPath(1,i+8);
        plot( [mapss(1,1) mapss(k,1)],[mapss(1,2) mapss(k,2)],'-g');
        BattleFild(1,k) = BattleFild(1,k)*weight;
        while(k~= i+8)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPath(k,i+8),1)],[mapss(k,2) mapss(BattleFildPath(k,i+8),2)],'-g');
            BattleFild(k,BattleFildPath(k,i+8)) = BattleFild(k,BattleFildPath(k,i+8))*weight;
            k = BattleFildPath(k,i+8);
        end
    else
        %绘制来自D2点的周转轨迹
        i = Fbuffer(2,t);
        count = 0;
        k = BattleFildPath(2,i+8);
        plot( [mapss(2,1) mapss(k,1)],[mapss(2,2) mapss(k,2)],'-r');
        BattleFild(1,k) = BattleFild(1,k)*weight;
        while(k~= i+8)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPath(k,i+8),1)],[mapss(k,2) mapss(BattleFildPath(k,i+8),2)],'-r');
            BattleFild(k,BattleFildPath(k,i+8)) = BattleFild(k,BattleFildPath(k,i+8))*weight;
            k = BattleFildPath(k,i+8);
        end
    end
end



%% 绘制B型发射车的迁移路径
TimeFild4B = BattleFild/35;%计算B类发射车普通公路的速度
for i =1:20%计算高速公路的速度
    TimeFild4B(i+68,i+69) = BattleFild(i+68,i+69)*Hweight/60*weight;
    TimeFild4B(i+69,i+68) = TimeFild4B(i+68,i+69);
end
[ BattleFildDis , BattleFildPath ] = Floyd(TimeFild4B);
% 塞选首批发射的24个点
%塞选出距离D1最近的9个点
%赛选9个点是因为在接下来可能要删除前面已经赛选过的6个属于C车的发射点
count = 1;
sta = zeros(4,9);
for i = 1:60
    if(BattleFildDis(1,8+i)<BattleFildDis(2,8+i))
        if(count<=size(sta,2))%此时栈还没有满
            sta(2,count)=i;
            sta(1,count)=BattleFildDis(1,8+i);
            count = count + 1;
        else
            [a b] = sort(sta,2);
            sta(2,:) = sta(2,b(1,:));
            sta(1,:) = a(1,:);
            if(sta(1,size(sta,2))>BattleFildDis(1,8+i))
                sta(2,size(sta,2))=i;
                sta(1,size(sta,2))=BattleFildDis(1,8+i);
            end
        end
    end
end
% for i = 1:size(staB,2)
%     plot(mapss(staB(2,i)+8,1),mapss(staB(2,i)+8,2),'*g');
% end
for i = 1:size(Fbuffer,2)
    for j = 1:size(sta,2)
        if(j>size(sta,2))
            break
        end
        if(sta(2,j)==Fbuffer(2,i))
            sta(:,j)=[];%删除掉重复的列
        end
    end
end
for j = 4:size(sta,2)
	sta(:,4)=[];%只保留前3列，删除剩余的列
end
sta(3,:) = 1;%所有点都来自D1
sta(4,:) = 2;%B型发射器
Fbuffer = [ Fbuffer sta ];%存入Buffer
%塞选出距离D2最近的9个点
count = 1;
sta = zeros(4,9);
for i = 1:60
    if(BattleFildDis(1,8+i)>BattleFildDis(2,8+i))
        if(count<=size(sta,2))%此时栈还没有满
            sta(2,count)=i;
            sta(1,count)=BattleFildDis(2,8+i);
            count = count + 1;
        else
            [a b] = sort(sta,2);
            sta(2,:) = sta(2,b(1,:));
            sta(1,:) = a(1,:);
            if(sta(1,size(sta,2))>BattleFildDis(2,8+i))
                sta(2,size(sta,2))=i;
                sta(1,size(sta,2))=BattleFildDis(2,8+i);
            end
        end
    end
end
% for i = 1:size(sta,2)
%     plot(mapss(sta(2,i)+8,1),mapss(sta(2,i)+8,2),'*g');
% end
for i = 1:size(Fbuffer,2)
    for j = 1:size(sta,2)
        if(j>size(sta,2))
            break
        end
        if(sta(2,j)==Fbuffer(2,i))
            sta(:,j)=[];%删除掉重复的列
        end
    end
end
for j = 4:size(sta,2)
	sta(:,4)=[];%只保留前3列，删除剩余的列
end
sta(3,:) = 2;%所有点都来自D2
sta(4,:) = 2;%B型发射器
Fbuffer = [ Fbuffer sta ];%存入Buffer


%绘制行进轨迹
%第三行标记起始点编号，第四行标记发射器类型
for t = 13:18
    if(Fbuffer(3,t) == 1)
        %绘制来自D1点的周转轨迹
        i = Fbuffer(2,t);
        count = 0;
        k = BattleFildPath(1,i+8);
        plot( [mapss(1,1) mapss(k,1)],[mapss(1,2) mapss(k,2)],'-g');
        BattleFild(1,k) = BattleFild(1,k)*weight;
        while(k~= i+8)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPath(k,i+8),1)],[mapss(k,2) mapss(BattleFildPath(k,i+8),2)],'-g');
            BattleFild(k,BattleFildPath(k,i+8)) = BattleFild(k,BattleFildPath(k,i+8))*weight;
            k = BattleFildPath(k,i+8);
        end
    else
        %绘制来自D2点的周转轨迹
        i = Fbuffer(2,t);
        count = 0;
        k = BattleFildPath(2,i+8);
        plot( [mapss(2,1) mapss(k,1)],[mapss(2,2) mapss(k,2)],'-r');
        BattleFild(1,k) = BattleFild(1,k)*weight;
        while(k~= i+8)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPath(k,i+8),1)],[mapss(k,2) mapss(BattleFildPath(k,i+8),2)],'-r');
            BattleFild(k,BattleFildPath(k,i+8)) = BattleFild(k,BattleFildPath(k,i+8))*weight;
            k = BattleFildPath(k,i+8);
        end
    end
end

%% 绘制A型发射车的迁移路径
TimeFild4A = BattleFild/45;%计算A类发射车普通公路的速度
for i =1:20%计算高速公路的速度
    TimeFild4A(i+68,i+69) = BattleFild(i+68,i+69)*Hweight/70*weight;
    TimeFild4A(i+69,i+68) = TimeFild4A(i+68,i+69);
end
[ BattleFildDis , BattleFildPath ] = Floyd(TimeFild4A);
% 塞选首批发射的24个点
%塞选出距离D1最近的12个点
%赛选12个点是因为在接下来可能要删除前面已经赛选过的6个属于C车的发射点
%以及3个属于B车的发射点
count = 1;
sta = zeros(4,12);
for i = 1:60
    if(BattleFildDis(1,8+i)<BattleFildDis(2,8+i))
        if(count<=size(sta,2))%此时栈还没有满
            sta(2,count)=i;
            sta(1,count)=BattleFildDis(1,8+i);
            count = count + 1;
        else
            [a b] = sort(sta,2);
            sta(2,:) = sta(2,b(1,:));
            sta(1,:) = a(1,:);
            if(sta(1,size(sta,2))>BattleFildDis(1,8+i))
                sta(2,size(sta,2))=i;
                sta(1,size(sta,2))=BattleFildDis(1,8+i);
            end
        end
    end
end
% for i = 1:size(sta,2)
%     plot(mapss(sta(2,i)+8,1),mapss(sta(2,i)+8,2),'*g');
% end
for i = 1:size(Fbuffer,2)
    for j = 1:size(sta,2)
        if(j>size(sta,2))
            break
        end
        if(sta(2,j)==Fbuffer(2,i))
            sta(:,j)=[];%删除掉重复的列
        end
    end
end
for j = 4:size(sta,2)
	sta(:,4)=[];%只保留前3列，删除剩余的列
end
sta(3,:) = 1;%所有点都来自D1
sta(4,:) = 1;%A型发射器
Fbuffer = [ Fbuffer sta ];%存入Buffer
%塞选出距离D2最近的12个点
count = 1;
sta = zeros(4,12);
for i = 1:60
    if(BattleFildDis(1,8+i)>BattleFildDis(2,8+i))
        if(count<=size(sta,2))%此时栈还没有满
            sta(2,count)=i;
            sta(1,count)=BattleFildDis(2,8+i);
            count = count + 1;
        else
            [a b] = sort(sta,2);
            sta(2,:) = sta(2,b(1,:));
            sta(1,:) = a(1,:);
            if(sta(1,size(sta,2))>BattleFildDis(2,8+i))
                sta(2,size(sta,2))=i;
                sta(1,size(sta,2))=BattleFildDis(2,8+i);
            end
        end
    end
end
for i = 1:size(Fbuffer,2)
    for j = 1:size(sta,2)
        if(j>size(sta,2))
            break
        end
        if(sta(2,j)==Fbuffer(2,i))
            sta(:,j)=[];%删除掉重复的列
        end
    end
end
for j = 4:size(sta,2)
	sta(:,4)=[];%只保留前3列，删除剩余的列
end
sta(3,:) = 2;%所有点都来自D1
sta(4,:) = 1;%B型发射器
Fbuffer = [ Fbuffer sta ];%存入Buffer

%绘制行进轨迹
%第三行标记起始点编号，第四行标记发射器类型
for t = 19:24
    if(Fbuffer(3,t) == 1)
        %绘制来自D1点的周转轨迹
        i = Fbuffer(2,t);
        count = 0;
        k = BattleFildPath(1,i+8);
        plot( [mapss(1,1) mapss(k,1)],[mapss(1,2) mapss(k,2)],'-g');
        BattleFild(1,k) = BattleFild(1,k)*weight;
        while(k~= i+8)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPath(k,i+8),1)],[mapss(k,2) mapss(BattleFildPath(k,i+8),2)],'-g');
            BattleFild(k,BattleFildPath(k,i+8)) = BattleFild(k,BattleFildPath(k,i+8))*weight;
            k = BattleFildPath(k,i+8);
        end
    else
        %绘制来自D2点的周转轨迹
        i = Fbuffer(2,t);
        count = 0;
        k = BattleFildPath(2,i+8);
        plot( [mapss(2,1) mapss(k,1)],[mapss(2,2) mapss(k,2)],'-r');
        BattleFild(1,k) = BattleFild(1,k)*weight;
        while(k~= i+8)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPath(k,i+8),1)],[mapss(k,2) mapss(BattleFildPath(k,i+8),2)],'-r');
            BattleFild(k,BattleFildPath(k,i+8)) = BattleFild(k,BattleFildPath(k,i+8))*weight;
            k = BattleFildPath(k,i+8);
        end
    end
end



%% 绘制被选中的点
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