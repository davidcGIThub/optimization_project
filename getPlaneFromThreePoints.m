%get equation for plane
function [A,B,C,D] = getPlaneFromThreePoints(xyzMatrix)
    %find equation of the form
    % Ax + By + Cz + D = 0
    point1 = xyzMatrix(1,:);
    point2 = xyzMatrix(2,:);
    point3 = xyzMatrix(3,:);
    vector1 = point2 - point1;
    vector2 = point3 - point1;
    orthogonalVector = cross(vector1,vector2);
    D = -dot(point1,orthogonalVector);
    A = orthogonalVector(1);
    B = orthogonalVector(2);
    C = orthogonalVector(3);
end