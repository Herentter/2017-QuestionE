function Zpoint = LeisureDegree(BattleFildDis,FEmputy,Zpoint)

%% ����˵����
%����ֵ��
%Zpoint����ά����
%       ��һ��Z����������
%       �ڶ���Ϊ�������Ŀ���ϵ��,����ϵ��Խ��˵���õ�Խ����
%       ��һ�����Ϊ�������˺�����ͨ���ԣ�ʹ��������������ڵڶ�������Ȼ��������
%FEmputy:       ���о���,���Z��F��֮������ӹ�ϵ
%               ��һ�б��F���ţ���ʵ��ţ�
%               �ڶ���Ϊ��F������Z���ţ�������ţ�
%               ������Ϊ·������
%BattleFildDis��·�����Ⱦ���
%
%���������ڼ������Z��Ŀ��ж�

%% ��������
Zpoint(2,:) = 1;
for i = 1:size(FEmputy,2)
    for j = 1:size(Zpoint,2)
        if(FEmputy(2,i) == Zpoint(1,j))
            Zpoint(2,j) = Zpoint(2,j) + 1/BattleFildDis(FEmputy(1,i)+8,FEmputy(1,j));
        end
    end
end