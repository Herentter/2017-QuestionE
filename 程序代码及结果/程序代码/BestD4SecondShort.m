function CongestionBuffer = BestD4SecondShort(BattleFild,Fbuffer)
%% ����ֱ��·������ȡλ������
mapss = xlsread('Locations',1,'B2:C131');%��ȡ130���������
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
[Zpoint,FEmputy] = FEmputyCluster(BattleFild,Fbuffer);

%% ��������Z�����������λ֮���������ϵ
%Fbuffer,�ֱ��ҵ�A,B��C��������Ӧ��F��
%FA�洢A�෢��������F�����ʵ��ţ�������
%FB�洢B�෢��������F�����ʵ��ţ�������
%FC�洢C�෢��������F�����ʵ��ţ�������
FA = [];
FB = [];
FC = [];
for i = 1:size(Fbuffer,2)
    if(Fbuffer(4,i) == 1)
        FA = [FA Fbuffer(3,i)];
    end
    if(Fbuffer(4,i) == 2)
        FB = [FB Fbuffer(3,i)];
    end
    if(Fbuffer(4,i) == 3)
        FC = [FC Fbuffer(3,i)];
    end
end
%�ֱ����ABC���෢��������������ת��
DistributPlanA = FindClosestZPoint(BattleFildDisA,FA,Zpoint);
DistributPlanB = FindClosestZPoint(BattleFildDisB,FB,Zpoint);
DistributPlanC = FindClosestZPoint(BattleFildDisC,FC,Zpoint);
%����ֵ��
%DistributPlan: ��ά����,���ÿ�����䳵����֮��ǰ��װ����Z��
%               ��һ�б��F���ţ���ʵ���,δ������
%               �ڶ���Ϊ��F������Z���ţ�������ţ�
%               �����б�Ǹ�·������ѹ��
%               ������Ϊ·������

CongestionBuffer = zeros(6,24);
VarBuffer = zeros(2,size(Zpoint,2));
VarBuffer(1,:) = Zpoint(1,:);
for i = 1:3
    [CongestionBuffer,VarBuffer] = CongestionDegree(BattleFildDisA,BattleFildDisB,BattleFildDisC,Zpoint,Fbuffer,CongestionBuffer,i,VarBuffer);
end
%���Դ��룬�������װ��·������ʾ��ͼ
% figure(6);
% MapGenerator();
% for j = 1:24
%     plot([mapss(CongestionBuffer(1,j)+8,1) mapss(CongestionBuffer(2,j),1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(CongestionBuffer(2,j),2)],'-g');
% end

for j = 1:24
    if(CongestionBuffer(6,j) == 1)%A�೵
        i = CongestionBuffer(2,j);%iΪĿ�ĵص�ַ��������ַ������ƫ�ƣ�
        count = 0;
        k = BattleFildPathA(CongestionBuffer(1,j)+8,i);%KΪ��һ����
        plot( [mapss(CongestionBuffer(1,j)+8,1) mapss(k,1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(k,2)],'-r');
        while(k~= i)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPathA(k,i),1)],[mapss(k,2) mapss(BattleFildPathA(k,i),2)],'-r');
            k = BattleFildPathA(k,i);
        end
    end
    if(CongestionBuffer(6,j) == 2)%B�೵
        i = CongestionBuffer(2,j);%iΪĿ�ĵص�ַ��������ַ������ƫ�ƣ�
        count = 0;
        k = BattleFildPathB(CongestionBuffer(1,j)+8,i);%KΪ��һ����
        plot( [mapss(CongestionBuffer(1,j)+8,1) mapss(k,1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(k,2)],'-r');
        while(k~= i)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPathB(k,i),1)],[mapss(k,2) mapss(BattleFildPathB(k,i),2)],'-r');
            k = BattleFildPathB(k,i);
        end
    end
    if(CongestionBuffer(6,j) == 3)%C�೵
        i = CongestionBuffer(2,j);%iΪĿ�ĵص�ַ��������ַ������ƫ�ƣ�
        count = 0;
        k = BattleFildPathC(CongestionBuffer(1,j)+8,i);%KΪ��һ����
        plot( [mapss(CongestionBuffer(1,j)+8,1) mapss(k,1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(k,2)],'-r');
        while(k~= i)
            count = count + 1;
            plot( [mapss(k,1) mapss(BattleFildPathC(k,i),1)],[mapss(k,2) mapss(BattleFildPathC(k,i),2)],'-r');
            k = BattleFildPathC(k,i);
        end
    end
end
%     plot([mapss(CongestionBuffer(1,j)+8,1) mapss(CongestionBuffer(2,j),1)],[mapss(CongestionBuffer(1,j)+8,2) mapss(CongestionBuffer(2,j),2)],'-g');
%         i = Fbuffer(2,t);
%         count = 0;
%         k = BattleFildPath(1,i+8);
%         plot( [mapss(1,1) mapss(k,1)],[mapss(1,2) mapss(k,2)],'-g');
%         while(k~= i+8)
%             count = count + 1;
%             plot( [mapss(k,1) mapss(BattleFildPath(k,i+8),1)],[mapss(k,2) mapss(BattleFildPath(k,i+8),2)],'-g');
%             k = BattleFildPath(k,i+8);
%         end


