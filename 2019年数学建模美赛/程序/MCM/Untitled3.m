load('roadpos.mat');
road_center=cell(3,1);
[r_s,~]=size(roadpos);

xx  = [-66.7315 18.4735
       -66.1049 18.4287;
       %-67.2151 17.9515];
       -66.6271 17.9826];
   
for i=1:3
    road_temp=[];
    for j=1:r_s
        if deg2km(distance(roadpos(j,2),roadpos(j,1),xx(i,2), xx(i,1)))<26.3
             road_temp=[road_temp;roadpos(j,:)];
        end
    end
    road_center(i)={road_temp};
end