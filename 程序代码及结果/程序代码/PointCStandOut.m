function Chousen = PointCStandOut(BattleFild,Fbuffer)
%% ����˵��
%�������ݣ�
%BattleFild ��ͼ����
%Fbuffer    ��һ���ڻ���Ϣ
%
%������ݣ�
%Chousen    1*3���󣬱�ѡ�е�����C����Fbuffer�е�λ��
%% ��ʼ����
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
%�������·��������ʱ��
[BattleFildDisC,BattleFildPathC ]  = Floyd(TimeFild4C);
[BattleFildDisB,BattleFildPathB ]  = Floyd(TimeFild4B);
[BattleFildDisA,BattleFildPathA ]  = Floyd(TimeFild4A);
[Zpoint,FEmputy] = FEmputyCluster(BattleFild,Fbuffer);

Fmid = Fbuffer;
Log = zeros(1,12);%��¼ÿһ�ֵ��������ܺ�
for k = 1:12
    Fbuffer = Fmid;
    Fbuffer(2,k) = 0;
    %�����������C����Ϣ���¼�����������]
    CongestionBuffer = zeros(6,24);
    VarBuffer = zeros(2,size(Zpoint,2));
    VarBuffer(1,:) = Zpoint(1,:);
    for i = 1:3
        [CongestionBuffer,VarBuffer] = CongestionDegree(BattleFildDisA,BattleFildDisB,BattleFildDisC,Zpoint,Fbuffer,CongestionBuffer,i,VarBuffer);
    end
    for j = 1:24
        if(CongestionBuffer(4,j)<Inf)
            Log(k) = Log(k) + CongestionBuffer(4,j);
        end
    end
end
Chousen = zeros(1,3);
Fbuffer = Fmid;
for i = 1:3%�ҳ��������ֵ
    [a,Chousen(i)] = max(Log);
    Log(Chousen(i)) = 0;
    CaculateRolle(8,mapss(Fbuffer(2,Chousen(i))+8,1),mapss(Fbuffer(2,Chousen(i))+8,2),'b');
end

%���Ʊ�ѡ�еĵ�
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