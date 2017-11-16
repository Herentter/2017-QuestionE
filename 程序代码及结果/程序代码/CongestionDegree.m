function [CongestionBuffer,VarBuffer] = CongestionDegree(BattleFildDisA,BattleFildDisB,BattleFildDisC,Zpoint,Fbuffer,Congestiontt,squareLimit,VarBuffer)
%% ����˵��
%���������
%BattleFildDisA
%BattleFildDisB
%BattleFildDisC
%           ��ǰ���ʱ�䳤�Ⱦ��󣬳ߴ�130*130
%           �ֱ��ӦA,B��C�෢����
%Zpoint��Z������2�о���
%       ��һ�б�ʾZ���������
%       �ڶ��б�ʾZ����ж�
%Fbuffer��F�����
%��һ��Ϊ��תʱ�䣬�ڶ���Ϊ��λ���(F����ʵ��Ų���������������Ϊ��������(D)��������Ϊ��������
%������Ҫ���õڶ��к͵���������
%Congestiontt��       ����ӵ��ϵ������
%                   ��һ��Ϊ��һ�ַ���ʹ�õ��ڻ���ر�ţ���ʵ���δ������
%                   �ڶ���Ϊ������Z���ţ�������ţ�
%                   ������ΪZ��ӵ��ϵ��
%                   ������Ϊ�����ȣ������жϱ�׼��*
%                   ������Ϊʱ�����             *
%                   ������Ϊ��������
%VarBuffer: ���о���
%           ��һ��ΪZ���������
%           �ڶ��ж�Ӧ��ķ����ֵΪ0,����ֵΪ1��

%���������
%CongestionBuffer�� ����ӵ��ϵ������
%                   ��һ��Ϊ��һ�ַ���ʹ�õ��ڻ���ر�ţ���ʵ���δ������     *
%                   �ڶ���Ϊ������Z���ţ�������ţ�
%                   ������ΪZ��ӵ��ϵ��
%                   ������Ϊ�����ȣ������жϱ�׼��
%                   ������Ϊʱ�����
%                   ������Ϊ��������                                        *

%% ����ӵ��ϵ��E�ʹ�����T
CongestionBuffer = Congestiontt;
%��һ�м�¼ÿ��Z���
for i = 1:24
    CongestionBuffer(1,i) = Fbuffer(2,i);%ѡȡ�ڻ���ر�ţ�F����ʵ��ţ�δ������
    CongestionBuffer(6,i) = Fbuffer(4,i);%д���������
    if(Fbuffer(4,i) == 1)%A�����
        for j = 1:size(Zpoint,2)%����Zpoint(1,j)��Z���i����λ�Ĵ�����
            E = Zpoint(2,j);%��ȡ���ж�
%             Var = Congestiontt(7,i);%��ȡ���뷽���ֵΪ0��
            Var = VarBuffer(2,j);%����ֱ��ʹ��j������ΪVarBuffer��Zpoint��˳����ȫ��ͬ
            count = 0;%����ע�����
            for k = 1:size(Congestiontt,2)
                if(Congestiontt(2,k) == Zpoint(1,j))
                    count = count +1;
                end
            end
            Conjection = CongectionFunction(count,Var,E);%����ӵ��ϵ��
            Dist = BattleFildDisA(Zpoint(1,j),Fbuffer(2,i)+8);%��ȡ���룬׼�����������
            T=1/(Conjection*Conjection*sqrt(Dist));%������
            if(CongestionBuffer(4,i) == 0 || CongestionBuffer(4,i)<T)
                CongestionBuffer(4,i)=T;%�޸Ĵ�����
                CongestionBuffer(2,i) = Zpoint(1,j);%������Z���ţ�������ţ�
                CongestionBuffer(3,i) = Conjection;%Z��ӵ��ϵ��
                CongestionBuffer(5,i) = Dist;%ʱ�����
            end
        end
    end
    if(Fbuffer(4,i) == 2)%B�����
        for j = 1:size(Zpoint,2)%����Zpoint(1,j)��Z���i����λ�Ĵ�����
            E = Zpoint(2,j);%��ȡ���ж�
%             Var = Congestiontt(7,i);%��ȡ���뷽���ֵΪ0��
            Var = VarBuffer(2,j);%����ֱ��ʹ��j������ΪVarBuffer��Zpoint��˳����ȫ��ͬ
            count = 0;%����ע�����
            for k = 1:size(Congestiontt,2)
                if(Congestiontt(2,k) == Zpoint(1,j))
                    count = count +1;
                end
            end
            Conjection = CongectionFunction(count,Var,E);%����ӵ��ϵ��
            Dist = BattleFildDisB(Zpoint(1,j),Fbuffer(2,i)+8);%��ȡ���룬׼�����������
            T=1/(Conjection*Conjection*sqrt(Dist));%������
            if(CongestionBuffer(4,i) == 0 || CongestionBuffer(4,i)<T)
                CongestionBuffer(4,i)=T;%�޸Ĵ�����
                CongestionBuffer(2,i) = Zpoint(1,j);%������Z���ţ�������ţ�
                CongestionBuffer(3,i) = Conjection;%Z��ӵ��ϵ��
                CongestionBuffer(5,i) = Dist;%ʱ�����
            end
        end
    end
    if(Fbuffer(4,i) == 3)%C�����
        for j = 1:size(Zpoint,2)%����Zpoint(1,j)��Z���i����λ�Ĵ�����
            E = Zpoint(2,j);%��ȡ���ж�
%             Var = Congestiontt(7,i);%��ȡ���뷽���ֵΪ0��
            Var = VarBuffer(2,j);%����ֱ��ʹ��j������ΪVarBuffer��Zpoint��˳����ȫ��ͬ
            count = 0;%����ע�����
            for k = 1:size(Congestiontt,2)
                if(Congestiontt(2,k) == Zpoint(1,j))
                    count = count +1;
                end
            end
            Conjection = CongectionFunction(count,Var,E);%����ӵ��ϵ��
            Dist = BattleFildDisC(Zpoint(1,j),Fbuffer(2,i)+8);%��ȡ���룬׼�����������
            T=1/(Conjection*Conjection*sqrt(Dist));%������
            if(CongestionBuffer(4,i) == 0 || CongestionBuffer(4,i)<T)
                CongestionBuffer(4,i)=T;%�޸Ĵ�����
                CongestionBuffer(2,i) = Zpoint(1,j);%������Z���ţ�������ţ�
                CongestionBuffer(3,i) = Conjection;%Z��ӵ��ϵ��
                CongestionBuffer(5,i) = Dist;%ʱ�����
            end
        end
    end
end
%% �����µ�������ϵ���¼������Z��ķ���
%�µĴ�����ϵ�����CongestionBuffer��
ZBuffer = zeros(4,size(Zpoint,2));%�洢����Z�����ʱ�䳤��
%��һ��ΪZ���������
%�ڶ���Ϊʱ�䳤�Ⱥ�
%������Ϊ���Z��������F�����
%������Ϊƽ�����
ZBuffer(1,:) = Zpoint(1,:);
for i = 1:24
    for j = 1:size(Zpoint,2)
        if(CongestionBuffer(2,i) == ZBuffer(1,j))
            ZBuffer(2,j) = ZBuffer(2,j) + CongestionBuffer(5,i);
            ZBuffer(3,j) = ZBuffer(3,j) + 1;
        end
    end
end
for i = 1:24
    for j = 1:size(Zpoint,2)
        if(CongestionBuffer(2,i) == ZBuffer(1,j))
            ZBuffer(4,j) = ZBuffer(4,j) + (ZBuffer(2,j)/ZBuffer(3,j)-CongestionBuffer(5,i))*(ZBuffer(2,j)/ZBuffer(3,j)-CongestionBuffer(5,i));
        end
    end
end
for i = 1:size(VarBuffer,2)
    for j = 1:size(Zpoint,2)
        if(VarBuffer(1,i) == ZBuffer(1,j) && ZBuffer(3,j) ~= 0)
            VarBuffer(2,i) = ZBuffer(4,j)/ZBuffer(3,j);
        end
        if(VarBuffer(1,i) == ZBuffer(1,j) && ZBuffer(3,j) == 0)
            VarBuffer(2,i) = 0.5;
        end
    end
end
