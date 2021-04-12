function doesIntersect = checkIfLineSegmentIntersectsTriangle(lineSegment,triangleVertices)
    doesIntersect = true;
    [a,b,c,x0,y0,z0] = getLineFromTwoPoints(lineSegment);
    [A,B,C,D] = getPlaneFromThreePoints(triangleVertices);
    [t, x, y , z] = getLineIntersectionOfPlane([a,b,c,x0,y0,z0],[A,B,C,D]);
    if t > 1 | t < 0
        doesIntersect = false;
        return
    end
    if ~checkIfPointIsInsideTriangle(triangleVertices, [x,y,z])
        doesIntersect = false;
        return
    end
end

