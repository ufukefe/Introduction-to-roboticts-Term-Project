%Kinematic model of the system
clear; clc;
%define generalized coordinates as symbolic variables
syms q1 q2 q3 q4 q5 q6 q7 q8;

%a values
a1=0; a2=0; a3=0; a5=0; a6=0; a7=0; a8=0;

%alpha values, in degrees, otherwise cos(-pi/2) gives erros in machine
%epsilon
alpha = [-90; -90; 0; 0; 90; -90; 90; 0];

%d values
d4 = 0; d5 = 0; d6=0; d7 = 0;

%non-symbolic theta values, in degrees as in the case of alpha
theta1 = 90; theta2 = -90; theta3 = 0; theta4 = 0; theta6 = 0; theta8 = 0;

%symbolic assignments
d1 = q1;    d2 = q2;   d3 = q3;    a4 = 0; 
theta5 = q5;    d5 = q5;
theta7 = q7;    d8 = q8;

A1_0 = [ cosd(theta1)    -cosd(alpha(1))*sind(theta1)     sind(alpha(1))*sind(theta1)      a1*cosd(theta1)
         sind(theta1)    cosd(alpha(1))*cosd(theta1)      -sind(alpha(1))*cosd(theta1)     a1*sind(theta1)
         0              sind(alpha(1))                  cosd(alpha(1))                  d1
         0              0                               0                               1];
     
A2_1 = [ cosd(theta2)    -cosd(alpha(2))*sind(theta2)     sind(alpha(2))*sind(theta2)      a2*cosd(theta2)
         sind(theta2)    cosd(alpha(2))*cosd(theta2)      -sind(alpha(2))*cosd(theta2)     a2*sind(theta2)
         0              sind(alpha(2))                  cosd(alpha(2))                  d2
         0              0                               0                               1];
     
A3_2 = [ cosd(theta3)    -cosd(alpha(3))*sind(theta3)   sind(alpha(3))*sind(theta3)     a3*cosd(theta3)
         sind(theta3)    cosd(alpha(3))*cosd(theta3)    -sind(alpha(3))*cosd(theta3)    a3*sind(theta3)
         0               sind(alpha(3))                 cosd(alpha(3))                  d3
         0               0                              0                               1];

% Second body
A4_3 = [ cosd(theta4)    -cosd(alpha(4))*sind(theta4)     sind(alpha(4))*sind(theta4)      a4*cosd(theta4)
         sind(theta4)    cosd(alpha(4))*cosd(theta4)      -sind(alpha(4))*cosd(theta4)     a4*sind(theta4)
         0              sind(alpha(4))                  cosd(alpha(4))                  d4
         0              0                               0                               1];
     
A5_4 = [ cos(theta5)    -cosd(alpha(5))*sin(theta5)     sind(alpha(5))*sin(theta5)      a5*cos(theta5)
         sin(theta5)    cosd(alpha(5))*cos(theta5)      -sind(alpha(5))*cos(theta5)     a5*sin(theta5)
         0              sind(alpha(5))                  cosd(alpha(5))                  d5
         0              0                               0                               1];
     
A6_5 = [ cosd(theta6)    -cosd(alpha(6))*sind(theta6)   sind(alpha(6))*sind(theta6)     a6*cosd(theta6)
         sind(theta6)    cosd(alpha(6))*cosd(theta6)    -sind(alpha(6))*cosd(theta6)    a6*sind(theta6)
         0               sind(alpha(6))                 cosd(alpha(6))                  d6
         0               0                              0                               1];

%third body
A7_6 = [ cos(theta7)    -cosd(alpha(7))*sin(theta7)     sind(alpha(7))*sin(theta7)      a7*cos(theta7)
         sin(theta7)    cosd(alpha(7))*cos(theta7)      -sind(alpha(7))*cos(theta7)     a7*sin(theta7)
         0              sind(alpha(7))                  cosd(alpha(7))                  d7
         0              0                               0                               1];
     
A8_7 = [ cosd(theta8)    -cosd(alpha(8))*sind(theta8)     sind(alpha(8))*sind(theta8)      a8*cosd(theta8)
         sind(theta8)    cosd(alpha(8))*cosd(theta8)      -sind(alpha(8))*cosd(theta8)     a8*sind(theta8)
         0              sind(alpha(8))                  cosd(alpha(8))                  d8
         0              0                               0                               1];
     
       
A8_0 = simplify(A1_0*A2_1*A3_2*A4_3*A5_4*A6_5*A7_6*A8_7);


