function table = TimeGuidor(Path,TimeDis,Begin,End,delay)
%����һ����������ʱ����λ�ñ�Ž������
%��ͼ����
%������㣬�յ��Path���󣬻������·��
%�����յ㶼���������
count = 1;
next = Path(Begin,End);
table(count) = TimeDis(Begin,next) + delay;
table(count + 1) = next;
while(next ~= End)
    count = count + 2;
    k = next;
    next = Path(next,End);
    table(count) = TimeDis(k,next) + table(count-2);
    table(count + 1) = next;
end
for i = 1:2:size(table,2)
    if(table(i + 1)<68)%ֻ����J����Ϣ
        table(i) = [];
        table(i) = [];
    end
end
