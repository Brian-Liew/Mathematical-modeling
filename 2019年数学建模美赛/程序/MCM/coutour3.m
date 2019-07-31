hospital=[-65.65 18.33;
      -66.03 18.22;
      -66.07 18.44;
      -66.16 18.40;
      -66.73 18.47];                        

figure

cntr = shaperead('./boundary/PRI_adm0.shp','UseGeoCoords',false);
mapshow(cntr)
hold on
road = shaperead('./road/tl_2013_72_prisecroads.shp','UseGeoCoords',true);
geoshow(road);
hold on
xx  = [-66.7315 18.4735
       -66.1049 18.4287;
       %-67.2151 17.9515];
       -66.6271 17.9826];
main_city=[-66.106 18.466;
           -66.156 18.399;
           -65.957 18.381;
           -66.614 18.011;
           -66.048 18.234;
           -66.111 18.357;
           -67.14  18.201;
           -66.007 18.355;
           -66.716 18.472;
           -65.652 18.326;
            ]
% plot(xx(:,1),xx(:,2),'r*');
%load('road_p.mat');

%plot(road_p(:,1),road_p(:,2),'r*');
plot(main_city(:,1),main_city(:,2),'k*');
for i=1:3
    hold on;%????????
    R = 0.1618;
    alpha=0:pi/50:2*pi;%??[0,2*pi]
    %R=2;%??
    x=R*cos(alpha)+xx(i,1);
    y=R*sin(alpha)+xx(i,2);
    plot(x,y,'-','LineWidth',2)
    axis equal
end
%[x y]=solve([deg2km(distance(xx(1,2),xx(1,1),y,x==52.2))],[x,y])
plot(hospital(:,1),hospital(:,2),'b*');

text(xx(1,1),xx(1,2),'position1');
text(xx(2,1),xx(2,2),'position2');
text(xx(3,1),xx(3,2),'position3');

text(main_city(1,1),main_city(1,2),'San Juan');
text(main_city(2,1),main_city(2,2),'Bayamón');
text(main_city(3,1),main_city(3,2),'Carolina');
text(main_city(4,1),main_city(4,2),'Ponce');
text(main_city(5,1),main_city(5,2),'Caguas');
text(main_city(6,1),main_city(6,2),'Guaynabo');
text(main_city(7,1),main_city(7,2),'Mayaguez');
text(main_city(8,1),main_city(8,2),'Trujillo Alto');
text(main_city(9,1),main_city(9,2),'Arecibo');
text(main_city(10,1),main_city(10,2),'Fajardo');

axis([-67.4, -65.3, 17.8, 18.6])

load('pattern1.mat');
load('dest_poi1.mat');
load('X1.mat');
load('pattern2.mat');
load('dest_poi2.mat');
load('X2.mat');
load('pattern3.mat');
load('dest_poi3.mat');
load('X3.mat');
%plot(start_point(1),start_point(2),'ms','MarkerEdgeColor','k','MarkerFaceColor','k')
% pattern1=[];
% X1=[];
% dest_poi1=[];
[m,~]=size(pattern1);
for i=1:m
%     if pattern1(i,3)==1 
         plot(pattern1(i,1),pattern1(i,2),'r*');
   
%     elseif pattern1(i,3)==2
%          plot(pattern1(i,1),pattern1(i,2),'g*');
%        
%     elseif pattern1(i,3)==3
%          plot(pattern1(i,1),pattern1(i,2),'b*');
%          
%     elseif pattern1(i,3)==4
%          plot(pattern1(i,1),pattern1(i,2),'y*');
%         
%     else
%          plot(pattern1(i,1),pattern1(i,2),'m*');
%         
%     end
    hold on;
    
end
%color=['r','g','b','c','m'];
color=['rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'];
[N,~]=size(X1);
for i=1:N
    dest_list=cell2mat(X1(i,1));
    [~,dest_num(i)]=size(dest_list);
    dest_position=cell2mat(dest_poi1(i));
    for j=1:dest_num(i)-1
        hold on
        plot([dest_position(dest_list(j),1),dest_position(dest_list(j+1),1)],[dest_position(dest_list(j),2),dest_position(dest_list(j+1),2)],color(i),'LineWidth',1);
        hold on
    end
    plot([dest_position(dest_list(1),1),dest_position(dest_list(dest_num(i)),1)],[dest_position(dest_list(1),2),dest_position(dest_list(dest_num(i)),2)],color(i),'LineWidth',1);
    hold on
end

% for i=1:5
%     y_mean=cell2mat(X1(i,2));
%     y_max=cell2mat(X1(i,3));
%     figure(i+1)
%     plot(y_max,'r'); hold on;
%     plot(y_mean,'b');grid;
%     textt=['search process (',num2str(dest_num(i)),'points)'];
%     title(textt);
%     legend('optimum solution','average solution');
%     xlabel('generation number');
%     ylabel('fitness');
% end
 
% pattern2=[];
% X2=[];
% dest_poi2=[];
[m,~]=size(pattern2);
for i=1:m
         plot(pattern2(i,1),pattern2(i,2),'r*');
    hold on;
    
end
 color=['rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'];
% dest_num=zeros(5,1);
[N,~]=size(X2);
for i=1:N
    dest_list=cell2mat(X2(i,1));
    [~,dest_num(i)]=size(dest_list);
    dest_position=cell2mat(dest_poi2(i));
    for j=1:dest_num(i)-1
        hold on
        plot([dest_position(dest_list(j),1),dest_position(dest_list(j+1),1)],[dest_position(dest_list(j),2),dest_position(dest_list(j+1),2)],color(i),'LineWidth',1);
        hold on
    end
    plot([dest_position(dest_list(1),1),dest_position(dest_list(dest_num(i)),1)],[dest_position(dest_list(1),2),dest_position(dest_list(dest_num(i)),2)],color(i),'LineWidth',1);
    hold on
end

% for i=1:5
%     y_mean=cell2mat(X2(i,2));
%     y_max=cell2mat(X2(i,3));
%     figure(i+1)
%     plot(y_max,'r'); hold on;
%     plot(y_mean,'b');grid;
%     textt=['search process (',num2str(dest_num(i)),'points)'];
%     title(textt);
%     legend('optimum solution','average solution');
%     xlabel('generation number');
%     ylabel('fitness');
% end

% pattern3=[];
% X3=[];
% dest_poi3=[];
[m,~]=size(pattern3);
for i=1:m
         plot(pattern3(i,1),pattern3(i,2),'r*');
    hold on;
    
end

dest_num=zeros(5,1);
[N,~]=size(X3);
for i=1:N
    dest_list=cell2mat(X3(i,1));
    [~,dest_num(i)]=size(dest_list);
    dest_position=cell2mat(dest_poi3(i));
    for j=1:dest_num(i)-1
        hold on
        plot([dest_position(dest_list(j),1),dest_position(dest_list(j+1),1)],[dest_position(dest_list(j),2),dest_position(dest_list(j+1),2)],color(i),'LineWidth',1);
        hold on
    end
    plot([dest_position(dest_list(1),1),dest_position(dest_list(dest_num(i)),1)],[dest_position(dest_list(1),2),dest_position(dest_list(dest_num(i)),2)],color(i),'LineWidth',1);
    hold on
end
y_max3=cell2mat(X3(i,3));
% for i=1:N
%     y_mean=cell2mat(X3(i,2));
%     y_max=cell2mat(X3(i,3));
% %     figure(i+1)
% %     plot(y_max,'r'); hold on;
% %     plot(y_mean,'b');grid;
% %     textt=['search process (',num2str(dest_num(i)),'points)'];
% %     title(textt);
% %     legend('optimum solution','average solution');
% %     xlabel('generation number');
% %     ylabel('fitness');
% end



% geoshow(hospital(:,2), hospital(:,1), 'DisplayType', 'point');
% geoshow(x(:,2), x(:,1), 'DisplayType', 'point', 'Color', 'black');
% load('coastline.mat');
% hold on
% scatter(coastline(:,1), coastline(:,2),'b*');