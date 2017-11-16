function CongestionLog = ExtaExchange(BattleFild,Fbuffer)
%% ����ֱ��·������ȡλ������
TimeFild4A = BattleFild/45;%����A�෢�䳵��ͨ��·���ٶ�
for i =1:20%������ٹ�·���ٶ�
    TimeFild4A(i+68,i+69) = BattleFild(i+68,i+69)/70;
    TimeFild4A(i+69,i+68) = TimeFild4A(i+68,i+69);
end
TimeFild4B = BattleFild/35;%����B�෢�䳵��ͨ��·���ٶ�
for i =1:20%������ٹ�·���ٶ�
    TimeFild4B(i+68,i+69) = BattleFild(i+68,i+69)/60;
    TimeFild4B(i+69,i+68) = TimeFild4B(i+68,i+69);
end
TimeFild4C = BattleFild/30;%����C�෢�䳵��ͨ��·���ٶ�
for i =1:20%������ٹ�·���ٶ�
    TimeFild4C(i+68,i+69) = BattleFild(i+68,i+69)/50;
    TimeFild4C(i+69,i+68) = TimeFild4C(i+68,i+69);
end
%% �������·��������ʱ��
[BattleFildDisC,BattleFildPathC ]  = Floyd(TimeFild4C);
[BattleFildDisB,BattleFildPathB ]  = Floyd(TimeFild4B);
[BattleFildDisA,BattleFildPathA ]  = Floyd(TimeFild4A);

%% ��ʼ��Z����Ϣ
%Zpoint = ones(2,6);%��ʼ����ϵ����Ϊ1
%           ��һ�м�¼Z����������
%           �ڶ��м�¼Z��Ŀ���ϵ��
%FEmputy:   ��һ�м�¼�յ�F���ţ���ʵ��ţ���������
%           �ڶ��м�¼�õ���������Z���ţ�������ţ�
%           ������Ϊ·�����д�����
%����ֵ��
%DistributPlan: ��ά����,���ÿ�����䳵����֮��ǰ��װ����Z��
%               ��һ�б��F���ţ���ʵ���,δ������
%               �ڶ���Ϊ��F������Z���ţ�������ţ�
%               �����б�Ǹ�·������ѹ��
%               ������Ϊ·������

Zpoint = ones(2,8);
%�ع�Zpoint�е���Ϣ�������µ�Z��
for i = 1:6
    Zpoint(1,i) = i+2;
end

Jstack = [25 34 36 49 42];
Jstack = Jstack + 68;%����ʵλ��ת��Ϊ����λ��

CongestionLog = zeros(5);

for t = 1:4
    for j = t+1:5
        Zpoint(1,7) = Jstack(t);
        Zpoint(1,8) = Jstack(j);
        CongestionBuffer = zeros(6,24);
        VarBuffer = zeros(2,size(Zpoint,2));
        VarBuffer(1,:) = Zpoint(1,:);
        for i = 1:3
            [CongestionBuffer,VarBuffer] = CongestionDegree(BattleFildDisA,BattleFildDisB,BattleFildDisC,Zpoint,Fbuffer,CongestionBuffer,i,VarBuffer);
        end
        CongestionLog(t,j) = sum(CongestionBuffer(3,:));
    end
end

CongestionLog
%���Դ��룬�������װ��·������ʾ��ͼ
% figure(5);
% MapGenerator();
% for j = 1:24
%     plot([mapss(CongestionBuffer(1,j)+8,1) mapss(CongestionBuffer(2,j),1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(CongestionBuffer(2,j),2)],'-r');
% end