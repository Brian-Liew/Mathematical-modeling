function Shortest_Length=GATSP(C)

PNum=4000; %初始种群大小
NC_max=500;  %最大代数
pc=0.8; %交叉概率
pm=0.1; %变异概率

n=size(C,1);%城市的数目
D=zeros(n,n);
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



%产生初始种群
PP=zeros(PNum,n);
for i=1:PNum
    PP(i,:)=randperm(n);%随机数全排列，然后放到种群矩阵中去
end
[~,psumPP]=PSY(PP,D);

NC=1;
L_ave=zeros(NC,1);
L_best=zeros(NC,1);
R_best=zeros(PNum,n);
PPcnew=zeros(PNum,n);
PPmnew=zeros(PNum,n);
while NC<NC_max+1
   for j=1:2:PNum%步进为2，相邻的两个个体可进行遗传操作
      selectedAB=select(psumPP);  %选择操作
      CrossoverAB=crossover(PP,selectedAB,pc);  %交叉操作
      PPcnew(j,:)=CrossoverAB(1,:);
      PPcnew(j+1,:)=CrossoverAB(2,:);
      PPmnew(j,:)=mutation(PPcnew(j,:),pm);  %变异操作
      PPmnew(j+1,:)=mutation(PPcnew(j+1,:),pm);
   end
   PP=PPmnew;  %产生了新的种群
   [nSY,psumPP]=PSY(PP,D);  %计算新种群的适应度
   %记录当前代最好和平均的适应度
   [fmax,nmax]=max(nSY);
   L_ave(NC)=1000/mean(nSY);
   L_best(NC)=1000/fmax;
   %记录当前代的最佳个体
   Shortest_Route=PP(nmax,:);
   R_best(NC,:)=Shortest_Route;
   drawTSP(C,Shortest_Route,L_best(NC),NC,0);
   NC=NC+1;
end
[Shortest_Length,index]=min(L_best);
drawTSP(C,R_best(index,:),Shortest_Length,index,1);

figure(2);
plot(L_best,'r'); hold on;
plot(L_ave,'b');grid;
title('搜索过程');
legend('最优解','平均解');
fprintf('遗传算法得到的最短距离:%.2f\n',Shortest_Length);
fprintf('遗传算法得到的最短路线');
disp(R_best(index,:));
end

%计算所有种群的适应度
function [nSY,psumPP]=PSY(PP,D)
    PNum=size(PP,1);  %读取种群大小
    nSY=zeros(PNum,1);  %储存当前种群的适应度,种群中个体适应度
    for i=1:PNum
       nSY(i)=SYFuction(D,PP(i,:));  %计算函数值，即适应度
    end
    nSY=1000./nSY'; %转秩之后，取距离倒数

    %根据个体的适应度计算其被选择的概率
    nSYsum=0;%总适应度
    for i=1:PNum
       nSYsum=nSYsum+nSY(i)^30;% 让适应度越好的个体被选择概率越高，这里的乘方可以把好坏明显区分
    end
    pPP=zeros(PNum,1);%种群中个体被选择的概率
    for i=1:PNum
       pPP(i)=nSY(i)^30/nSYsum;
    end

    %计算累积概率
    psumPP=zeros(PNum,1);
    psumPP(1)=pPP(1);
    for i=2:PNum
       psumPP(i)=psumPP(i-1)+pPP(i);
    end
    psumPP=psumPP';
end

%根据变异概率判断是否变异,1为变异，0为不变异
function changed=IsChange(pc)
    test(1:100)=0;
    m=round(100*pc);
    test(1:m)=1;
    n=round(rand*99)+1;
    changed=test(n);   
end

%选择操作，轮盘赌选择法
function selectedAB=select(psumPP)
    selectedAB=zeros(2,1);
    %从种群中选择两个个体，最好不要两次选择同一个个体
    for i=1:2
       r=rand;  %产生一个随机数
       prand=psumPP-r;
       j=1;
       while prand(j)<0
           j=j+1;
       end
       selectedAB(i)=j; %选中个体的序号
       if i==2&&j==selectedAB(i-1)    %%若相同就再选一次
           r=rand;  %产生一个随机数
           prand=psumPP-r;
           j=1;
           while prand(j)<0
               j=j+1;
           end
       end
    end
end

%交叉操作
function CrossoverAB=crossover(PP,selectedAB,pc)
    n=size(PP,2);%返回种群的列数，也就是城市个数
    changed=IsChange(pc);  %根据交叉概率决定是否进行交叉操作，1则是，0则否
    CrossoverAB(1,:)=PP(selectedAB(1),:);
    CrossoverAB(2,:)=PP(selectedAB(2),:);
    if changed==1
       c1=round(rand*(n-2))+1;  %在[1,bn-1]范围内随机产生一个交叉位
       c2=round(rand*(n-2))+1;
       low=min(c1,c2);%c1,c2中的低位
       high=max(c1,c2);%c1,c2中的高位
       
       %中间的城市个体进行交换
       middle=CrossoverAB(1,low+1:high);
       CrossoverAB(1,low+1:high)=CrossoverAB(2,low+1:high);
       CrossoverAB(2,low+1:high)=middle;
       
       for i=1:low %交叉之后，交叉之后，个体当中基因有重复，将重复的基因替换
           %CCWZ 重复城市在中间部分的位置
           while find(CrossoverAB(1,low+1:high)==CrossoverAB(1,i))
               CCWZ=find(CrossoverAB(1,low+1:high)==CrossoverAB(1,i));
               y=CrossoverAB(2,low+CCWZ);%交换之后在对方的基因，也就是之前位置上的基因
               CrossoverAB(1,i)=y;
           end
           while find(CrossoverAB(2,low+1:high)==CrossoverAB(2,i))
               CCWZ=find(CrossoverAB(2,low+1:high)==CrossoverAB(2,i));
               y=CrossoverAB(1,low+CCWZ);
               CrossoverAB(2,i)=y;
           end
       end
       for i=high+1:n
           while find(CrossoverAB(1,1:high)==CrossoverAB(1,i))
               CCWZ=find(CrossoverAB(1,1:high)==CrossoverAB(1,i));
               y=CrossoverAB(2,0+CCWZ);
               CrossoverAB(1,i)=y;
           end
           while find(CrossoverAB(2,1:high)==CrossoverAB(2,i))
               CCWZ=find(CrossoverAB(2,1:high)==CrossoverAB(2,i));
               y=CrossoverAB(1,0+CCWZ);
               CrossoverAB(2,i)=y;
           end
       end
    end
end

%变异操作，中间基因反转
function PPmnew=mutation(PP,pm)

    n=size(PP,2);
    PPmnew=PP;

    changed=IsChange(pm);  %根据变异概率决定是否进行变异操作，1则是，0则否
    if changed==1
       c1=round(rand*(n-2))+1;  %在[1,bn-1]范围内随机产生一个变异位
       c2=round(rand*(n-2))+1;
       low=min(c1,c2);
       high=max(c1,c2);
       middle=PP(low+1:high);
       PPmnew(low+1:high)=fliplr(middle);%变异的形式很简单，就是把中间部分翻转，fliplr(A)将A中元素的顺序进行翻转。
    end
end

%适应度函数，求解种群中每个个体的适应度
%这里的适应度是取的距离长度，实际中，距离越长越不适应，所以之后要取倒数
function Update_d=SYFuction(D,PP)
    Update_d=0;
    n=size(PP,2);
    for i=1:(n-1)
        Update_d=Update_d+D(PP(i),PP(i+1));
    end
    Update_d=Update_d+D(PP(n),PP(1));
end

%画图
function drawTSP(C,Shortest_Route,Shortest_Length,p,f)
n=size(C,1);
for i=1:n-1
    plot([C(Shortest_Route(i),1),C(Shortest_Route(i+1),1)],[C(Shortest_Route(i),2),C(Shortest_Route(i+1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
    hold on;
end
plot([C(Shortest_Route(n),1),C(Shortest_Route(1),1)],[C(Shortest_Route(n),2),C(Shortest_Route(1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
if f==0
    text(3,30,['第 ',int2str(p),' 代','  最短距离为 ',num2str(Shortest_Length)]);
else
    text(3,30,['最终搜索结果：最短距离 ',num2str(Shortest_Length),'， 在第 ',num2str(p),' 代达到']);
end
hold off;
pause(0.05); 
end