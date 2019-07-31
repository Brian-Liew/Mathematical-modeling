function Shortest_Length=SATSP(C)
a=0.99;%�¶�˥�������Ĳ���
t0=99;
tf=3;
t=t0;
MarkobLength=10000;%Markob������

n=size(C,1);%���е���Ŀ

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

R_new=1:n;%������ʼ��
%sol_new��ÿ�β������½⣻sol_current�ǵ�ǰ�⣻sol_best����ȴ�е���ý�
L_current=inf;%��ǰ����
Shortest_Length=inf;%��ǰ��þ���

%��ʼ��
R_current=R_new;
R_best=R_new;

p=1;

while t>=tf
    t
    for r=1:MarkobLength
        %�����Ŷ�
        if(rand<0.5)%�������������������������
            %������
            i1=0;i2=0;
            while(i1==i2)
                i1=ceil(rand.*n);
                i2=ceil(rand.*n);
            end
            tmp1=R_new(i1);
            R_new(i1)=R_new(i2);
            R_new(i2)=tmp1;
        else
            % ������
            i1 = 0; i2 = 0; i3 = 0;
            while (i1 == i2) || (i1 == i3)|| (i2 == i3) || (abs(i1-i2) == 1)
                i1 = ceil(rand.*n);
                i2 = ceil(rand.*n);
                i3 = ceil(rand.*n);
            end
            tmp1 = i1;tmp2 = i2;tmp3 = i3;
            % ȷ��i1 < i2 < i3
            if (i1 < i2) && (i2 < i3)
            elseif (i1 < i3) && (i3 < i2)
                i2 = tmp3;i3 = tmp2;
            elseif (i2 < i1) && (i1 < i3)
                i1 = tmp2;i2 = tmp1;
            elseif (i2 < i3) && (i3 < i1)
                i1 = tmp2;i2 = tmp3; i3 = tmp1;
            elseif (i3 < i1) && (i1 < i2)
                i1 = tmp3;i2 = tmp1; i3 = tmp2;
            elseif (i3 < i2) && (i2 < i1)
                i1 = tmp3;i2 = tmp2; i3 = tmp1;
            end

            tmplist1 = R_new((i1+1):(i2-1));
            R_new((i1+1):(i1+i3-i2+1)) =R_new((i2):(i3));
            R_new((i1+i3-i2+2):i3) = tmplist1;
        end
        
        %����Ƿ�����Լ��
        
        %����Ŀ�꺯��
        L_new=0;
        for i=1:(n-1)
            L_new=L_new+D(R_new(i),R_new(i+1));
        end
        %�ټ�������һ�����е���һ�����еľ���
        L_new=L_new+D(R_new(n),R_new(1));
        
        if L_new<L_current
            L_current=L_new;
            R_current=R_new;
            if L_new<Shortest_Length%����ȴ�������õĽⱣ������
                Shortest_Length=L_new;
                R_best=R_new;
            end
        else
            %���½��Ŀ�꺯��ֵС�ڵ�ǰ��ģ����һ�����ʽ����½�
            if rand<exp(-(L_new-L_current)./t)
                L_current=L_new;
                R_current=R_new;
            else
                R_new=R_current;
            end
        end
    end
    t=t.*a;%���Ʋ���t���¶ȣ�����Ϊԭ����a��
    drawRoute(C,R_best,t,Shortest_Length);
end
drawRoute(C,R_best,t,Shortest_Length);
disp('���Ž�Ϊ��')
disp(R_best)
disp('��̾��룺')
disp(Shortest_Length)

end

function drawRoute(C,R_best,t,minLu)
for i=1:length(C)
    plot(C(i,1),C(i,2),'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
    hold on;
end
x=C([R_best R_best(1)],1);
y=C([R_best R_best(1)],2);
plot(x,y,'ms-','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','g');
text(3,30,['�� ',num2str(t),' ��','  ��̾���Ϊ ',num2str(minLu)]);
title('ģ���˻��㷨�Ż�·��')
hold off
pause(0.05); 
end