function [ D , path ] = Floyd(A)
%DΪ���·���������pathΪ���·������һ����ַ��AΪԭʼ·���������
%�ٶ�AΪ�����Ƿ���������ȫ0���Ҳ��ɴ�����ȫ�����Ϊ0
%���Խ����⣬�������о���Ϊ0�ĵ����Ϊ���ɴ�
n = size(A,1);    %ȷ��·��ͼ�Ĵ�С��nΪ�㷨��Ҫ���еĴ���
%��ʼ��D��pathֵ
% %% �������Ǿ���ת��Ϊ�Գƾ���
% for i = 1:n
%     for j = i:n
%         A(j,i)=A(i,j);
%     end
% end
% %ԭ�ƻ����㷨�ڲ���������ת��Ϊ�Գƾ��󣬵�������㷨ʧȥͨ���ԣ���˷���
%���Խ����⣬���೤��Ϊ0�ĵ���Ϊ���ɴ�
for i = 1:n
    for j = 1:n
        if(A(i,j) == 0 && i~=j)
            A(i,j) = Inf;
        end
    end
end
D=A;
path=zeros(n,n);
for i = 1:n
    for j = 1:n
        if D(i,j) ~= inf;
            path(i,j) = j;
        end
    end
end
%��n�ε���������D��path
for k = 1:n
    for i = 1:n
        for j = 1:n
            if D(i,k) + D(k,j) < D(i,j);    %�ж������ڵ�k�Ƿ����Ż�·��
                D(i,j) = D(i,k) + D(k,j);
                path(i,j) = path(i,k);
            end
        end
    end
end
end