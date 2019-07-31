%产生初始化种群
global MachineNum;                                                 %定义个全局变量，变量含义见各变量的名称
global InitialGeneration;


%产生初始值
   for i=1:10
       InitialGeneration(i,1:MachineNum)=randperm(MachineNum);
       %InitialGeneration(i,1:10)=randperm(10);
   end
       