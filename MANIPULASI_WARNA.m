function varargout = MANIPULASI_WARNA(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MANIPULASI_WARNA_OpeningFcn, ...
                   'gui_OutputFcn',  @MANIPULASI_WARNA_OutputFcn, ...
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


function MANIPULASI_WARNA_OpeningFcn(hObject, eventdata, handles, varargin)
% INISIALISASI VARIABEL
handles.output = hObject;
handles.img = [];

handles.default_slider_val = get(handles.slider1, 'Value');
handles.default_slider_min = get(handles.slider1, 'Min');
handles.default_slider_max = get(handles.slider1, 'Max');

set(handles.txtValue, 'String', sprintf('%.2f', handles.default_slider_val));
guidata(hObject, handles);


function varargout = MANIPULASI_WARNA_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;



% LOAD IMAGE BUTTON 
function btnLoad_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files'});
if isequal(filename,0)
    return;
end

img = imread(fullfile(pathname, filename));
handles.img = img;

axes(handles.axes1);
imshow(img);
title('Citra Asli');

axes(handles.axes2);
imshow(img);
title('Hasil Manipulasi');

set(handles.popupManipulasi, 'Value', 1);
set(handles.slider1, 'Value', handles.default_slider_val);
set(handles.txtValue, 'String', sprintf('%.2f', handles.default_slider_val));

applyManipulation(handles);
guidata(hObject, handles);

% POPUP MANIPULATION 
function popupManipulasi_Callback(hObject, eventdata, handles)
opsi = get(hObject, 'Value');

switch opsi
    case 1  % No Manipulation
        set(handles.slider1, 'Min', handles.default_slider_min, ...
                             'Max', handles.default_slider_max, ...
                             'Value', handles.default_slider_val);

    case 2  % Brightness
        set(handles.slider1, 'Min', -100, 'Max', 100, 'Value', 0);

    case 3  % Red Gain
        set(handles.slider1, 'Min', 0.0, 'Max', 5.0, 'Value', 1.0);

    case 4  % Saturation
        set(handles.slider1, 'Min', 0.0, 'Max', 2.0, 'Value', 1.0);

    case 5  % Color Inversion 
        set(handles.slider1, 'Min', 0, 'Max', 1, 'Value', 1);
end

val = get(handles.slider1, 'Value');
set(handles.txtValue, 'String', sprintf('%.2f', val));

applyManipulation(handles);


function popupManipulasi_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% SLIDER UPDATE 
function slider1_Callback(hObject, eventdata, handles)
val = get(handles.slider1, 'Value');
set(handles.txtValue, 'String', sprintf('%.2f', val));
applyManipulation(handles);


function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% PROSES MANIPULASI
function applyManipulation(handles)
if isempty(handles.img)
    return;
end

img = handles.img;
val = get(handles.slider1, 'Value');
opsi = get(handles.popupManipulasi, 'Value');

switch opsi
    case 1
        hasil = img;
        
    case 2
        img_double = double(img);
        hasil_double = img_double + val;
        hasil_double(hasil_double > 255) = 255;
        hasil_double(hasil_double < 0) = 0;
        hasil = uint8(hasil_double);
        set(handles.slider1, 'Visible', 'on');
        set(handles.txtValue, 'Visible', 'on');
    case 3
        hasil = img;
        R = double(img(:,:,1)) * val;
        R(R > 255) = 255;
        hasil(:,:,1) = uint8(R);
        set(handles.slider1, 'Visible', 'on');
        set(handles.txtValue, 'Visible', 'on');
    case 4
        hsv = rgb2hsv(img);
        hsv(:,:,2) = hsv(:,:,2) * val;
        hsv(hsv > 1) = 1;
        hasil = hsv2rgb(hsv);
        hasil = im2uint8(hasil);
        set(handles.slider1, 'Visible', 'on');
        set(handles.txtValue, 'Visible', 'on');
    case 5
        hasil = 255 - img;
        set(handles.slider1, 'Visible', 'off');
        set(handles.txtValue, 'Visible', 'off');
end

% ----- TAMPILKAN HASIL -----
axes(handles.axes2);
imshow(hasil);
title('Hasil Manipulasi');

% ----- TAMPILKAN HISTOGRAM -----
axes(handles.axes3);
imhist(hasil);
title('Histogram Hasil Manipulasi');


% --- Executes during object creation, after setting all properties.
function txtValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
