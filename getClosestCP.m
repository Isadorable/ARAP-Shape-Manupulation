%This function takes the coordinates of the mouse pointer and return the
%index of the closest handle
function [closestPointID] = getClosestCP(hObject)
handles = guidata(hObject);
dist = inf;

for i = 1 : size(handles.handlesCoordinates,1)
    %find the closest handle
    %for each edge we check the disctance between pointer coordinates and
    %vertices coordinates. We save value and line index of the closest one
    distTemp = sqrt((handles.down_pos(1,1)-handles.handlesCoordinates(i,1))^2+(handles.down_pos(1,2)-handles.handlesCoordinates(i,2))^2);
    if dist == inf
        closestPointID = 1;        
        dist = distTemp;
    elseif dist > distTemp
        dist = distTemp;
        closestPointID = i;
    end
end

end

