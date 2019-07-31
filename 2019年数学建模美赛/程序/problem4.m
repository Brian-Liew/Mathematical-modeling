clear all;close all;clc;
M=50;                             %??????
data=rand(M,2);
N=5;                               %??????
 
start_point=[0.5 0.5];
[m,n]=size(data);                  %m ???
pattern=zeros(m,n+1);
center=zeros(N,n);                 %???????
pattern(:,1:n)=data(:,:);
for x=1:N
    center(x,:)=(data( randi(M),:)+start_point)./2; %???????????
end
 
while 1
distence=zeros(1,N);
num=zeros(1,N);
new_center=zeros(N,n);
 
for x=1:m
    for y=1:N
    distence(y)=norm(data(x,:)-center(y,:));%?????????
    end
    [~, temp]=min(distence);%??????
    pattern(x,n+1)=temp;         
end
k=0;
for y=1:N
    for x=1:m
        if pattern(x,n+1)==y
           new_center(y,:)=new_center(y,:)+pattern(x,1:n);
           num(y)=num(y)+1;
        end
    end
    new_center(y,:)=new_center(y,:)/num(y);
    if norm(new_center(y,:)-center(y,:))<0.1
        k=k+1;
    end
end

if k==N
     break;
else
     center=new_center;
end
end
[m, n]=size(pattern);
%??????????
figure;
hold on;
for i=1:m
    if pattern(i,n)==1 
         plot(pattern(i,1),pattern(i,2),'r*');
         plot(center(1,1),center(1,2),'ko');
    elseif pattern(i,n)==2
         plot(pattern(i,1),pattern(i,2),'g*');
         plot(center(2,1),center(2,2),'ko');
    elseif pattern(i,n)==3
         plot(pattern(i,1),pattern(i,2),'b*');
         plot(center(3,1),center(3,2),'ko');
    elseif pattern(i,n)==4
         plot(pattern(i,1),pattern(i,2),'y*');
         plot(center(4,1),center(4,2),'ko');
    else
         plot(pattern(i,1),pattern(i,2),'m*');
         plot(center(4,1),center(4,2),'ko');
    end
    hold on;
end
plot(start_point(1),start_point(2),'ms','MarkerEdgeColor','k','MarkerFaceColor','k')
 
grid on;
X=cell(N,3);
dest_poi=cell(N,1);
for i=1:N
    [mm,~]=size(find(pattern(:,3)==i));
    Clist=pattern(find(pattern(:,3)==i),1:2);               %????????
 
    Clist=[Clist;start_point];                              %????????
    dest_poi(i)={Clist};
    dist=dist_p2p(Clist,mm+1);                                %???????????
    [x,ymean,ymax]=TSP(dist,Clist);
    X(i,1)={x};                                    %????????????????
    X(i,2)={ymean};
    X(i,3)={ymax};
end
 
for i=1:m
    if pattern(i,n)==1 
         plot(pattern(i,1),pattern(i,2),'r*');
         plot(center(1,1),center(1,2),'ko');
    elseif pattern(i,n)==2
         plot(pattern(i,1),pattern(i,2),'g*');
         plot(center(2,1),center(2,2),'ko');
    elseif pattern(i,n)==3
         plot(pattern(i,1),pattern(i,2),'b*');
         plot(center(3,1),center(3,2),'ko');
    elseif pattern(i,n)==4
         plot(pattern(i,1),pattern(i,2),'y*');
         plot(center(4,1),center(4,2),'ko');
    else
         plot(pattern(i,1),pattern(i,2),'m*');
         plot(center(4,1),center(4,2),'ko');
    end
    hold on;
    axis([0,1,0,1]);
end
plot(start_point(1),start_point(2),'ms','MarkerEdgeColor','k','MarkerFaceColor','k')
hold on;
for i=1:N
    dest_list=cell2mat(X(i,1));
    [~,dest_num]=size(dest_list);
    dest_position=cell2mat(dest_poi(i));
    for j=1:dest_num-1
        hold on
        plot([dest_position(dest_list(j),1),dest_position(dest_list(j+1),1)],[dest_position(dest_list(j),2),dest_position(dest_list(j+1),2)],'-','LineWidth',1);
        hold on
    end
    plot([dest_position(dest_list(1),1),dest_position(dest_list(dest_num),1)],[dest_position(dest_list(1),2),dest_position(dest_list(dest_num),2)],'-','LineWidth',1);
    hold on
end
for i=1:N
    y_mean=cell2mat(X(i,2));
    y_max=cell2mat(X(i,2));
    figure(i+1)
    plot(ymax,'r'); hold on;
    plot(ymean,'b');grid;
    text=['???? ',num2str(i)];
    title(text);
    legend('???','???');
end
 
 
 
 
 
 
 
 


