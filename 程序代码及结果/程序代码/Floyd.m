function [ D , path ] = Floyd(A)
%D为最短路径距离矩阵，path为最短路径的下一跳地址，A为原始路径距离矩阵
%假定A为上三角方阵，下三角全0，且不可达点距离全部标记为0
%除对角线外，其余所有距离为0的点均认为不可达
n = size(A,1);    %确定路径图的大小，n为算法需要运行的次数
%初始化D和path值
% %% 将上三角矩阵转换为对称矩阵
% for i = 1:n
%     for j = i:n
%         A(j,i)=A(i,j);
%     end
% end
% %原计划在算法内部将上三角转化为对称矩阵，但这会让算法失去通用性，因此放弃
%除对角线外，其余长度为0的点视为不可达
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
%做n次迭代，更新D和path
for k = 1:n
    for i = 1:n
        for j = 1:n
            if D(i,k) + D(k,j) < D(i,j);    %判定经过节点k是否能优化路径
                D(i,j) = D(i,k) + D(k,j);
                path(i,j) = path(i,k);
            end
        end
    end
end
end