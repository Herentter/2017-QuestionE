function Dis = FJroadDistance(FJlink,F,J)

Dis = zeros(60,1);
for i = 1:60
    len = (F(i,1)-J(FJlink(i,1),1))*(F(i,1)-J(FJlink(i,1),1))+(F(i,2)-J(FJlink(i,1),2))*(F(i,2)-J(FJlink(i,1),2));
    Dis(i,1) = sqrt(len);
end