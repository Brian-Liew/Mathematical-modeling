function[R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ASTSP(C,NC_max,m,Alpha,Beta,p0,Q)
%C n�����е����꣬n*2����x,y��
%NC_max����������
%m ���ϸ���
%Alpha ������Ϣ����Ҫ�̶ȵĲ���
%Beta ��������ʽ������Ҫ�̶ȵĲ���
%p0 ��Ϣ������ϵ��
%Q ��Ϣ������ǿ��ϵ��
%R_best �������·��
%L_best �������·�ߵĳ���


%��ʼ��1
n=size(C,1);%size(C,1)����C��������Ҳ���ǳ��и�����n��ʾ���и���
D=zeros(n,n);%D��ʾͼ���ڽӾ��󣬸����ֵΪÿ���㵽ÿ�����Ȩֵ
% ������ת��Ϊ�ڽӾ���
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

%��ʼ��2
%Dֱ�Ӵ����ڽӾ���
% n=size(D,1);

QF=1./D;%EtaΪ�������Ӿ���������Ϊ����ĵ���
XXS=ones(n,n);%XXSΪ��Ϣ�ؾ���
JJtable=zeros(m,n);%�洢����¼·�������ɣ����ɱ�mΪ���ϸ���
NC=1;%��������������¼��������
R_best=zeros(NC_max,n);%����֮���ÿһ�����·��
L_best=inf.*ones(NC_max,1);%�������·�߳��ȣ���ʼ��Ϊ�����
L_ave=zeros(NC_max,1);%����·�ߵ�ƽ������

while NC<=NC_max %�������������ֹͣ
    %��mֻ���Ϸŵ�n��������
    Randpos=[];%���λ��
    for i=1:(ceil(m/n))%ceil,��������ȡ���������ల�ż���
        Randpos=[Randpos,randperm(n)];%randperm��1��n��Щ��������ҵõ���һ���������У�Ȼ�󲻶���ӵ�Randpos��ȥ
    end
    JJtable(:,1)=(Randpos(1,1:m))';%Tabu(:,1)��ʾTabu��һ�о��ǳ�ʼmֻ���ϱ�����ֵ���n�����е�һ��
    
    %mֻ���ϰ����ʺ���ѡ����һ�����У���ɸ��Ե�����
    for j=2:n%�����ڳ��е���һ�����п�ʼ
        for i=1:m
            visited=JJtable(i,1:(j-1));%��¼�ѷ��ʵĳ��У��ɱ����ظ�����
            ToVisitCity=zeros(1,(n-j+1));%�����ʵĳ���,�����ʳ��е�����Ϊ(n-j+1)
            P=ToVisitCity;%�����ʵĳ��е�ѡ����ʷֲ�
            count=1;%���ʵĳ��и���
            for k=1:n
                if length(find(visited==k))==0%��ʼ����Ϊ0,find()����ҵ�visited�е���k��Ԫ��������visited�е�λ�ã�length���Ϊ�����visited��û��kԪ�أ���û�з��ʹ�k���С�
                    ToVisitCity(count)=k;
                    count=count+1;
                end
            end
            
            %������г��еĸ��ʷֲ�
            for k=1:length(ToVisitCity)
                %visited(end)��ʾ�����������ڳ��б�ţ�ToVisitCity(k)��ʾ��һ��Ҫ���ʵĳ��б��
                P(k)=(XXS(visited(end),ToVisitCity(k))^Alpha)*(QF(visited(end),ToVisitCity(k))^Beta);
            end
            P=P/(sum(P));%�Ѹ���·������ͳһ����Ϊ1
            
            %������ԭ��ѡȡ��һ������
            
            %����Ҫѡ�����һ�����в��ǰ������ʣ�����Ҫ�õ����̷��򣬲�ȻӰ��ȫ�����������������õ��ۻ�������Pcum=cumsum(P)
            Pcum=cumsum(P);%cumsum��Ԫ���ۼӼ���ͣ�����P=[0.1 0.5 0.4]��cumsum(P)=  [0.1000    0.6000    1.0000]
            Select=find(Pcum>=rand);%������ĸ��ʴ���ԭ���ľ�ѡ������·��
            %Ҫѡ�������ܸ��ʴ��ڵ���ĳһ����������ҵ����ڵ������������ĳ��е���J�е�λ��
            
            %���̷���Select(1)��1��֤����ѡ�������ʵĳ��У����磺p=[0.1 0.6 0.3]�м��Ǹ����и�������ʱPcum=[0.1  0.7  1],   Select =[2   3];  Select(1)=2,�м��Ǹ����и������
            to_visit=ToVisitCity(Select(1));%��ȡ��Щ���еı�ŵ�to_visit��
            JJtable(i,j)=to_visit;
        end
    end
    if NC>=2
        JJtable(1,:)=R_best(NC-1,:);
    end
    
    %��¼���ε������·��
    L=zeros(m,1);%��¼���ε������·�ߵĳ��ȣ�ÿ�����϶����Լ��߹��ĳ��ȼ�¼������L��,��ʼ����Ϊ0��m*1��������
    for i=1:m
        R=JJtable(i,:);
        for j=1:(n-1)
            L(i)=L(i)+D(R(j),R(j+1));%ԭ������ϵ�j�����е���j+1�����еľ���
        end
        L(i)=L(i)+D(R(1),R(n));%һ���������߹��ľ��룬���ϵ�һ�������һ�����еľ���
    end
    
    L_best(NC)=min(L);%��Ѿ���ȡ��С
    pos=find(L==L_best(NC));%�ҵ����·������ֻ�������ڵ��б��
    R_best(NC,:)=JJtable(pos(1),:);%���ֵ���������·�ߣ��ҵ�·����̵������������ڵĳ����Ⱥ�˳��pos(1)��1��ʾ��һ�г���һ�����������ϣ��Ǿ�ѡ��һ��
    L_ave(NC)=mean(L);%���ֵ������ƽ������
    NC=NC+1
    
    %������Ϣ��
    UpdateXXS=zeros(n,n);%��ʼʱ��Ϣ��Ϊn*n��0����
    for i=1:m
        for j=1:(n-1)
            UpdateXXS(JJtable(i,j),JJtable(i,j+1))=UpdateXXS(JJtable(i,j),JJtable(i,j+1))+Q/L(i); %�˴�ѭ����·����i��j���ϵ���Ϣ������
        end
        UpdateXXS(JJtable(i,n),JJtable(i,1))=UpdateXXS(JJtable(i,n),JJtable(i,1))+Q/L(i);    %���ϵ�һ�������һ�����е���Ϣ��������QΪ��Ϣ������ǿ��ϵ��
        %�˴�ѭ��������·���ϵ���Ϣ������
    end
    XXS=(1-p0).*XXS+UpdateXXS;%������Ϣ�����������º����Ϣ�أ�p0Ϊ��Ϣ������ϵ��
    
    %���ɱ�����
    JJtable=zeros(m,n);%ֱ������������
    Pos=find(L_best==min(L_best));%�ҵ����·������0Ϊ�棩
    Shortest_Route=R_best(Pos(1),:);%�������·��
    Shortest_Length=L_best(Pos(1));%������̾���
    
    DrawRoute(C,Shortest_Route,NC,Shortest_Length);%��·��ͼ���Ӻ���
    title('��Ⱥ�㷨�Ż�·��');
end

%������
Pos=find(L_best==min(L_best));%�ҵ����·������0Ϊ�棩
Shortest_Route=R_best(Pos(1),:);%����������������·��
Shortest_Length=L_best(Pos(1));%���������������̾���
Shortest_Route
DrawRoute(C,Shortest_Route,NC,Shortest_Length)%��·��ͼ���Ӻ���
title('��Ⱥ�㷨�Ż�·��')
end

function DrawRoute(C,R,n,minLu)
% C �ڵ����꣬��һ��N*2�ľ���洢
% R Route·��
% n ��n�ε���
% minLu ���·

N=length(R);
scatter(C(:,1),C(:,2));
hold on
plot([C(R(1),1),C(R(N),1)],[C(R(1),2),C(R(N),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g')
hold on
text(3,30,['�� ',int2str(n),' �ε���','  ��̾���Ϊ ',num2str(minLu)]);
for i1=2:N
    plot([C(R(i1-1),1),C(R(i1),1)],[C(R(i1-1),2),C(R(i1),2)],'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g')
    hold on
end

hold off;
pause(0.05);
end
