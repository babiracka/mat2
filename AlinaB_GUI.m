function varargout = AlinaB_GUI(varargin)
% ALINAB_GUI MATLAB code for AlinaB_GUI.fig
%      ALINAB_GUI, by itself, creates a new ALINAB_GUI or raises the existing
%      singleton*.
%
%      H = ALINAB_GUI returns the handle to a new ALINAB_GUI or the handle to
%      the existing singleton*.
%
%      ALINAB_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALINAB_GUI.M with the given input arguments.
%
%      ALINAB_GUI('Property','Value',...) creates a new ALINAB_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AlinaB_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AlinaB_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AlinaB_GUI

% Last Modified by GUIDE v2.5 16-Jan-2015 11:52:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @AlinaB_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @AlinaB_GUI_OutputFcn, ...
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


% --- Executes just before AlinaB_GUI is made visible.
function AlinaB_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AlinaB_GUI (see VARARGIN)

% Choose default command line output for AlinaB_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AlinaB_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AlinaB_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename1, filepath1] = uigetfile({'*.csv','Pliki CSV'},'Wybór danych do analizy');
cd(filepath1);
arkusz=dataset('File',filename1,'Delimiter',',');
setGlobalArk(arkusz);
for k=1:length(arkusz)
    c(k)=arkusz.Genus(k);
end
rodzaje=unique(c);
cRodz=['Wybierz rodzaj', rodzaje]
%Zmiana napisu na pushbt
set(hObject,'String','Wybrano plik!')
%Uaktywnienie przycisków po za³adowaniu plików
set(handles.listaRo,'String',cRodz,'Enable','on')
set(handles.rbGatunek,'Enable','on')
set(handles.rbRodzaj,'Enable','on')


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if (get(handles.rbGatunek,'Value')==1)  %&((get(handles.listaRo,'Value'))==0))
    set(handles.listaGa,'Enable','on')%'String','Proszê najpierw wybraæ rodzaj')
elseif (get(handles.rbRodzaj,'Value')==1)
    set(handles.listaGa,'Enable','off')
end

%end


% --- Executes on selection change in listaRo.
function listaRo_Callback(hObject, eventdata, handles)
% hObject    handle to listaRo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listaRo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listaRo
wybR=get(hObject,'Value'); %który element jest wybrany (wartoœæ liczbowa)
cR=get(hObject,'String'); %lista wszystkich mo¿liwych wartoœci (odpowiednik zmiennej cRodz)
wybRodz=cR(wybR)
dane=getGlobalArk;
% coœ errorzy
%if ((cR=='Wybierz rodzaj')&(get(handles.rbGatunek,'Value'))==1)
 %  set(handles.listaGa,'String','Proszê najpierw wybraæ rodzaj')
%end


%Ustawienie wartoœci na liœcie gatunków:




% --- Executes during object creation, after setting all properties.
function listaRo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listaRo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listaGa.
function listaGa_Callback(hObject, eventdata, handles)
% hObject    handle to listaGa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listaGa contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listaGa


% --- Executes during object creation, after setting all properties.
function listaGa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listaGa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function plikMenu_Callback(hObject, eventdata, handles)
% hObject    handle to plikMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function instrukcja_Callback(hObject, eventdata, handles)
% hObject    handle to instrukcja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function zakoncz_Callback(hObject, eventdata, handles)
% hObject    handle to zakoncz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --------------------------------------------------------------------
function zapWykres_Callback(hObject, eventdata, handles)
% hObject    handle to zapWykres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function zapArkusz_Callback(hObject, eventdata, handles)
% hObject    handle to zapArkusz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


