clear
close all
clc

%%%% Define Constants and Initial Conditions

r0_vec = [5371.844151186472; -4141.062031065303; 460.1400917227622]; % Initial Inertial Position Vector km
rdot0_vec = [3.230645742388105; 3.522344029484922; -5.981911152962826]; % Initial Inertial Velcoity Vector km/s
mu = 398600.64; % Earth Gravitational Coefficient km^3/s^2

% Numerically Integrate the Orbit Equation
time = (0:10:24*60*60); % time vector from 0 to 24 hours in 10 second intervals
options = odeset('AbsTol',1e-8,'RelTol',1e-8); % error tolerances
IC = [r0_vec ;rdot0_vec]; % Initial Conditions

[T,R] = ode45(@diffeq,time,IC,options); % ODE45 Simulation

% Plotting ODE45 Solution

radius_earth = 6378.1; % Radius of Earth Km

[x, y, z] = sphere;

x2 = x * radius_earth;
y2 = y * radius_earth;
z2 = z * radius_earth;

%%% Animation
for i = 1:length(time)
    figure(100)
    surf(x2,y2,z2)
    axis equal
    hold on
    plot3(R(i,1),R(i,2),R(i,3),'.r','markersize',14)
    xlabel('X [km]')
    ylabel('Y [km]')
    zlabel('Z [km]')
    title('ISS Orbit about Earth')
    legend('Earth','ISS')
    hold off;

    drawnow
end

% State Space Function of Orbit Equation For Ode45

function xdot = diffeq(t,x)

mu = 398600.64; % Earth Gravitational Coefficient km^3/s^2

rx = x(1,1); % x1 = rx
ry = x(2,1); % x2 = ry
rz = x(3,1); % x3 = rz
vx = x(4,1); % x4 = vx = x1dot
vy = x(5,1); % x5 = vy = x2dot
vz = x(6,1); % x6 = vz = x3dot

r = [rx ry rz]'; % Position vector in interial frame
rdot = [vx vy vz]'; % Velocity Vector in inertial frame

xdot(1:3,1) = rdot; % Velocity vector
xdot(4:6,1) = -mu*(r)/((norm(r))^3); % Orbit Equation in Vector Form
end

