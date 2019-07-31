M1=14*7*5; %药物体积
M2=5*8*5;
M3=12*7*4;
num_s=5;   %待服务医院个数
num_c=3;   %集装箱个数
d_max=52.6;%集装箱最大服务范围
D=[M1+M3 2*M2+M3 M1+M2 2*M1+M2+2*M3 M1];    %各医院货物需求量
D_xy=[-65.65 18.33;
      -66.03 18.22;
      -66.07 18.44;
      -66.16 18.40;
      -66.73 18.47;]                        %医院坐标
load('coastline.mat');
[m n]=size(coastline);                          %m代表可选登陆地点数
sum=3*m;
load('dij.mat');

load('IF_can_arrive.mat')
% IF_can_arrive=zeros(num_s,m);      %储存每一个医院与所有海岸线点的可达信息，1表示不可达，0表示可达
% for i=1:num_s   
%     for j=1:m
%         if deg2km(distance(coastline(j,2),coastline(j,1),D_xy(i,2), D_xy(i,1)))>d_max
%             IF_can_arrive(i,j)=1;
%         end
%     end
% end
% dij=zeros(m,1);
% if_can_arrive=(IF_can_arrive-1)*(-1);
% for i=1:m
%     for j=1:num_s
%         dij(i)=if_can_arrive(j,i)*D(j)*deg2km(distance(coastline(i,2),coastline(i,1),D_xy(j,2), D_xy(j,1)))+dij(i);           %海岸线一个地点到所有医院的代价和
%     end
% end
C=[dij;dij;dij];
CC=ones(sum,1);
AA1=zeros(sum,1);
AA2=zeros(sum,1);
AA3=zeros(sum,1);
AA1(1:m)=CC(1:m);
AA2(1+m:2*m)=CC(1:m);
AA3(1+2*m:3*m)=CC(1:m);
AA=[AA1';AA2';AA3'];          %AA=aa 约束每个集装箱只能有一个登陆地点
aa=[1;1;1];
IF_arrive=[IF_can_arrive IF_can_arrive IF_can_arrive];
arrive=[2;2;2;2;2];           %IF_arrive<=arrive 约束每个医院至少有一个登陆地点可达

f_12=C';
ic_12=[1:sum];

lb_12=zeros(sum,1);
ub_12=ones(sum,1);

[x_12,fval_12,flag_12]=intlinprog(f_12,ic_12,IF_arrive,arrive,AA,aa,lb_12,ub_12)
xx=find(x_12~=0)
 ii=zeros(3,1);
 kk=zeros(3,1);
 for i=1:3
     X=xx(i);
     kk(i)=(X-mod(X,m))/m+1;
     X=X-(kk(i)-1)*m;
     ii(i)=X;
 end
 position=zeros(sum,2);
 for i=1:3
    position(i,:)=coastline(ii(i),:);
 end
 
 
 
 
