
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

% Last Modified by GUIDE v2.5 18-Jan-2015 18:23:27

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
%Zmiana napisu na pushbt
set(hObject,'String','Wybrano plik!')

%Uaktywnienie przycisków po za³adowaniu plików
set(handles.listaRo,'String',rodzaje,'Enable','on')
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


if (get(handles.rbGatunek,'Value')==1) 
   set(handles.listaGa,'Enable','on')
elseif (get(handles.rbRodzaj,'Value')==1)
   set(handles.listaGa,'Enable','off')
end






% --- Executes on selection change in listaRo.
function listaRo_Callback(hObject, eventdata, handles)
% hObject    handle to listaRo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

wybR=get(hObject,'Value'); %który element jest wybrany (wartoœæ liczbowa)
cR=get(hObject,'String'); %lista wszystkich mo¿liwych wartoœci (odpowiednik zmiennej cRodz)
wybG=get(handles.listaGa,'Value');
cG=get(handles.listaGa,'String');
wybRodz=cR(wybR)
dane=getGlobalArk;

listag=find(strcmp(dane.Genus,wybRodz)); %indeksy dla których genus==wybRodz
gatunki=[unique(dane(listag,3:4))]

spisGat=cellstr(gatunki(:,2))

 set(handles.listaGa,'String',spisGat)

% --- Executes on selection change in listaGa.
function listaGa_Callback(hObject, eventdata, handles)
% hObject    handle to listaGa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rysuj.

function rysuj_Callback(hObject, eventdata, handles)
% hObject    handle to rysuj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dane=getGlobalArk;
wybR=get(handles.listaRo,'Value');
wybG=get(handles.listaGa,'Value');
cR=get(handles.listaRo,'String');
cG=get(handles.listaGa,'String');
wybRodz=cR(wybR);
wybGat=cG(wybG);
stanG=get(handles.rbGatunek,'Value')
stanR=get(handles.rbRodzaj,'Value')
indeksyR=find(strcmp(dane.Genus,wybRodz));
indeksyG=find(strcmp(dane.species,wybGat));


%Ustawienie zmiennej listawag
switch stanR
    case 1 %analiza dla rodzaju
        listawag=dane(indeksyR,2)
        
      
    case 0 %analiza dla gatunku
        listawag=dane(indeksyG,2)
end

wektorwag=reshape(single(listawag),1,length(double(listawag)));
hist(wektorwag)
xlabel('Waga')
ylabel('Liczba osobników')


srednia=num2str(mean(wektorwag));
minimum=num2str(min(wektorwag));
maximum=num2str(max(wektorwag));
mediana=num2str(median(wektorwag));
stdowe=num2str(std(wektorwag));
set(handles.wsrednia,'String',strcat(srednia,' g'))
set(handles.min,'String',strcat(minimum,' g'))
set(handles.max,'String',strcat(maximum,' g'))
set(handles.std,'String',strcat(stdowe,' g'))
set(handles.mediana,'String',strcat(mediana,' g'))






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
h=msgbox({'1. Wybierz plik do analizy poprzed przycisk "Za³aduj plik z danymi".'...
    '2. Zaznacz, czy chcesz analizowaæ ca³y rodzaj, czy konkretny gatunek.'...
    '3. W przypadku analizy dla gatunku, oprócz rodzaju nalezy wybraæ równie¿ gatunek.'...
    '4. Aby zobaczyæ wykres oraz analizê statystyczn¹ danych, nale¿y nacisn¹æ przycisk "Rysuj".'...
    '5. Wybranie opcji "Plik...->Zapisz" skutkuje zapisaniem aktualnego wykresu do pliku .jpg'},...
'Instrukcja obs³ugi programu')

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

saveas(gcf,'mojwykres','jpg')


function std_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zapArkusz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zapArkusz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zapArkusz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function wsrednia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zapArkusz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function mediana_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zapArkusz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zapArkusz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Untitled_4_Callback(hObject, eventdata, handles)

