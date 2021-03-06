function varargout = main(varargin)
% MAIN M-file for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 06-Dec-2009 03:14:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MachineNum=get(handles.edit1,'string');
MachineNum=str2num(MachineNum);

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global MachineNum;                                         %定义全局变量
global PartNum;
global LayoutFlag;
global Part;
global b;
global cs;
global h_edit;

MachineNum=get(handles.edit1,'string');                  %获得用户输入的各参数，并将个参数存储到所设定好的矩阵中
MachineNum=str2num(MachineNum);

PartNum=get(handles.edit2,'string');
PartNum=str2num(PartNum);

if get(handles.radiobutton1,'value')==1
    LayoutFlag=1;
end

if get(handles.radiobutton2,'value')==1
    LayoutFlag=2;
end

if get(handles.radiobutton3,'value')==1
    LayoutFlag=3;
end
%disp(MachineNum);
%disp(PartNum);
%global i;
for i=1:PartNum
    c1='请输入第';
    c2=num2str(i);
    c3='个零件所需设备：';
    c=[c1 c2 c3];
    
    b=inputdlg({c});
   %as(i)=b;
    
    Part(i).Num=inputdlg({'请输入加工该零件的个数：'});
    Part(i).Num=cell2mat(Part(i).Num);
    Part(i).Num=str2num(Part(i).Num);
    
    as(i)=b;
    bs(i)=cell2mat(as(i));
    cs(i)=str2num(bs(i));
    % disp(as(i));


end
h_main=figure('name','请输入该零件的设备和物流量信息','menubar','none','numbertitle','off','position',[300 300 500 500]);
 h_text=uicontrol('style','text','position',[100 350 300 80],'string','请依次输入该零件所需的设备号，两个设备号之间填入这两个设备间的单位距离物流量。零件的排序为最下面的一行为零件1，向上依次递加。'); 
for i=1:PartNum
   for p=1:(cs(i)*2-1)
        h_edit(p+i*20)=uicontrol('style','edit','backgroundcolor',[1 1 1],'position',[30*p 30+30*i 20 20],'tag','myedit','string',' ','horizontalalignment','left')
   end
end
 h_but1=uicontrol('style','pushbutton','position',[100 10 50 20],'string','确定', 'callback',['global cs;','global PartNum;','global Part;','global h_edit;',...
                'for i=1:PartNum;','for ii=1:(cs(i)-1);','dd=1+(ii-1)*2;',...
          'aa=get(h_edit(dd+i*20),''string'');','aa=str2double(aa);',' bb=get(h_edit(dd+1+i*20),''string'');', 'bb=str2double(bb);','cc=get(h_edit(dd+2+i*20),''string'');',...
       'cc=str2double(cc);','Part(i).WuLiu(ii,1:3)=[aa bb cc];','end;','end;'])
%p+20*i


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radiobutton1,'value')==1                                         %判断保证只有一个radiobutton处于选中的状态
    set(handles.radiobutton2,'value',0);
    set(handles.radiobutton3,'value',0);
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.radiobutton2,'value')==1
    set(handles.radiobutton1,'value',0);
     set(handles.radiobutton3,'value',0);
end

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Initial;                                                                             %执行初始化的工作

set(handles.edit4,'string','参数载入完成，请点击优化布局按钮开始优化！')



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global OptimizationDaishu;

OptimizationDaishu=get(handles.edit3,'string');
OptimizationDaishu=str2num(OptimizationDaishu);


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)                              
set(handles.edit4,'string','');
GenerateNext;                                                                %执行优化过程
axes(handles.axes1);
global ccca;
global OptimizationDaishu;
global OutstandingIndividual;
global best;
x=1:1:OptimizationDaishu;                                                    %输出优化的曲线
y=ccca;
plot(x,y)
title('各代平均适应度函数曲线')
xlabel('代数（i）')
ylabel('适应度值')
grid;
axes(handles.axes2);
global BestGenerationFitness;
global BestGeneration;
%global OptimizationDaishu;
x=1:1:OptimizationDaishu;
y=BestGenerationFitness;
plot(x,y)
title('各代最优个体适应度函数曲线')
xlabel('代数（i）')
ylabel('适应度值')
grid;
%set(handles.edit4,'string','优化完成，请查看曲线')
[k1,k2]=max(BestGenerationFitness);
best=BestGeneration(k2,:);
k1=100000/k1;
a4=mat2str(k1);
%a1=mat2str(best);
a1='优化完成';
a2=mat2str(best);
a5='最优个体成本（适应度）：'
a3=[a1 a2 a5 a4];
set(handles.edit4,'string',a3);
%disp(class(best));



% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
if get(handles.radiobutton3,'value')==1
    set(handles.radiobutton1,'value',0);
     set(handles.radiobutton2,'value',0);
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;
axes(handles.axes2);
cla;
cl;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called