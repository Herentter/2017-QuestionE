function Conjection = CongectionFunction(CountF,VarS,Emputy)

%ӵ��ϵ������
Conjection = (CountF + 1)*(CountF + 1)/(sqrt(VarS + 1)*Emputy);
%�����еġ�+1����Ϊ�˷�ֹ���ַ��ӻ��ĸΪ0�����
%EmputyΪZ����жȣ������ֵ������ʱ�Ѿ����ˡ�+1�������˴������ٴδ���