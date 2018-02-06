function varargout = ui(varargin)
% See also: GUIDE, GUIDATA, GUIHANDLES
% Last Modified by GUIDE v2.5 27-Mar-2016 15:28:12

% Begin initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui_OpeningFcn, ...
                   'gui_OutputFcn',  @ui_OutputFcn, ...
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
% End initialization code


% --- Executes just before ui is made visible.
function ui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ui (see VARARGIN)

handles.output = hObject;
handles.pose = 1;
%Load mesh file
fileName = 'man.obj';
[handles.F, handles.V, handles.E] = loadFile(fileName);
%store original faces, vertices and edges in case we want to reset the
%deformation
handles.originalF = handles.F;
handles.originalV = handles.V;
handles.originalE = handles.E;

%call the main function
guidata(hObject, handles);
deformationManager(hObject);

% Update handles structure
guidata(hObject, handles);


%%%%WINDOW MANAGER%%%%
% --- Outputs from this function are returned to the command line.
function varargout = ui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton2.
%The user needs to deform the mesh using barycentric coordinates
%reset the mesh and call the function for barycentric coordinates
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear(hObject);
deformationManager(hObject);

% --- Executes on button press in pushbutton3.
%The user needs to deform the mesh using vertices coordinates
%reset the mesh and call the function for vertices coordinates
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear(hObject);
deformationManager2(hObject);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
% writeMesh(hObject)


%reset deformed mesh
function clear(hObject)
    handles = guidata(hObject);
    
    %delete previous handles and display the original mesh
    delete(findobj(gca, 'type', 'scatter'));
    plot = trisurf(handles.F, handles.V(:,1), handles.V(:,2), zeros(size(handles.V,1),1),'FaceColor','interp');

    %2D view
    view(2);
    axis off
    hold on
    
    %set the windows size
    set(gca,'xlim',[-2 2],'ylim',[-1.5 2],'zlim',[0 1]);
    set(plot,'Parent', handles.axes1);
    
    guidata(hObject,handles);
 

% function writeMesh(hObject)
% handles = guidata(hObject);
% name = ['man',+num2str(handles.pose)+'.obj'];
% file = fopen(name,'w');
% 
% for i=1:size(handles.V,1)
%     fprintf(file,'v %d %d %d\n',handles.V(i,1),handles.V(i,2),handles.V(i,3));
% end
% for i=1:size(handles.F,1)
%     fprintf(file,'f %d %d %d\n',handles.F(i,1),handles.F(i,2),handles.F(i,3));
% end
% 
% fclose(file);