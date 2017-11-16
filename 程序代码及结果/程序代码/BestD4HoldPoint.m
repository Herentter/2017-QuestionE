function [Zpoint,FEmputy] = BestD4HoldPoint(BattleFild,Fbuffer,CongestionBuffer)
%% ����˵��
%CongestionBuffer   �ڶ���Ϊÿ������ȥ��
%                   ������Ϊÿ����������

%% �㷨����
[Zpoint,FEmputy] = FEmputyCluster(BattleFild,Fbuffer);
%���δ������䷽���洢��FEmputy��
%���жȴ洢��Zpoint��

%% ��������ͼ
mapss = xlsread('Locations',1,'B2:C131');%��ȡ130���������
%FEmputy:       ���о���,���Z��F��֮������ӹ�ϵ
%               ��һ�б��F���ţ���ʵ��ţ�
%               �ڶ���Ϊ��F������Z���ţ�������ţ�
%               ������Ϊ���д�����
%���Դ��룬����������δ���ڻ�λ�õľ���ʾ��ͼ
% for i = 1:size(FEmputy,2)
%     plot([mapss(FEmputy(1,i)+8,1) mapss(FEmputy(2,i),1)],[mapss(FEmputy(1,i)+8,2) mapss(FEmputy(2,i),2)],'-g');
% end
[BattleFildDis,BattleFildPath ]  = Floyd(BattleFild);
F = FEmputy;
F(1,:) = F(1,:) +8;
Dis = zeros(1,size(F,2));
for i = 1:size(F,2)
    Dis(i) = BattleFildDis(F(1,i),F(2,i));
end
mid = [0 0];%��һ������ʾ��ţ��ڶ�������ʾ����
for i = 1:size(F,2)
    if(F(2,i)==5 && Dis(i)>mid(2))
        mid(1) = i;
        mid(2) = Dis(i);
    end
end
F(:,mid(1)) = [];
Dis(mid(1)) = [];

for count = 1:5
    mid = [0 0];%��һ������ʾ��ţ��ڶ�������ʾ����
    for i = 1:size(F,2)
        if(F(2,i)==6 && Dis(i)>mid(2))
            mid(1) = i;
            mid(2) = Dis(i);
        end
    end
    F(:,mid(1)) = [];
    Dis(mid(1)) = [];
end

for count = 1:2
    mid = [0 0];%��һ������ʾ��ţ��ڶ�������ʾ����
    for i = 1:size(F,2)
        if(F(2,i)==7 && Dis(i)>mid(2))
            mid(1) = i;
            mid(2) = Dis(i);
        end
    end
    F(:,mid(1)) = [];
    Dis(mid(1)) = [];
end

for count = 1:4
    mid = [0 0];%��һ������ʾ��ţ��ڶ�������ʾ����
    for i = 1:size(F,2)
        if(F(2,i)==8 && Dis(i)>mid(2))
            mid(1) = i;
            mid(2) = Dis(i);
        end
    end
    F(:,mid(1)) = [];
    Dis(mid(1)) = [];
end

for i = 1:size(F,2)
    if(F(1,i) ~= 59)
        Guidor(BattleFildPath,F(2,i),F(1,i));
    else
        GuidorG(BattleFildPath,4,59);
    end
end

%ͳ��ÿ����ÿ�����͵ĳ��ж�����
CarDistri = zeros(3,6);%ZӲ����
for i = 1:size(CongestionBuffer,2)
    CarDistri(CongestionBuffer(6,i),CongestionBuffer(2,i)-2) = CarDistri(CongestionBuffer(6,i),CongestionBuffer(2,i)-2) + 1;
end

