function[R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ASTSP(C,NC_max,m,Alpha,Beta,p0,Q)
%C n个城市的坐标，n*2矩阵（x,y）
%NC_max最大迭代次数
%m 蚂蚁个数
%Alpha 表征信息素重要程度的参数
%Beta 表征启发式因子重要程度的参数
%p0 信息素蒸发系数
%Q 信息素增加强度系数
%R_best 各代最佳路线
%L_best 各代最佳路线的长度


%初始化1
n=size(C,1);%size(C,1)返回C的行数，也就是城市个数，n表示城市个数
D=zeros(n,n);%D表示图的邻接矩阵，各点的值为每个点到每个点的权值
% 把坐标转换为邻接矩阵
for i=1:n
    for j=1:n
        if i~=j
            D(i,j)=((C(i,1)-C(j,1))^2+(C(i,2)-C(j,2))^2)^0.5;%简单地求两点之间的距离
        else
            D(i,j)=eps;%应该赋值为0，但因为后面启发因子需要取倒数，所以用eps表示，eps为当发现某个值小于eps时，就把这个数当做0来处理
        end
        D(j,i)=D(i,j);%对称矩阵
    end
end

%初始化2
%D直接传入邻接矩阵
% n=size(D,1);

QF=1./D;%Eta为启发因子矩阵，这里设为距离的倒数
XXS=ones(n,n);%XXS为信息素矩阵
JJtable=zeros(m,n);%存储并记录路径的生成，禁忌表，m为蚂蚁个数
NC=1;%迭代计数器，记录迭代次数
R_best=zeros(NC_max,n);%迭代之后的每一代最佳路线
L_best=inf.*ones(NC_max,1);%各代最佳路线长度，初始化为无穷大
L_ave=zeros(NC_max,1);%各代路线的平均长度

while NC<=NC_max %迭代次数到最大停止
    %将m只蚂蚁放到n个城市上
    Randpos=[];%随机位置
    for i=1:(ceil(m/n))%ceil,向正方向取整，求得最多安排几次
        Randpos=[Randpos,randperm(n)];%randperm把1到n这些数随机打乱得到的一个数字序列，然后不断添加到Randpos中去
    end
    JJtable(:,1)=(Randpos(1,1:m))';%Tabu(:,1)表示Tabu第一行就是初始m只蚂蚁被随机分到所n城市中的一个
    
    %m只蚂蚁按概率函数选择下一座城市，完成各自的周游
    for j=2:n%从所在城市的下一个城市开始
        for i=1:m
            visited=JJtable(i,1:(j-1));%记录已访问的城市，可避免重复访问
            ToVisitCity=zeros(1,(n-j+1));%待访问的城市,待访问城市的数量为(n-j+1)
            P=ToVisitCity;%待访问的城市的选择概率分布
            count=1;%访问的城市个数
            for k=1:n
                if length(find(visited==k))==0%开始设置为0,find()语句找到visited中等于k的元素在数组visited中的位置，length如果为零就是visited中没有k元素，即没有访问过k城市。
                    ToVisitCity(count)=k;
                    count=count+1;
                end
            end
            
            %下面进行城市的概率分布
            for k=1:length(ToVisitCity)
                %visited(end)表示蚂蚁现在所在城市编号，ToVisitCity(k)表示下一个要访问的城市编号
                P(k)=(XXS(visited(end),ToVisitCity(k))^Alpha)*(QF(visited(end),ToVisitCity(k))^Beta);
            end
            P=P/(sum(P));%把各个路径概率统一到和为1
            
            %按概率原则选取下一个城市
            
            %蚂蚁要选择的下一个城市不是按最大概率，就是要用到轮盘法则，不然影响全局收缩能力，所以用到累积函数，Pcum=cumsum(P)
            Pcum=cumsum(P);%cumsum，元素累加即求和，比如P=[0.1 0.5 0.4]，cumsum(P)=  [0.1000    0.6000    1.0000]
            Select=find(Pcum>=rand);%若计算的概率大于原来的就选择这条路线
            %要选择其中总概率大于等于某一个随机数，找到大于等于这个随机数的城市的在J中的位置
            
            %轮盘法则，Select(1)，1保证可以选到最大概率的城市，比如：p=[0.1 0.6 0.3]中间那个城市概率最大此时Pcum=[0.1  0.7  1],   Select =[2   3];  Select(1)=2,中间那个城市概率最大
            to_visit=ToVisitCity(Select(1));%提取这些城市的编号到to_visit中
            JJtable(i,j)=to_visit;
        end
    end
    if NC>=2
        JJtable(1,:)=R_best(NC-1,:);
    end
    
    %记录本次迭代最佳路线
    L=zeros(m,1);%记录本次迭代最佳路线的长度，每个蚂蚁都有自己走过的长度记录在向量L中,开始距离为0，m*1的列向量
    for i=1:m
        R=JJtable(i,:);
        for j=1:(n-1)
            L(i)=L(i)+D(R(j),R(j+1));%原距离加上第j个城市到第j+1个城市的距离
        end
        L(i)=L(i)+D(R(1),R(n));%一轮下来后走过的距离，加上第一个和最后一个城市的距离
    end
    
    L_best(NC)=min(L);%最佳距离取最小
    pos=find(L==L_best(NC));%找到最短路径的那只蚂蚁所在的行编号
    R_best(NC,:)=JJtable(pos(1),:);%此轮迭代后的最佳路线，找到路径最短的那条蚂蚁所在的城市先后顺序，pos(1)中1表示万一有长度一样的两条蚂蚁，那就选第一个
    L_ave(NC)=mean(L);%此轮迭代后的平均距离
    NC=NC+1
    
    %更新信息素
    UpdateXXS=zeros(n,n);%开始时信息素为n*n的0矩阵
    for i=1:m
        for j=1:(n-1)
            UpdateXXS(JJtable(i,j),JJtable(i,j+1))=UpdateXXS(JJtable(i,j),JJtable(i,j+1))+Q/L(i); %此次循环在路径（i，j）上的信息素增量
        end
        UpdateXXS(JJtable(i,n),JJtable(i,1))=UpdateXXS(JJtable(i,n),JJtable(i,1))+Q/L(i);    %加上第一个到最后一个城市的信息素增量，Q为信息素增加强度系数
        %此次循环在整个路径上的信息素增量
    end
    XXS=(1-p0).*XXS+UpdateXXS;%考虑信息素蒸发，更新后的信息素，p0为信息素蒸发系数
    
    %禁忌表清零
    JJtable=zeros(m,n);%直到最大迭代次数
    Pos=find(L_best==min(L_best));%找到最佳路径（非0为真）
    Shortest_Route=R_best(Pos(1),:);%本次最佳路径
    Shortest_Length=L_best(Pos(1));%本次最短距离
    
    DrawRoute(C,Shortest_Route,NC,Shortest_Length);%画路线图的子函数
    title('蚁群算法优化路径');
end

%输出结果
Pos=find(L_best==min(L_best));%找到最佳路径（非0为真）
Shortest_Route=R_best(Pos(1),:);%最大迭代次数后的最佳路径
Shortest_Length=L_best(Pos(1));%最大迭代次数后的最短距离
Shortest_Route
DrawRoute(C,Shortest_Route,NC,Shortest_Length)%画路线图的子函数
title('蚁群算法优化路径')
end

function DrawRoute(C,R,n,minLu)
% C 节点坐标，由一个N*2的矩阵存储
% R Route路线
% n 第n次迭代
% minLu 最短路

N=length(R);
scatter(C(:,1),C(:,2));
hold on
plot([C(R(1),1),C(R(N),1)],[C(R(1),2),C(R(N),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g')
hold on
text(3,30,['第 ',int2str(n),' 次迭代','  最短距离为 ',num2str(minLu)]);
for i1=2:N
    plot([C(R(i1-1),1),C(R(i1),1)],[C(R(i1-1),2),C(R(i1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g')
    hold on
end

hold off;
pause(0.05);
end
