%this function support the use of barycentric coordinate for the position
%of the control points. For every control point we create a new line in the
%matrix linkedTriangle, containing the id of the face in which it's
%included and the baricentric coordinates of the point
function [ linkedTriangle ] = linkTriangles(hObject)
handles = guidata(hObject);
linkedTriangle = handles.linkedTriangle;

for i= 1 : size(handles.handlesCoordinates,1)
    %find the closest vertex
    if handles.linkedTriangle(i,1) == 0
        for j = 1:size(handles.F)
            p1 = handles.V(handles.F(j,1),1:2);
            p2 = handles.V(handles.F(j,2),1:2);
            p3 = handles.V(handles.F(j,3),1:2);
            
            %PARAMETRICAL METHOD
            Area = 1/2*(-p2(2)*p3(1) + p1(2)*(-p2(1) + p3(1)) + p1(1)*(p2(2) - p3(2)) + p2(1)*p3(2));
            w1 = 1/(2*Area)*(p1(2)*p3(1) - p1(1)*p3(2) + (p3(2) - p1(2))*handles.handlesCoordinates(i,1) + (p1(1) - p3(1))*handles.handlesCoordinates(i,2));
            w2 = 1/(2*Area)*(p1(1)*p2(2) - p1(2)*p2(1) + (p1(2) - p2(2))*handles.handlesCoordinates(i,1) + (p2(1) - p1(1))*handles.handlesCoordinates(i,2));
            w3 = 1-w1-w2;
            if(w1 >= 0 && w1 <= 1 && w2 >= 0 && w2 <= 1 && (w1+w2) <=1)
                if isequal(round(10000*(w1*p1+w2*p2+w3*p3))/10000,round(10000*handles.handlesCoordinates(i,:))/10000)
                    linkedTriangle(i,:) = [j, w1, w2, w3];
                elseif isequal(round(10000*(w2*p1+w1*p2+w3*p3))/10000,round(10000*handles.handlesCoordinates(i,:))/10000)
                    linkedTriangle(i,:) = [j, w2, w1, w3];
                elseif isequal(round(10000*(w2*p1+w3*p2+w1*p3))/10000,round(10000*handles.handlesCoordinates(i,:))/10000)
                    linkedTriangle(i,:) = [j, w2, w3, w1];
                elseif isequal(round(10000*(w3*p1+w2*p2+w1*p3))/10000,round(10000*handles.handlesCoordinates(i,:))/10000)
                    linkedTriangle(i,:) = [j, w3, w2, w1];
                elseif isequal(round(10000*(w3*p1+w1*p2+w2*p3))/10000,round(10000*handles.handlesCoordinates(i,:))/10000)
                    linkedTriangle(i,:) = [j, w3, w1, w2];
                else
                    linkedTriangle(i,:) = [j, w1, w3, w2];
                end
                
            end
        end
    end
end

end

