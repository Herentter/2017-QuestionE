function Conjection = CongectionFunction(CountF,VarS,Emputy)

%拥塞系数方程
Conjection = (CountF + 1)*(CountF + 1)/(sqrt(VarS + 1)*Emputy);
%方程中的“+1”是为了防止出现分子或分母为0的情况
%Emputy为Z点空闲度，这个数值在生成时已经做了“+1”处理，此处不必再次处理