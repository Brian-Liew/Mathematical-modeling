%������ʼ����Ⱥ
global MachineNum;                                                 %�����ȫ�ֱ��������������������������
global InitialGeneration;


%������ʼֵ
   for i=1:10
       InitialGeneration(i,1:MachineNum)=randperm(MachineNum);
       %InitialGeneration(i,1:10)=randperm(10);
   end
       