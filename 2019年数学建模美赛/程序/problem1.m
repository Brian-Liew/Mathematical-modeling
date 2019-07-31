M1=14*7*5; %ҩ�����
M2=5*8*5;
M3=12*7*4;
num_s=5;   %������ҽԺ����
num_c=3;   %��װ�����
d_max=52.6;%��װ��������Χ
D=[M1+M3 2*M2+M3 M1+M2 2*M1+M2+2*M3 M1];    %��ҽԺ����������
D_xy=[-65.65 18.33;
      -66.03 18.22;
      -66.07 18.44;
      -66.16 18.40;
      -66.73 18.67;]                        %ҽԺ����
load('coastline.mat');
[m n]=size(coastline);                          %m�����ѡ��½�ص���
sum_k=m*num_s;                                  %һ����װ������Ӧ�Ĳ�������
SUM=num_c*sum_k;                                %���д�����������
dij=zeros(num_s,m);                             %�����߸��㵽ҽԺ����
A=zeros(num_s,m);                               %�����������˻�
for i=1:num_s
    dij(i,:) = deg2km(distance(coastline(:,2),coastline(:,1),D_xy(i,2), D_xy(i,1)));
    A(i,:)=D(i).*dij(i,:);
end
A=A';
B=reshape(A,[],1);
d_ij=reshape(dij',[],1);
d_ij=[d_ij;d_ij;d_ij];
C=[B;B;B];                                      %���Է����������������
A_1j=zeros(SUM,1);
CC=ones(SUM,1);
%*************************ÿһ��ҽԺֻ��һ��������·*****************
for i=1:num_c
    A_1j(1+(i-1)*sum_k:1+(i-1)*sum_k+m,1)=CC(1+(i-1)*sum_k:1+(i-1)*sum_k+m,1);
end
A_2j=zeros(SUM,1);
for i=1:num_c
    A_2j(1+m+(i-1)*sum_k:m+(i-1)*sum_k+m,1)=CC(1+m+(i-1)*sum_k:m+(i-1)*sum_k+m,1);
end
A_3j=zeros(SUM,1);
for i=1:num_c
    A_3j(1+2*m+(i-1)*sum_k:2*m+(i-1)*sum_k+m,1)=CC(1+2*m+(i-1)*sum_k:2*m+(i-1)*sum_k+m,1);
end
A_4j=zeros(SUM,1);
for i=1:num_c
    A_4j(1+3*m+(i-1)*sum_k:3*m+(i-1)*sum_k+m,1)=CC(1+3*m+(i-1)*sum_k:3*m+(i-1)*sum_k+m,1);
end
A_5j=zeros(SUM,1);
for i=1:num_c
    A_5j(1+4*m+(i-1)*sum_k:4*m+(i-1)*sum_k+m,1)=CC(1+4*m+(i-1)*sum_k:4*m+(i-1)*sum_k+m,1);
end
d_up=d_max./d_ij;
%*************************ÿһ����װ��ֻ��һ��ͣ���ص�************************
nn=num_s*num_c;
A_6j1=zeros(SUM,nn);
A_6j2=zeros(SUM,num_c);
bb=ones(nn,1);
for i=1:nn
     A_6j1(m*(i-1)+1:m*i,i)=CC(m*(i-1)+1:m*i);
end
for i=1:num_c
    A_6j2(sum_k*(i-1)+1:sum_k*i,i)=CC(sum_k*(i-1)+1:sum_k*i);
end



f_12=C';
ic_12=[1:SUM];
A_12=[-A_1j';-A_2j';-A_3j';-A_4j';-A_5j'];
b_12=[-1;-1;-1;-1;-1];
A_13=[A_6j1';A_6j2'];
b_13=[bb;5;5;5];


lb_12=zeros(SUM,1);
ub_12=ones(SUM,1);
for i=1:SUM
    if ub_12(i)>d_up(i)
        ub_12(i)=d_up(i);
    end
end
[x_12,fval_12,flag_12]=intlinprog(f_12,ic_12,A_12,b_12,A_13,b_13,lb_12,ub_12);

 xx=find(x_12~=0)
 [num_re nnn] =size(xx);
 ii=zeros(num_re,1);
 jj=zeros(num_re,1);
 kk=zeros(num_re,1);
 for i=1:num_re
     X=xx(i);
    kk(i)=(X-mod(X,sum_k))/sum_k+1;
     X=X-(kk(i)-1)*sum_k;
     jj(i)=(X-mod(X,m))/m+1;
     X=X-(jj(i)-1)*m;
     ii(i)=X;
 end
% position=zeros

