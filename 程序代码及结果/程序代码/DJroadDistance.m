function Dis = DJroadDistance(DJ,D,J)

Dis = zeros(2,62);
for i = 1:2
    for j = 1:62
        if(DJ(i,j) ~= 0)
            len2 = (D(i,1)-J(j,1))*(D(i,1)-J(j,1))+(D(i,2)-J(j,2))*(D(i,2)-J(j,2));
            Dis(i,j) = sqrt(len2);
        end
    end
end