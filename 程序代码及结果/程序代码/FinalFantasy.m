function Fbuffer = FinalFantasy(BattleFild)

%% ����ʹ�û���Floyd�㷨��һ�γ����Ŵ��㷨�����㷨����һ�ʳ���ΪTSP����ı���
%% ����ֱ��·������ȡλ������
% [ BattleFildDis , BattleFildPath ] = Floyd(BattleFild);%�����Ǹ��ٹ�·������¼�������·��
mapss = xlsread('Locations',1,'B2:C131');%��ȡ130���������
weight = 1.6;
Hweight = 1.1;
%��ֹ��ʱ��TimeFild4A��TimeFild4B,TimeFild4C��
%�ֱ�洢��ABC���ַ��䳵�ڸ��ι�·�ϻ��������ʱ��


%% ����C�ͷ��䳵��Ǩ��·��
TimeFild4C = BattleFild/30;%����C�෢�䳵��ͨ��·���ٶ�
for i =1:20%������ٹ�·���ٶ�
    TimeFild4C(i+68,i+69) = BattleFild(i+68,i+69)*Hweight/50*weight;
    TimeFild4C(i+69,i+68) = TimeFild4C(i+68,i+69);
end
[ BattleFildDis , BattleFildPath ] = Floyd(TimeFild4C);
% ��ѡ���������24����
%��ѡ������D1�����6����
count = 1;
sta = zeros(4,6);%�����б����ʼ���ţ������б�Ƿ���������
for i = 1:60
    if(BattleFildDis(1,8+i)<BattleFildDis(2,8+i))
        if(count<=size(sta,2))%��ʱջ��û����
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
% for i = 1:size(staC,2)%������䣬������ʾ���ֱ�ѡ�еĵ�
%     plot(mapss(staC(2,i)+8,1),mapss(staC(2,i)+8,2),'*g');
% end
sta(3,:) = 1;%���е㶼����D1
sta(4,:) = 3;%C�ͷ�����
Fbuffer = sta;%Fbuffer���ڼ�¼���ձ�ѡ�еĵ�
%��ѡ������D2�����6����
count = 1;
sta = zeros(2,6);
for i = 1:60
    if(BattleFildDis(1,8+i)>BattleFildDis(2,8+i))
        if(count<=size(sta,2))%��ʱջ��û����
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
% for i = 1:size(staC,2)%������䣬������ʾ���ֱ�ѡ�еĵ�
%     plot(mapss(staC(2,i)+8,1),mapss(staC(2,i)+8,2),'*g');
% end
sta(3,:) = 2;%���е㶼����D2
sta(4,:) = 3;%C�ͷ�����
Fbuffer = [ Fbuffer sta ];%����Buffer

%�����н��켣
%�����б����ʼ���ţ������б�Ƿ���������
for t = 1:12
    if(Fbuffer(3,t) == 1)
        %��������D1�����ת�켣
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
        %��������D2�����ת�켣
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



%% ����B�ͷ��䳵��Ǩ��·��
TimeFild4B = BattleFild/35;%����B�෢�䳵��ͨ��·���ٶ�
for i =1:20%������ٹ�·���ٶ�
    TimeFild4B(i+68,i+69) = BattleFild(i+68,i+69)*Hweight/60*weight;
    TimeFild4B(i+69,i+68) = TimeFild4B(i+68,i+69);
end
[ BattleFildDis , BattleFildPath ] = Floyd(TimeFild4B);
% ��ѡ���������24����
%��ѡ������D1�����9����
%��ѡ9��������Ϊ�ڽ���������Ҫɾ��ǰ���Ѿ���ѡ����6������C���ķ����
count = 1;
sta = zeros(4,9);
for i = 1:60
    if(BattleFildDis(1,8+i)<BattleFildDis(2,8+i))
        if(count<=size(sta,2))%��ʱջ��û����
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
            sta(:,j)=[];%ɾ�����ظ�����
        end
    end
end
for j = 4:size(sta,2)
	sta(:,4)=[];%ֻ����ǰ3�У�ɾ��ʣ�����
end
sta(3,:) = 1;%���е㶼����D1
sta(4,:) = 2;%B�ͷ�����
Fbuffer = [ Fbuffer sta ];%����Buffer
%��ѡ������D2�����9����
count = 1;
sta = zeros(4,9);
for i = 1:60
    if(BattleFildDis(1,8+i)>BattleFildDis(2,8+i))
        if(count<=size(sta,2))%��ʱջ��û����
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
            sta(:,j)=[];%ɾ�����ظ�����
        end
    end
end
for j = 4:size(sta,2)
	sta(:,4)=[];%ֻ����ǰ3�У�ɾ��ʣ�����
end
sta(3,:) = 2;%���е㶼����D2
sta(4,:) = 2;%B�ͷ�����
Fbuffer = [ Fbuffer sta ];%����Buffer


%�����н��켣
%�����б����ʼ���ţ������б�Ƿ���������
for t = 13:18
    if(Fbuffer(3,t) == 1)
        %��������D1�����ת�켣
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
        %��������D2�����ת�켣
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

%% ����A�ͷ��䳵��Ǩ��·��
TimeFild4A = BattleFild/45;%����A�෢�䳵��ͨ��·���ٶ�
for i =1:20%������ٹ�·���ٶ�
    TimeFild4A(i+68,i+69) = BattleFild(i+68,i+69)*Hweight/70*weight;
    TimeFild4A(i+69,i+68) = TimeFild4A(i+68,i+69);
end
[ BattleFildDis , BattleFildPath ] = Floyd(TimeFild4A);
% ��ѡ���������24����
%��ѡ������D1�����12����
%��ѡ12��������Ϊ�ڽ���������Ҫɾ��ǰ���Ѿ���ѡ����6������C���ķ����
%�Լ�3������B���ķ����
count = 1;
sta = zeros(4,12);
for i = 1:60
    if(BattleFildDis(1,8+i)<BattleFildDis(2,8+i))
        if(count<=size(sta,2))%��ʱջ��û����
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
            sta(:,j)=[];%ɾ�����ظ�����
        end
    end
end
for j = 4:size(sta,2)
	sta(:,4)=[];%ֻ����ǰ3�У�ɾ��ʣ�����
end
sta(3,:) = 1;%���е㶼����D1
sta(4,:) = 1;%A�ͷ�����
Fbuffer = [ Fbuffer sta ];%����Buffer
%��ѡ������D2�����12����
count = 1;
sta = zeros(4,12);
for i = 1:60
    if(BattleFildDis(1,8+i)>BattleFildDis(2,8+i))
        if(count<=size(sta,2))%��ʱջ��û����
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
            sta(:,j)=[];%ɾ�����ظ�����
        end
    end
end
for j = 4:size(sta,2)
	sta(:,4)=[];%ֻ����ǰ3�У�ɾ��ʣ�����
end
sta(3,:) = 2;%���е㶼����D1
sta(4,:) = 1;%B�ͷ�����
Fbuffer = [ Fbuffer sta ];%����Buffer

%�����н��켣
%�����б����ʼ���ţ������б�Ƿ���������
for t = 19:24
    if(Fbuffer(3,t) == 1)
        %��������D1�����ת�켣
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
        %��������D2�����ת�켣
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



%% ���Ʊ�ѡ�еĵ�
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