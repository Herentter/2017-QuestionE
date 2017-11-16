function [Zpoint,FEmputy] = FEmputyCluster(BattleFild,Fbuffer)

%ʹ��ģ���˻��㷨�Ϳ��о�����ԣ���������λ��Z��֮��Ķ�Ӧ��ϵ

T0 = 120;%��ʼ�¶�
q = 0.8;%��������

Zpoint = ones(2,6);
for i =1:6
    Zpoint(1,i) = i+2;
end
[BattleFildDis,BattleFildPath ]  = Floyd(BattleFild);

while T0>sum(Zpoint(2,:))%ʹ��ģ���˻��㷨���о����Ż�
    FEmputy = EmputyFCluster(BattleFildDis,Fbuffer,Zpoint);%ÿ�μ�����ж�֮�󣬶����ڻ�λ�����·���
    Zpoint = LeisureDegree(BattleFildDis,FEmputy,Zpoint);%��������������ж�
    T0 = T0 * q;
end

%����Ϊ������䣬��������˻���
% mapss = xlsread('Locations',1,'B2:C131');%��ȡ130���������
% MapGenerator();
% for i = 1:size(FEmputy,2)
%     plot([mapss(FEmputy(1,i)+8,1) mapss(FEmputy(2,i),1)],[mapss(FEmputy(1,i)+8,2) mapss(FEmputy(2,i),2)],'-g');
% end