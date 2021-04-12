function xyzTriangles = makeRectangularPrism(length,width,height,center)
    %xyzTriangles is 3X3X12 matrix, where is the number of triangles that
    %makes up a rectangular prism, columns are x, y, and z, rows are points
    cx = center(1);
    cy = center(2);
    cz = center(3);
    xyzTriangles = zeros(3,3,12);
    upperLeftFrontVertex = [cx+width/2 , cy-length/2 , cz + height/2]; 
    lowerLeftFrontVertex = [cx+width/2 , cy-length/2 , cz - height/2];
    upperRightFrontVertex = [cx+width/2 , cy+length/2 , cz + height/2];
    lowerRightFrontVertex = [cx+width/2 , cy+length/2 , cz - height/2];
    upperRightBackVertex = [cx-width/2 , cy+length/2 , cz + height/2];
    lowerRightBackVertex = [cx-width/2 , cy+length/2 , cz - height/2];
    upperLeftBackVertex = [cx-width/2 , cy-length/2 , cz + height/2];
    lowerLeftBackVertex = [cx-width/2 , cy-length/2 , cz - height/2];
    xyzTriangles(:,:,1) = [upperLeftFrontVertex ; upperRightFrontVertex; lowerLeftFrontVertex];
    xyzTriangles(:,:,2) = [lowerLeftFrontVertex ; lowerRightFrontVertex; upperRightFrontVertex];
    xyzTriangles(:,:,3) = [lowerLeftFrontVertex ; lowerLeftBackVertex ; upperLeftBackVertex];
    xyzTriangles(:,:,4) = [lowerLeftFrontVertex ; upperLeftFrontVertex ; upperLeftBackVertex];
    xyzTriangles(:,:,5) = [upperLeftBackVertex ; upperLeftFrontVertex ; upperRightFrontVertex];
    xyzTriangles(:,:,6) = [upperLeftBackVertex ; upperRightBackVertex ; upperRightFrontVertex];
    xyzTriangles(:,:,7) = [lowerLeftFrontVertex ; lowerRightFrontVertex ; lowerLeftBackVertex];
    xyzTriangles(:,:,8) = [lowerRightFrontVertex ; lowerRightBackVertex ; lowerLeftBackVertex];
    xyzTriangles(:,:,9) = [lowerLeftBackVertex ; lowerRightBackVertex ; upperLeftBackVertex];
    xyzTriangles(:,:,10) = [upperRightBackVertex ; upperLeftBackVertex ; lowerRightBackVertex];
    xyzTriangles(:,:,11) = [lowerRightFrontVertex ; lowerRightBackVertex ; upperRightBackVertex];
    xyzTriangles(:,:,12) = [lowerRightFrontVertex ; upperRightFrontVertex ; upperRightBackVertex];
end

