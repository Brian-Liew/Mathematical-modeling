%求各代最优个体适应度的函数
global PartNum;                                     %各个全局变量的声明，含义根据变量名称可知
global LayoutFlag;
global Part;
global BestGeneration;
global BestGenerationFitness;
global OptimizationDaishu;
%global bbb;
%global aaa;

%计算各个个体的适应度


%clear aaa;
%clear bbb;
%clear;
%bbb=0;
for i=1:OptimizationDaishu
    bbb=0;
    BestGenerationFitness(i)=0;
    
    for o=1:PartNum
        [m,n]=size(Part(o).WuLiu);
        %aaa=zeros(1,1);
        %bbbb=zeros(1,1);  
                 for oo=1:m
                 %e1=zeros(1,1);
                 %e2=zeros(1,1);
                 [m1,m2]=size(BestGeneration(i,:));
                 e1=find(BestGeneration(i,:)==Part(o).WuLiu(oo,1));
                 e2=find(BestGeneration(i,:)==Part(o).WuLiu(oo,3));
                 
                 if LayoutFlag==1                                        %判断各种不同的布局，设定相应的距离
                     % aaa=100*(abs(e2-e1))*Part(o).WuLiu(oo,2);
                     d=abs(e2-e1);
                 end
                 
                 if LayoutFlag==2
                     if mod(m2,2)==0
                       m3=m2/2;
                     end
                     if mod(m2,2)==1
                         m3=(m2+1)/2;
                     end
                       m4=max(e1,e2);
                       m5=min(e1,e2);
                       if m4<=m3
                           d=m4-m5;
                       end
                       
                       if m5>m3
                           d=m4-m5;
                       end
                       
                       if (m5<=m3)&&(m4>m3)
                           d=sqrt((m4-m5)^2+2^2);
                       end    
                  end
                     
                     if LayoutFlag==3
                         
                     if mod(m2,2)==0
                       m3=m2/2;
                     end
                     
                     if mod(m2,2)==1
                         m3=(m2+1)/2;
                     end
                      m4=max(e1,e2);
                       m5=min(e1,e2);
                     if (m4-m5)<m3
                         dd=m4-m5;
                         
                     end
                     
                     if (m4-m5)>=3
                         dd=m2-(m4-m5);
                     end
                     d=3.1415926*2*3*dd/m2;
                     end 
              
                     aaa=100*d*Part(o).WuLiu(oo,2);
                     bbb=bbb+aaa;
                 end
          ccc(o)=bbb*Part(o).Num;
    end

    for ooo=1:PartNum
        BestGenerationFitness(i)=ccc(ooo)+BestGenerationFitness(i);
        %GenerationFitness(i)=GenerationFitness(i)/3000;
    end
   BestGenerationFitness(i)=100000/BestGenerationFitness(i);
end
%disp(GenerationFitness);

%zong=0;

%for i=1:10
 %  zong=zong+ GenerationFitness(i);
%end
%aver=zong/10;

%for i=1:10;
%     GenerationFitness(i)= GenerationFitness(i)/zong;
%end
    
