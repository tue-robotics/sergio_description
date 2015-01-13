clear all; close all; clc;
% get the measures from the design
% x is to the right, y is to the back, z is to te top

%% data from 3D model
% !! Use base top plate as reference for height
z_base_plate = 84.3;

% compute center shift points (set origin x,y to the wheel base center)
xcenter = (-29.7+220.3)/2;
xcenter2 = 94.8;
ycenter = (144.8-105.2)/2;

% base laser x y location
B_laser = [0; (-283.2-336.2)/2-ycenter]; % z to be determined

% Wheel positions (from design)
W_1 = [275 -265].';           % z to be determined
W_2 = [-275 -265].'; 
W_3 = [-275 265].';
W_4 = [275 265].';

% distance to front back left and right of the bottem plate
BP_left = [0; 406.8-xcenter; 0];
BP_right = [0; -216.2-xcenter; 0];
BP_front = [0; -313.2-ycenter; 0];
BP_back = [0; 399.8-ycenter; 0];
BP_bottom = [0;0;-11];


% torso points
A=[0		204.8-ycenter	140.8-z_base_plate].';
B=[0		104.7-ycenter	46.3-z_base_plate].';
C=[0		70.8-ycenter	46.3-z_base_plate].';
D=[0		-74.3-ycenter	373.0-z_base_plate].';
E=[0		-16.6-ycenter	413.1-z_base_plate].';
F=[0		-29.8-ycenter	429.4-z_base_plate].';
G=[0		-41.2-ycenter	443.4-z_base_plate].';
H=[0		-74.8-ycenter	474.4-z_base_plate].';
I=[0		-61.4-ycenter	496.1-z_base_plate].';
J=[0		213.5-ycenter	766.6-z_base_plate].';
K=[0		185.6-ycenter	840.5-z_base_plate].';
L=[0		89.8-ycenter	1220.0-z_base_plate].'; % center of the soulder rotation
L2 = [0		95.0-ycenter	1200.8-z_base_plate].'; % center of the shoulder hole

% laser tilt points
Q=[0		60.6-ycenter	1013.4-z_base_plate].';
R=[0		145.8-ycenter	1048.0-z_base_plate].';
S=[0		153.8-ycenter	1114.5-z_base_plate].';
T=[0		119.4-ycenter	1117.1-z_base_plate].';
U=[0		73.5-ycenter	1120.6-z_base_plate].';
V=[0		111.4-ycenter	1050.6-z_base_plate].';
W=[0		106.5-ycenter	1009.9-z_base_plate].';

% torso back plate
TB_bottom   = [239.6-ycenter	767.9-z_base_plate].';
TB_top      = [177.5-ycenter	1165.1-z_base_plate].';

% rear lag back plate
RL_bottom   = [191.9-ycenter   181.2-z_base_plate].';
RL_top      = [-13.4-ycenter   433.8-z_base_plate].';

% Head
HT_bottom   =[94.8-xcenter2	67.1-ycenter	1282.0-z_base_plate].';
HT_top      =[94.8-xcenter2	52.1-ycenter	1325.6-z_base_plate].';
% HP_right    =[73.7-xcenter2	55.4-ycenter	1352.1-z_base_plate].';
% HP_left     =[114.0-xcenter2	34.1-ycenter	1344.8-z_base_plate].';
HP_right = [74.3-xcenter2; 55.1-ycenter; 1352.0-z_base_plate];
HP_left = [115.3-xcenter2; 33.4-ycenter; 1344.6-z_base_plate];
HPT_center = (HP_left+HP_right)./2;

% Kinect			
HK_mount   =[93.6-xcenter2	30.7-ycenter	1381.6-z_base_plate].';

%% calculate origin head center w.r.t. hip coordinates
angle_HC = an(L,J,HPT_center);
HPT_x = cos(angle_HC)*di(J,HPT_center);
HPT_z = -sin(angle_HC)*di(J,HPT_center);

%% calculate head pan rotation axes w.r.t hip coordinates
rotation_pan = an(HPT_center-L,[0;0;0],L-J);

%% distance from head center rotation point to kinect mount
K_z = di(HPT_center,HK_mount);

%% calculate torso laser rotation center w.r.t. hip coordinates
% center
TL_axes = V+(U-T);
% angle w.r.t. hip
angle_TL_axes = an(L,J,TL_axes);
TL_x = cos(angle_TL_axes)*di(J,TL_axes);
TL_z = -sin(angle_TL_axes)*di(J,TL_axes);

% translation from center of rotation to center laser
dist_center_to_rotation = di(U,Q)/2-di(T,V);
dist_center_laser_to_source = 11.5;

offset_laser = dist_center_to_rotation+dist_center_laser_to_source;


%% torso masses
M_LFL  = 1;
M_LRL  = 2.5;
M_UL   = 5;
M_T    = 30+10;


