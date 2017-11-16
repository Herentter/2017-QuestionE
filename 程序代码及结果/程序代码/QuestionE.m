clc
clear all
close all

mapss = xlsread('Locations',1,'B2:C131');%��ȡ130���������
%% ������ս��ͼ
figure(1);
set(0,'defaultfigurecolor','w');
BattleFild = MapGenerator();
title('ս����ͼ');
%% ������ʱ�������Ѿ���ȫ��130����ľ�����Ϣ�����˶Գƾ���BattleFild����MapGenerator���أ�
%% �������������������в������ɽ���������������м���
%% ��������ڻ�����
figure(2);
BattleFild = MapGenerator();
%BattleFildΪ�Գƾ��󣬱����������ս��ͼ��ȫ���ڽӵ����
title('��һ���ڻ����Լ�������·��');
Fbuffer = BestD4FirstShort(BattleFild);
%Fbuffer�д洢�ľ��Ǳ�ѡ�еĵ�һ���ڻ�����λ
%��һ��Ϊ��תʱ�䣬�ڶ���Ϊ��λ���(F����ʵ��Ų���������������Ϊ��������(D)��������Ϊ��������
%ע�⣬��λ�����Ҫ+8ƫ�Ʋ��ܶ�ӦBattleFild�е�λ����Ϣ
%TimeTable = TimeTrace(Fbuffer,BattleFild);%��ȡ��һ�׶ε�ʱ����
%ʹ��xlswrite('D:\data',TimeTable)��������

figure(3);
BattleFild = MapGenerator();
%BattleFildΪ�Գƾ��󣬱����������ս��ͼ��ȫ���ڽӵ����
title('��һ�δ����ɺ����װ��·��');
CongestionBuffer = BestD4SecondShort(BattleFild,Fbuffer);
%CongestionBuffer�� ����ӵ��ϵ������
%                   ��һ��Ϊ��һ�ַ���ʹ�õ��ڻ���ر�ţ���ʵ���δ������
%                   �ڶ���Ϊ������Z���ţ�������ţ�
%                   ������ΪZ��ӵ��ϵ��e
%                   ������Ϊ�����ȣ������жϱ�׼��j
%                   ������Ϊʱ�����
%                   ������Ϊ��������

figure(4);
MapGenerator();
for j = 1:24
    plot([mapss(CongestionBuffer(1,j)+8,1) mapss(CongestionBuffer(2,j),1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(CongestionBuffer(2,j),2)],'-g');
end
title('��һ���ڻ�λ����װ�ص��ľ���ʾ��ͼ');

figure(5);
BattleFild = MapGenerator();
%BattleFildΪ�Գƾ��󣬱����������ս��ͼ��ȫ���ڽӵ����
[Zpoint,FEmputy] = BestD4HoldPoint(BattleFild,Fbuffer,CongestionBuffer);
title('װ��֮����δ�������·��');

figure(6);
MapGenerator();
for i = 1:size(FEmputy,2)
    plot([mapss(FEmputy(1,i)+8,1) mapss(FEmputy(2,i),1)],[mapss(FEmputy(1,i)+8,2) mapss(FEmputy(2,i),2)],'-r');
end
title('װ����Ϻ�ڶ��ַ������װ�ص����ͼ');

%���㸽���µ�Z������µ�Z��ѡ�����
CongestionLog = ExtaExchange(BattleFild,Fbuffer);

%Ѱ����Ѳ���ص㣬�Լ�����滻����
figure(7);
BattleFild = MapGenerator();
HiddingPoint = LauncherHidding(BattleFild);
Chousen = PointCStandOut(BattleFild,Fbuffer);
title('����C���ؾߵĻ����켣,�Լ����滻��C�ͷ�����');

%ѡ���滻��C��
Chousen = PointCStandOut(BattleFild,Fbuffer);

figure(8);
BattleFild = MapGenerator();
title('���ؾ���֮��ĵ��ȷ���');
FinalFbuffer = FinalFantasy(BattleFild);