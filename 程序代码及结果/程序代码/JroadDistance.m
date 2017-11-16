function Dis = JroadDistance(Jroad,J)

Dis = zeros(62);
for i = 1:62
    for j = 1:62
        if(Jroad(i,j) ~= 0)
            len2 = (J(i,1)-J(j,1))*(J(i,1)-J(j,1))+(J(i,2)-J(j,2))*(J(i,2)-J(j,2));
            Dis(i,j) = sqrt(len2);
        end
    end
end