function Dis = ZJroadDistance(ZJroad,J,Z)

Dis = zeros(6,62);
for i = 1:6
    for j = 1:62
        if(ZJroad(i,j) ~= 0)
            len2 = (Z(i,1)-J(j,1))*(Z(i,1)-J(j,1))+(Z(i,2)-J(j,2))*(Z(i,2)-J(j,2));
            Dis(i,j) = sqrt(len2);
        end
    end
end