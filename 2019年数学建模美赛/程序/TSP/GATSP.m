function Shortest_Length=GATSP(C)

PNum=4000; %��ʼ��Ⱥ��С
NC_max=500;  %������
pc=0.8; %�������
pm=0.1; %�������

n=size(C,1);%���е���Ŀ
D=zeros(n,n);
for i=1:n
    for j=1:n
        if i~=j
            D(i,j)=((C(i,1)-C(j,1))^2+(C(i,2)-C(j,2))^2)^0.5;%�򵥵�������֮��ľ���
        else
            D(i,j)=eps;%Ӧ�ø�ֵΪ0������Ϊ��������������Ҫȡ������������eps��ʾ��epsΪ������ĳ��ֵС��epsʱ���Ͱ����������0������
        end
        D(j,i)=D(i,j);%�Գƾ���
    end
end



%������ʼ��Ⱥ
PP=zeros(PNum,n);
for i=1:PNum
    PP(i,:)=randperm(n);%�����ȫ���У�Ȼ��ŵ���Ⱥ������ȥ
end
[~,psumPP]=PSY(PP,D);

NC=1;
L_ave=zeros(NC,1);
L_best=zeros(NC,1);
R_best=zeros(PNum,n);
PPcnew=zeros(PNum,n);
PPmnew=zeros(PNum,n);
while NC<NC_max+1
   for j=1:2:PNum%����Ϊ2�����ڵ���������ɽ����Ŵ�����
      selectedAB=select(psumPP);  %ѡ�����
      CrossoverAB=crossover(PP,selectedAB,pc);  %�������
      PPcnew(j,:)=CrossoverAB(1,:);
      PPcnew(j+1,:)=CrossoverAB(2,:);
      PPmnew(j,:)=mutation(PPcnew(j,:),pm);  %�������
      PPmnew(j+1,:)=mutation(PPcnew(j+1,:),pm);
   end
   PP=PPmnew;  %�������µ���Ⱥ
   [nSY,psumPP]=PSY(PP,D);  %��������Ⱥ����Ӧ��
   %��¼��ǰ����ú�ƽ������Ӧ��
   [fmax,nmax]=max(nSY);
   L_ave(NC)=1000/mean(nSY);
   L_best(NC)=1000/fmax;
   %��¼��ǰ������Ѹ���
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
title('��������');
legend('���Ž�','ƽ����');
fprintf('�Ŵ��㷨�õ�����̾���:%.2f\n',Shortest_Length);
fprintf('�Ŵ��㷨�õ������·��');
disp(R_best(index,:));
end

%����������Ⱥ����Ӧ��
function [nSY,psumPP]=PSY(PP,D)
    PNum=size(PP,1);  %��ȡ��Ⱥ��С
    nSY=zeros(PNum,1);  %���浱ǰ��Ⱥ����Ӧ��,��Ⱥ�и�����Ӧ��
    for i=1:PNum
       nSY(i)=SYFuction(D,PP(i,:));  %���㺯��ֵ������Ӧ��
    end
    nSY=1000./nSY'; %ת��֮��ȡ���뵹��

    %���ݸ������Ӧ�ȼ����䱻ѡ��ĸ���
    nSYsum=0;%����Ӧ��
    for i=1:PNum
       nSYsum=nSYsum+nSY(i)^30;% ����Ӧ��Խ�õĸ��屻ѡ�����Խ�ߣ�����ĳ˷����԰Ѻû���������
    end
    pPP=zeros(PNum,1);%��Ⱥ�и��屻ѡ��ĸ���
    for i=1:PNum
       pPP(i)=nSY(i)^30/nSYsum;
    end

    %�����ۻ�����
    psumPP=zeros(PNum,1);
    psumPP(1)=pPP(1);
    for i=2:PNum
       psumPP(i)=psumPP(i-1)+pPP(i);
    end
    psumPP=psumPP';
end

%���ݱ�������ж��Ƿ����,1Ϊ���죬0Ϊ������
function changed=IsChange(pc)
    test(1:100)=0;
    m=round(100*pc);
    test(1:m)=1;
    n=round(rand*99)+1;
    changed=test(n);   
end

%ѡ����������̶�ѡ��
function selectedAB=select(psumPP)
    selectedAB=zeros(2,1);
    %����Ⱥ��ѡ���������壬��ò�Ҫ����ѡ��ͬһ������
    for i=1:2
       r=rand;  %����һ�������
       prand=psumPP-r;
       j=1;
       while prand(j)<0
           j=j+1;
       end
       selectedAB(i)=j; %ѡ�и�������
       if i==2&&j==selectedAB(i-1)    %%����ͬ����ѡһ��
           r=rand;  %����һ�������
           prand=psumPP-r;
           j=1;
           while prand(j)<0
               j=j+1;
           end
       end
    end
end

%�������
function CrossoverAB=crossover(PP,selectedAB,pc)
    n=size(PP,2);%������Ⱥ��������Ҳ���ǳ��и���
    changed=IsChange(pc);  %���ݽ�����ʾ����Ƿ���н��������1���ǣ�0���
    CrossoverAB(1,:)=PP(selectedAB(1),:);
    CrossoverAB(2,:)=PP(selectedAB(2),:);
    if changed==1
       c1=round(rand*(n-2))+1;  %��[1,bn-1]��Χ���������һ������λ
       c2=round(rand*(n-2))+1;
       low=min(c1,c2);%c1,c2�еĵ�λ
       high=max(c1,c2);%c1,c2�еĸ�λ
       
       %�м�ĳ��и�����н���
       middle=CrossoverAB(1,low+1:high);
       CrossoverAB(1,low+1:high)=CrossoverAB(2,low+1:high);
       CrossoverAB(2,low+1:high)=middle;
       
       for i=1:low %����֮�󣬽���֮�󣬸��嵱�л������ظ������ظ��Ļ����滻
           %CCWZ �ظ��������м䲿�ֵ�λ��
           while find(CrossoverAB(1,low+1:high)==CrossoverAB(1,i))
               CCWZ=find(CrossoverAB(1,low+1:high)==CrossoverAB(1,i));
               y=CrossoverAB(2,low+CCWZ);%����֮���ڶԷ��Ļ���Ҳ����֮ǰλ���ϵĻ���
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

%����������м����ת
function PPmnew=mutation(PP,pm)

    n=size(PP,2);
    PPmnew=PP;

    changed=IsChange(pm);  %���ݱ�����ʾ����Ƿ���б��������1���ǣ�0���
    if changed==1
       c1=round(rand*(n-2))+1;  %��[1,bn-1]��Χ���������һ������λ
       c2=round(rand*(n-2))+1;
       low=min(c1,c2);
       high=max(c1,c2);
       middle=PP(low+1:high);
       PPmnew(low+1:high)=fliplr(middle);%�������ʽ�ܼ򵥣����ǰ��м䲿�ַ�ת��fliplr(A)��A��Ԫ�ص�˳����з�ת��
    end
end

%��Ӧ�Ⱥ����������Ⱥ��ÿ���������Ӧ��
%�������Ӧ����ȡ�ľ��볤�ȣ�ʵ���У�����Խ��Խ����Ӧ������֮��Ҫȡ����
function Update_d=SYFuction(D,PP)
    Update_d=0;
    n=size(PP,2);
    for i=1:(n-1)
        Update_d=Update_d+D(PP(i),PP(i+1));
    end
    Update_d=Update_d+D(PP(n),PP(1));
end

%��ͼ
function drawTSP(C,Shortest_Route,Shortest_Length,p,f)
n=size(C,1);
for i=1:n-1
    plot([C(Shortest_Route(i),1),C(Shortest_Route(i+1),1)],[C(Shortest_Route(i),2),C(Shortest_Route(i+1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
    hold on;
end
plot([C(Shortest_Route(n),1),C(Shortest_Route(1),1)],[C(Shortest_Route(n),2),C(Shortest_Route(1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
if f==0
    text(3,30,['�� ',int2str(p),' ��','  ��̾���Ϊ ',num2str(Shortest_Length)]);
else
    text(3,30,['���������������̾��� ',num2str(Shortest_Length),'�� �ڵ� ',num2str(p),' ���ﵽ']);
end
hold off;
pause(0.05); 
end