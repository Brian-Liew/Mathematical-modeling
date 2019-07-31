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
load('road_p.mat');
road_p1=cell2mat(road_p(1));
road_p2=cell2mat(road_p(2));
road_p3=cell2mat(road_p(3));

% plot(road_p1(:,1),road_p1(:,2),'r*');
% plot(road_p2(:,1),road_p2(:,2),'r*');
% plot(road_p3(:,1),road_p3(:,2),'r*');

plot(main_city(:,1),main_city(:,2),'k*');
for i=1:3
    hold on;%????????
    R = 0.2365;
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
% 
load('roadpos.mat');
% load('dest_poi.mat');
% load('X.mat');
% %plot(start_point(1),start_point(2),'ms','MarkerEdgeColor','k','MarkerFaceColor','k')
% [m,~]=size(pattern);
% for i=1:m
%     if pattern(i,3)==1 
%          plot(pattern(i,1),pattern(i,2),'r*');
%    
%     elseif pattern(i,3)==2
%          plot(pattern(i,1),pattern(i,2),'g*');
%        
%     elseif pattern(i,3)==3
%          plot(pattern(i,1),pattern(i,2),'b*');
%          
%     elseif pattern(i,3)==4
%          plot(pattern(i,1),pattern(i,2),'y*');
%         
%     else
%          plot(pattern(i,1),pattern(i,2),'m*');
%         
%     end
%     hold on;
%     
% end
% color=['r','g','b','c','m'];
% for i=1:5
%     dest_list=cell2mat(X(i,1));
%     [~,dest_num]=size(dest_list);
%     dest_position=cell2mat(dest_poi(i));
%     for j=1:dest_num-1
%         hold on
%         plot([dest_position(dest_list(j),1),dest_position(dest_list(j+1),1)],[dest_position(dest_list(j),2),dest_position(dest_list(j+1),2)],color(i),'LineWidth',1);
%         hold on
%     end
%     plot([dest_position(dest_list(1),1),dest_position(dest_list(dest_num),1)],[dest_position(dest_list(1),2),dest_position(dest_list(dest_num),2)],color(i),'LineWidth',1);
%     hold on
% end
% 
% for i=1:5
%     y_mean=cell2mat(X(i,2));
%     y_max=cell2mat(X(i,2));
%     figure(i+1)
%     plot(y_max,'r'); hold on;
%     plot(y_mean,'b');grid;
%     textt=['search process',num2str(i)];
%     title(textt);
%     legend('optimum solution','average solution');
% end
 




% geoshow(hospital(:,2), hospital(:,1), 'DisplayType', 'point');
% geoshow(x(:,2), x(:,1), 'DisplayType', 'point', 'Color', 'black');
% load('coastline.mat');
% hold on
% scatter(coastline(:,1), coastline(:,2),'b*');