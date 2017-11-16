function ZDistributPlan = FindClosestZPoint(BattleFildDis,Fbuffer,Zpoint)
%% ����˵����
%����ֵ��
%Zpoint����ά����
%       ��һ��Z����������
%       �ڶ���Ϊ����ϵ��,����ϵ��Խ��˵��ѹ��Խ��
%       ��һ�����Ϊ�������˺�����ͨ���ԣ�ʹ��������������ڵڶ�������Ȼ��������
%Fbuffer:һά����Ҫ����������ϵ��F�㣬����F����ʵ��ţ�������
%BattleFildDis����F���ؾ������Ӧ��ʱ�䳤�Ⱦ���

%����ֵ��
%ZDistributPlan:���о���,���ÿ�����䳵����֮��ǰ��װ����Z��
%               ��һ�б��F���ţ���ʵ��ţ�
%               �ڶ���Ϊ��F������Z���ţ�������ţ�
%               �����б�Ǹ�·������ѹ��
%               ������Ϊ·������

%�㷨˼�룺
%����㷨����������ϵ����ֻ���ݾ���͸���ϵ���򵥼��������ϵ
%���㷨���ڵ������Ǽ����㷨���룬��ǿ����ɶ���

Fadjust = 8;%F��ƫ����������������������Ϊ�˷������

%% ���ݲ�ͬ�ͺŵ��������ٶȣ���������Z��֮��Ĵ�����ϵ
%�ٶ�BattleFild,BattleFildPath�Ѿ���F���ؾ߶�Ӧ��·����ʱ����Ϣ
%������迼�ǲ�ͬ�����ٶȲ���
%ZDistributPlan��������
%��һ�д洢ʼ��F���ţ���ʵ��ţ���������
%�ڶ��д洢Z���ţ�BattleField������ţ�
%�����д洢���ض�

Fbuffer = Fbuffer + Fadjust;%��Fbufferͳһ����Ϊ�������
Zbuffer = zeros(3,size(Fbuffer,2));
%��һ�д洢F����ʵ
%�ڶ��д洢Z���������
%�����д洢����ѹ����E = S*P)
%������Ϊ·������
for i = 1:size(Fbuffer,2)%iΪ��i��F
    count = 0;
    for j = Zpoint(1,1:size(Zpoint,2))%jΪZ���������
        count = count + 1;
        %���㸺�ض�
        e = BattleFildDis(Fbuffer(i),j)*Zpoint(2,count);
        if(Zbuffer(3,i) == 0 || Zbuffer(3,i)>e)
            Zbuffer(3,i) = e;%����F��(��ʵ���)����j��Z�ĸ��ض�
            Zbuffer(2,i) = j;
            Zbuffer(1,i) = Fbuffer(i)-Fadjust;%��������ű�Ϊ��ʵ���
            Zbuffer(4,i) = BattleFildDis(Fbuffer(i),j);
        end
    end
end

ZDistributPlan = Zbuffer;
