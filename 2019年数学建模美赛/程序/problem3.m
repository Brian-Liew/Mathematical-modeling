

% dist=zeros(m,1);
% for i=1:m
%     
%     dist(i)=deg2km(distance(coastline(i,2),coastline(i,1),position(1,2), position(1,1)))+deg2km(distance(coastline(i,2),coastline(i,1),position(2,2), position(2,1)));
% end
load('dist.mat')
F=(dist.*(-1));
x_i=[1:m];
AA_2=ones(1,m);
aa_2=[1];
[x_22,fval_22,flag_22]=intlinprog(F,x_i,[],[],AA_2,aa_2,lb_12,ub_12);
flag_22
xx_2=find(x_22~=0);
position_3=(coastline(xx_2,:))