function HiddingPoint = LauncherHidding(BattleFild)

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
%��ֹ��ʱ��TimeFild4A��TimeFild4B,TimeFild4C��
%�ֱ�洢��ABC���ַ��䳵�ڸ��ι�·�ϻ��������ʱ��

%% ����C�ͷ��䳵��Ǩ��·��
[ BattleFildDis , BattleFildPath ] = Floyd(TimeFild4C);

%J04,J06,J08,J13,J14,J15��ƫ����68
JBuffer = [4 6 8 13 14 15];
JBuffer = JBuffer + 68;%����ʵ��������Ϊ��������

pointBuffer = zeros(6,60);

for i = 1:6
    pointBuffer(i,:) = BattleFildDis(JBuffer(i),[9:68]);
end

HiddingPoint = zeros(2,3);
Cover = ones(6,60);
Cover = Cover*Inf;
Cover(:,39) = 0;
Cover(:,6) = 0;
Cover(:,11) = 0;
Cover(:,4) = 0;
Cover(:,27) = 0;
Cover(:,28) = 0;
Cover(:,48) = 0;
Cover(:,36) = 0;
pointBuffer = pointBuffer+Cover;
for i = 1:3
    [a b] = min(pointBuffer);
    [a2 b2] = min(a);
    HiddingPoint(1,i) = b(b2);
    HiddingPoint(2,i) = b2;
    pointBuffer(:,b2) = Inf;
    if(i>1 && HiddingPoint(1,1) == HiddingPoint(1,2))
        pointBuffer(HiddingPoint(1,1),:) = Inf;
    end
end
%��С��λ�� (b(b2),b2)

%���ƶ����C���ؾߵĻ����켣
for i = 1:3
    Guidor(BattleFildPath,JBuffer(HiddingPoint(1,i)),HiddingPoint(2,i)+8);
    %[JBuffer(HiddingPoint(1,i))-68,HiddingPoint(2,i)]
end

BattleFildPath(2,70)=70;
 GuidorG(BattleFildPath,2,80);
 GuidorG(BattleFildPath,80,82);
 GuidorG(BattleFildPath,2,70);
 GuidorG(BattleFildPath,70,72);

