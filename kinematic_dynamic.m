%Kinematic model of the system
clear; clc;
%define generalized coordinates as symbolic variables
syms q1 q2 q3 q4 q5 q6 q7 q8;
q = [q1 q2 q3 q4 q5 q6 q7 q8];

%a values
a1=0; a2=0; a3=0; a5=0; a6=0; a7=0; a8=0;  a4=10; 

%alpha values, in degrees, otherwise cos(-pi/2) gives erros in machine
%epsilon
alpha = [-90; -90; 0; 0; 90; -90; 90; 0];

%d values
d = [q1; q2; q3; 0; 0; q6; 0; q8];

%theta values

% theta = [90; -90; 0; 0; q5; 0; q7; 0]

%non-symbolic theta values, in degrees as in the case of alpha
theta1 = 90; theta2 = -90; theta3 = 0; theta4 = 0; theta6 = 0; theta8 = 0;

%symbolic assignments for thetas
 
theta5 = q5;    d6 = q6;
theta7 = q7;    d8 = q8;

% Body of the creature
A1_0 = [ cosd(theta1)    -cosd(alpha(1))*sind(theta1)     sind(alpha(1))*sind(theta1)      a1*cosd(theta1)
         sind(theta1)    cosd(alpha(1))*cosd(theta1)      -sind(alpha(1))*cosd(theta1)     a1*sind(theta1)
         0              sind(alpha(1))                  cosd(alpha(1))                  d(1)
         0              0                               0                               1];
     
A2_1 = [ cosd(theta2)    -cosd(alpha(2))*sind(theta2)     sind(alpha(2))*sind(theta2)      a2*cosd(theta2)
         sind(theta2)    cosd(alpha(2))*cosd(theta2)      -sind(alpha(2))*cosd(theta2)     a2*sind(theta2)
         0              sind(alpha(2))                  cosd(alpha(2))                  d(2)
         0              0                               0                               1];
     
A3_2 = [ cosd(theta3)    -cosd(alpha(3))*sind(theta3)   sind(alpha(3))*sind(theta3)     a3*cosd(theta3)
         sind(theta3)    cosd(alpha(3))*cosd(theta3)    -sind(alpha(3))*cosd(theta3)    a3*sind(theta3)
         0               sind(alpha(3))                 cosd(alpha(3))                  d(3)
         0               0                              0                               1];

% Tongue
A4_3 = [ cosd(theta4)    -cosd(alpha(4))*sind(theta4)     sind(alpha(4))*sind(theta4)      a4*cosd(theta4)
         sind(theta4)    cosd(alpha(4))*cosd(theta4)      -sind(alpha(4))*cosd(theta4)     a4*sind(theta4)
         0              sind(alpha(4))                  cosd(alpha(4))                  d(4)
         0              0                               0                               1];
     
A5_4 = [ cos(theta5)    -cosd(alpha(5))*sin(theta5)     sind(alpha(5))*sin(theta5)      a5*cos(theta5)
         sin(theta5)    cosd(alpha(5))*cos(theta5)      -sind(alpha(5))*cos(theta5)     a5*sin(theta5)
         0              sind(alpha(5))                  cosd(alpha(5))                  d(5)
         0              0                               0                               1];
     
A6_5 = [ cosd(theta6)    -cosd(alpha(6))*sind(theta6)   sind(alpha(6))*sind(theta6)     a6*cosd(theta6)
         sind(theta6)    cosd(alpha(6))*cosd(theta6)    -sind(alpha(6))*cosd(theta6)    a6*sind(theta6)
         0               sind(alpha(6))                 cosd(alpha(6))                  d(6)
         0               0                              0                               1];
     
A7_6 = [ cos(theta7)    -cosd(alpha(7))*sin(theta7)     sind(alpha(7))*sin(theta7)      a7*cos(theta7)
         sin(theta7)    cosd(alpha(7))*cos(theta7)      -sind(alpha(7))*cos(theta7)     a7*sin(theta7)
         0              sind(alpha(7))                  cosd(alpha(7))                  d(7)
         0              0                               0                               1];
     
A8_7 = [ cosd(theta8)    -cosd(alpha(8))*sind(theta8)     sind(alpha(8))*sind(theta8)      a8*cosd(theta8)
         sind(theta8)    cosd(alpha(8))*cosd(theta8)      -sind(alpha(8))*cosd(theta8)     a8*sind(theta8)
         0              sind(alpha(8))                  cosd(alpha(8))                  d(8)
         0              0                               0                               1];
     
       
A8_0 = simplify(A1_0*A2_1*A3_2*A4_3*A5_4*A6_5*A7_6*A8_7);

A(:,:,1) = A1_0;
A(:,:,2) = A2_1;
A(:,:,3) = A3_2;
A(:,:,4) = A4_3;
A(:,:,5) = A5_4;
A(:,:,6) = A6_5;
A(:,:,7) = A7_6;
A(:,:,8) = A8_7;

isPrismatic = [true; true; true; false; false; true; false; true];
           

U = sym(zeros(4,4,length(d),length(d)));
A_j_1_i = sym(zeros(4,4,length(d)+1,length(d)+1));

Qrev = [0 -1 0 0
        1 0  0 0
        0 0  0 0
        0 0  0 0];
    
Qpris =[0 0  0 0
        0 0  0 0
        0 0  0 1
        0 0  0 0];
    
for i = 1:(length(d)+1)
    A_j_1_i(:,:,i,i) = sym(eye(4,4));
end
%A_j_1_i(:,:,1,2) = A_j_1_i(:,:,1,1)*A(:,:,1);
%A_j_1_i(:,:,1,3) = A_j_1_i(:,:,1,2)*A(:,:,2);
%A_j_1_i(:,:,1,4) = A_j_1_i(:,:,1,3)*A(:,:,3);

%A_j_1_i(:,:,1,13) = A_j_1_i(:,:,1,12)*A(:,:,12);
for i=1:(length(d)+1)
    for j=(i+1):(length(d)+1)
        A_j_1_i(:,:,i,j) = (A_j_1_i(:,:,i,j-1)*A(:,:,j-1));
        %disp([i j]);
    end
end

%disp(A_0_12-A_j_1_i(:,:,1,13))
%disp(A(:,:,12)-A_j_1_i(:,:,12,13))
%disp(A(:,:,1)*A(:,:,2)-A_j_1_i(:,:,1,3))

for i=1:(length(d))
    for j=1:i
        if(isPrismatic(j))
            U(:,:,i,j) = A_j_1_i(:,:,1,j)*Qpris*A_j_1_i(:,:,j,i+1);
        else
            U(:,:,i,j) = A_j_1_i(:,:,1,j)*Qrev*A_j_1_i(:,:,j,i+1);   
        end
    end
end

%disp(simplify(U(:,:,12,4)-diff(A_j_1_i(:,:,1,13),q4)))
%disp(simplify(U(:,:,10,5)-diff(A_j_1_i(:,:,1,11),q5)))

%for i=1:length(d)
%    disp(i)
%    disp(U(:,:,i,i)-diff(A_j_1_i(:,:,1,i+1),q(i)));
%end
%disp(U(:,:,3,1)-diff(A_j_1_i(:,:,1,4),q1))

syms m1 m2 I1 I2;
m = [0 0 m1 0 0 0 0 m2];
J = sym(zeros(4,4,length(d)));
J(:,:,3) = [I1/2 0 0 0;
            0 I1/2 0 0
            0 0 I1/2 0
            0 0 0 m1];
J(:,:,8) = [I2/2 0 0 0;
            0 I2/2 0 0
            0 0 I2/2 0
            0 0 0 m2];
        
D = sym(zeros(length(d),length(d)));
for i=1:length(d)
    for k=i:length(d)
        temp = sym(0);
        for j=max(i,k):length(d)
            temp=(temp+trace(U(:,:,j,k)*J(:,:,j)*U(:,:,j,i).'));
        end
        D(i,k) = temp;
        D(k,i) = D(i,k);
    end
end

g = sym(zeros(length(d),1));
gravity = [0 0 -9.81 0];
for i=1:length(d)
    for j=1:length(d)
        g(i) = g(i)-m(j)*gravity*U(:,:,j,i)*[0 0 0 1]';
    end
end

NewSimplifyD;
simplifyG;

C = sym(zeros(length(d),length(d),length(d)));

for i=1:length(d)
    C(:,:,i) = jacobian(d_simplified(:,i),q)+jacobian(d_simplified(:,i),q).'-diff(d_simplified,q(i));
end

simplifyTemp;

p03 = A_j_1_i(1:3,4,1,4);
p02 = A_j_1_i(1:3,4,1,3);
p01 = A_j_1_i(1:3,4,1,2);
p00 = A_j_1_i(1:3,4,1,1);

z00 = sym([0 0 1]');
z01 = A_j_1_i(1:3,1:3,1,2)*[0 0 1]';
z02 = A_j_1_i(1:3,1:3,1,3)*[0 0 1]';

Jv_1 = cross([0,0,1]',p03);
Jv_2 = simplify(cross(z01,p03));
Jv_3 = z02;
Jw_1 = z00;
Jw_2 = z01;
Jw_3 = sym([0 0 0]');
J_1 = [Jv_1,Jv_2,Jv_3;
       Jw_1,Jw_2,Jw_3]; 
simplify(det(J_1.'*J_1))

D_simplified = simplify(D);