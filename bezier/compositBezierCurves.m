clear;
clc;
clf;

C1 = [0; 1; 3];
C2 = [3; 1.5; 2];
C3 = [3.5; 3; 7];
C4 = [4; 8; 9];
control_points = [C1,C2,C3,C4];
t = linspace(0,1,10);

p = cubicBezier3D(t,C1,C2,C3,C4);

figure(1)
plot3(p(1,:),p(2,:),p(3,:));
hold on
scatter3(control_points(1,:), control_points(2,:) , control_points(3,:));

C1 = [0; 1; 3];
C2 = [3; 1.5; 2];
C3 = [3.5; 3; 7];
C4 = [4; 8; 9];