%% A BEAM WITH A FORCE AT THE END
% planar case

clear
close all
clc

%% BEAM DATA
d = 0.002; % diameter [m]
L = 0.5; % length [m]
E = 36*10^9; % Young modulus [Pa]
rho = 1800; % beam density [Kg/m^3]

A = pi*d^2/4; % area
I = pi*d^4/64; % flexural inertia moment

%% EXTERNAL LOADS

g = [0;-9.81]; % gravity [N/m]
fd = rho*A*g; % distributed gravitational load [N/m];
fend = [0;-.2]; % tip load [N]

%% NUMERICAL SOLUTION
y0 = zeros(3,1); % initial guess
% Commented below for octave
%options = optimoptions('fsolve','display','iter-detailed');

fun = @(y) beamShooting(y,E,I,L,fd,fend); % objective fcn

y = fsolve(fun,y0); % solution

%% RECONSTRUCT SHAPE

y0 = [zeros(3,1);y];

% integrate ODEs
fun = @(s,y) odefunKirchhoff(s,y,E*I,fd);
[s,y] = ode45(fun,[0,L],y0);

Nplot = 1000; % n° of plot points
sr = linspace(0,L,Nplot); % refined abscissa
% spline px py th
px = spline(s,y(:,1),sr); % px [m]
py = spline(s,y(:,2),sr); % py [m]
th = spline(s,y(:,3),sr); % th [rad]
nx = spline(s,y(:,4),sr); % nx [N]
ny = spline(s,y(:,5),sr); % ny [N]
mz = spline(s,y(:,6),sr); % mz [Nm]

u = mz/(E*I); % curvature [1/m]

figure(1)
plot(px,py,'LineWidth',2)
hold on
quiver(px(end),py(end),fend(1),fend(2),'LineWidth',2)
grid minor
xlabel('x [m]')
ylabel('y [m]')
axis equal
axis([0 2*L -L L])

figure(2)
plot(px,mz,'LineWidth',2)
hold on
quiver(px(end),py(end),fend(1),fend(2),'LineWidth',2)
grid minor
xlabel('x [m]')
ylabel('y [m]')
axis equal
axis([0 2*L -L L])

figure(3)
plot(px,nx,'LineWidth',2)
hold on
quiver(px(end),py(end),fend(1),fend(2),'LineWidth',2)
grid minor
xlabel('x [m]')
ylabel('y [m]')
axis equal
axis([0 2*L -L L])

figure(4)
plot(px,ny,'LineWidth',2)
hold on
quiver(px(end),py(end),fend(1),fend(2),'LineWidth',2)
grid minor
xlabel('x [m]')
ylabel('y [m]')
axis equal
axis([0 2*L -L L])