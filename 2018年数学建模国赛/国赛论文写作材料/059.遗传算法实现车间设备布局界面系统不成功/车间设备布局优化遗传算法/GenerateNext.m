%核心程序 产生下一代种群，包括选择，交叉，变异和保优操作
global MachineNum;                                 %定义各个全局变量 各变量的含义见变量名称
global OptimizationDaishu;
global InitialGeneration;
global GenerationFitness;
global Generation;
global OutstandingIndividual;
global NextGeneration;
global JiaoChaGeneration;
global BestGeneration;
%global SortGeneration;
global ccca;


Generation=InitialGeneration;                                                
for k=1:OptimizationDaishu                                                  %循环产生下一代种群，知道达到选择的代数
    %计算符合度
  Fitness;
%    GenerationFitness=Fitness1(Generation);
    %找到最优个体
 %   a=GenerationFitness(1);
%for i=1:10
 %   if(GenerationFitness(i)>=a)
   %     a=GenerationFitness(i);
  %  end
%end
[s,t]=max(GenerationFitness)
OutstandingIndividual=zeros(1,MachineNum);                                    %保存一代中的最优个体
%m=find(GenerationFitness(:)==a);
%OutstandingIndividual=zeros(1,10);
OutstandingIndividual=Generation(t,:);
BestGeneration(k,:)=OutstandingIndividual(:);

zong=0;                                                                       %执行选择操作
for i=1:10
   zong=zong+ GenerationFitness(i);
end
aver=zong/10;
ccca(k)=aver;
     %计算选择概率

 fsum=0;
for i=1:10
   fsum=fsum+GenerationFitness(i);
end

for i=1:10
   ps(i)=GenerationFitness(i)/fsum;
end

%计算累积概率

p(1)=ps(1);
for i=2:10
   p(i)=p(i-1)+ps(i);
end

p=p';
    
    
for q=1:5                                                                   %执行交叉操作
  
    for i=1:2
    
        r=rand;                 
        prand=r-p;
    
    j=1;
   while prand(j)>0
       j=j+1;
   end
    JiaoChaGeneration(i,:)=Generation(j,:);
    end
     
   rr=rand;
   if rr<0.7
        A=randperm(MachineNum);
        B=A(MachineNum-1);
        C=A(MachineNum-2);
        if B>C
            temp=B;
            B=C;
            C=temp;
        end
            
        
            TempString= JiaoChaGeneration(1,B+1:C);
            JiaoChaGeneration(1,B+1:C)=JiaoChaGeneration(2,B+1:C);
            JiaoChaGeneration(2,B+1:C)=TempString;
       
        
        for i=1:B                                                          %执行冲突检查及冲突解决的操作
       while find(JiaoChaGeneration(1,B+1:C)==JiaoChaGeneration(1,i))
           zhi=find(JiaoChaGeneration(1,B+1:C)==JiaoChaGeneration(1,i));
           y=JiaoChaGeneration(2,B+zhi);
           JiaoChaGeneration(1,i)=y;
       end
       while find(JiaoChaGeneration(2,B+1:C)==JiaoChaGeneration(2,i))
           zhi=find(JiaoChaGeneration(2,B+1:C)==JiaoChaGeneration(2,i));
           y=JiaoChaGeneration(1,B+zhi);
           JiaoChaGeneration(2,i)=y;
       end
   end
   for i=C+1:MachineNum
       while find(JiaoChaGeneration(1,1:C)==JiaoChaGeneration(1,i))
           zhi=find(JiaoChaGeneration(1,1:C)==JiaoChaGeneration(1,i));
           y=JiaoChaGeneration(2,zhi);
           JiaoChaGeneration(1,i)=y;
       end
       while find(JiaoChaGeneration(2,1:C)==JiaoChaGeneration(2,i))
           zhi=find(JiaoChaGeneration(2,1:C)==JiaoChaGeneration(2,i));
           y=JiaoChaGeneration(1,zhi);
           JiaoChaGeneration(2,i)=y;
       end
   end
   end
   NextGeneration((q-1)*2+1,:)=JiaoChaGeneration(1,:);
   NextGeneration((q-1)*2+2,:)=JiaoChaGeneration(2,:);
end


   

                                                                            %变异操作
  for i=1:10
      r1=rand;
      if r1<0.08
           A=randperm(MachineNum);
        B=A(MachineNum-5);
        C=A(MachineNum-3);
    
        if B>C
            temp=B;
            B=C;
            C=temp;
        end
      aaaa=C;
      TempBianYi=zeros(1,MachineNum);
      for rr=B:C
          TempBianYi(rr)=NextGeneration(i,aaaa);
          aaaa=aaaa-1;
      end
      
     NextGeneration(i,B:C)=TempBianYi(B:C);
  end
  end
  NextGeneration(10,:)=OutstandingIndividual(:);
  %for qqq=1:10
  %Gerneration(qqq,:)=NextGeneration(qqq,:);
  %end
  Generation=NextGeneration;
 %变异结束新种群生成完毕
% BestGeneration(k,:)=OutstandingIndividual(:);
end
%oo=1;
%Fitness;
%cccccc=max(GenerationFitness);
%wwww=find(GenerationFitness(:)==cccccc);
%disp(Generation(wwww));
BestFitness;
