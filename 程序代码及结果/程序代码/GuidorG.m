function Guidor(Path,Begin,End)
%��ͼ����
%������㣬�յ��Path���󣬻������·��
%�����յ㶼���������
mapss = xlsread('Locations',1,'B2:C131');%��ȡ130���������
next = Path(Begin,End);
plot([mapss(Begin,1) mapss(next,1)],[mapss(Begin,2) mapss(next,2)],'-g');
while(next ~= End)
    k = next;
    next = Path(next,End);
    plot([mapss(k,1) mapss(next,1)],[mapss(k,2) mapss(next,2)],'-g');
end