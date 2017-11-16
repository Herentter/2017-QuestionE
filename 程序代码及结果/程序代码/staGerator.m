function [sta,BattleFildPath] = staGerator(extraLen,TimeFild,model)

[ BattleFildDis , BattleFildPath ] = Floyd(TimeFild);
% 塞选首批发射的24个点
count = 1;
sta = zeros(4,extraLen);%第三行标记起始点编号，第四行标记发射器类型
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
        sta(3,:) = 1;%所有点都来自D1
    end
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
        sta(3,:) = 2;%所有点都来自D1
    end
end
% for i = 1:size(staC,2)%调试语句，用于显示本轮被选中的点
%     plot(mapss(staC(2,i)+8,1),mapss(staC(2,i)+8,2),'*g');
% end
sta(4,:) = model;%C型发射器