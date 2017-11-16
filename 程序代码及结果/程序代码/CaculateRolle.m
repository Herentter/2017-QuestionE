function CaculateRolle(x,a,b,col)
%x 半径
%a 圆心X坐标
%y 圆心Y坐标
rectangle('Position',[a-x,b-x,2*x,2*x],'Curvature',[1,1],'edgecolor',col)