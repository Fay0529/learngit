function varargout = Hill2(varargin)
% HILL2 MATLAB code for Hill2.fig
%      HILL2, by itself, creates a new HILL2 or raises the existing
%      singleton*.
%
%      H = HILL2 returns the handle to a new HILL2 or the handle to
%      the existing singleton*.
%
%      HILL2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HILL2.M with the given input arguments.
%
%      HILL2('Property','Value',...) creates a new HILL2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Hill2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Hill2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Hill2

% Last Modified by GUIDE v2.5 02-May-2017 19:52:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Hill2_OpeningFcn, ...
                   'gui_OutputFcn',  @Hill2_OutputFcn, ...
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


% --- Executes just before Hill2 is made visible.
function Hill2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Hill2 (see VARARGIN)

% Choose default command line output for Hill2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gcf,'numbertitle','off','name','Hill2加密、解密以及破解工具 作者：陈小飞 学号 09015137');
% UIWAIT makes Hill2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Hill2_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=get(handles.edit1,'String');
str=str-64;
% disp(str);
%加密矩阵是个2*2的矩阵
s = str2num(get(handles.edit5,'String'));
A =[s(1),s(2);s(3),s(4)];
% disp(A);
sz=size(str);
if mod(sz(2),2)~=0%检验是不是偶数个,如果不是就后面加一个
str(sz(2)+1)=str(sz(2));
end
sz=size(str);

m=sz(2)/2;%矩阵的列数
s1=zeros(2,m);
for i=1:2:sz(2)-1%下面把要加密的字符串改成对应的矩阵
    s1(1,(1+i)/2)=str(i);
    
end
for i=2:2:sz(2)
    s1(2,i/2)=str(i);
end

s2=mod(A*s1,26);

for i=1:m%下面把得到密文的矩阵变成字符串
    answer(i*2-1)=char(s2(1,i)+64);
    answer(i*2)=char(s2(2,i)+64);
end
set(handles.edit4,'String',answer);
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=get(handles.edit1,'String');
str=str-64;
s = str2num(get(handles.edit5,'String'));
A =[s(1),s(2);s(3),s(4)];
% 下面求A的模26逆
if gcd(fix(det(A)),26)==1
    switch mod(fix(det(A)),26)
     case 1
        a=1;
    case 3
        a=9;
    case 5
        a=21;
    case 7 
        a=15;
    case 9
        a=3;
    case 11
        a=19;
    case 15
        a=7;
    case 17
        a=23;
    case 19
        a=11;
    case 21
        a=5;
    case 23
        a=17;
    case 25
        a=25;
    end
        
    b=[A(2,2),-A(1,2);-A(2,1),A(1,1)];
    b=mod(b,26);
    B=mod(a*b,26);
end
sz=size(str);
if mod(sz(2),2)~=0%检验是不是偶数个,如果不是就后面加一个
h=warndlg('请输入偶数个密文','输入错误','modal');  
str=get(handles.edit1,'String');
str=str-64;
end
sz=size(str);

m=sz(2)/2;%矩阵的列数
s1=zeros(2,m);
for i=1:2:sz(2)-1%下面把密文的字符串改成对应的矩阵
    s1(1,(1+i)/2)=str(i);
    
end
for i=2:2:sz(2)
    s1(2,i/2)=str(i);
end

s2=mod(B*s1,26);

for i=1:m%下面把得到密文的矩阵变成字符串
    answer(i*2-1)=char(s2(1,i)+64);
    answer(i*2)=char(s2(2,i)+64);
end
set(handles.edit4,'String',answer);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=get(handles.edit1,'String');
Q=get(handles.edit2,'String');
P=get(handles.edit3,'String');
P=P-64;
Q=Q-64;
p=[P(1),P(3);P(2),P(4)];
q=[Q(1),Q(3);Q(2),Q(4)];
% 一下代码求q模26逆
    
switch mod(q(1,1)*q(2,2)-q(2,1)*q(1,2),26)
    case 1
        a=1;
    case 3
        a=9;
    case 5
        a=21;
    case 7 
        a=15;
    case 9
        a=3;
    case 11
        a=19;
    case 15
        a=7;
    case 17
        a=23;
    case 19
        a=11;
    case 21
        a=5;
    case 23
        a=17;
    case 25
        a=25;
  end
    b=[q(2,2),-q(1,2);-q(2,1),q(1,1)];
    b=mod(b,26);
    B=mod(a*b,26);

B=mod(p*B,26);
sz=size(str);
if mod(sz(2),2)~=0%检验是不是偶数个,如果不是就后面加一个
h=warndlg('请输入偶数个密文','输入错误','modal');  
str=get(handles.edit1,'String');
str=str-64;
end
sz=size(str);
str=str-64;
m=sz(2)/2;%矩阵的列数
s1=zeros(2,m);
for i=1:2:sz(2)-1%下面把密文的字符串改成对应的矩阵
    s1(1,(1+i)/2)=str(i);
    
end
for i=2:2:sz(2)
    s1(2,i/2)=str(i);
end

s2=mod(B*s1,26);

for i=1:m%下面把得到密文的矩阵变成字符串
    answer(i*2-1)=char(s2(1,i)+64);
    answer(i*2)=char(s2(2,i)+64);
end
set(handles.edit4,'String',answer);

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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
