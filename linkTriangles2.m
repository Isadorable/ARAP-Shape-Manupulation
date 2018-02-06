%This function creates a link between every control point and the
%corresponding vertex in the mesh
function [ linkedTriangle ] = linkTriangles2(hObject)
handles = guidata(hObject);
linkedTriangle = handles.linkedTriangle;
distV = inf;

for i= 1 : size(handles.handlesCoordinates,1)
    
    if linkedTriangle(i,1) == 0
        for j=1:size(handles.E,1)
            distTemp = sqrt((handles.V(handles.E(j,1),1)-handles.handlesCoordinates(i,1))^2+(handles.V(handles.E(j,1),2)-handles.handlesCoordinates(i,2))^2);
            if distV > distTemp;
                distV = distTemp;
                linkedTriangle(i,:) = [j,1];
            end
            distTemp = sqrt((handles.V(handles.E(j,2),1)-handles.handlesCoordinates(i,1))^2+(handles.V(handles.E(j,2),2)-handles.handlesCoordinates(i,2))^2);
            if distV > distTemp;
                distV = distTemp;
                linkedTriangle(i,:) = [j,2];
            end
        end
        distV = inf;
    end
end

end


