function[Obs1 Pred1 Ekf1] = EKFModel()

persistent H Q R U
persistent x p
persistent firstRun
kn1=0.0075*1.08;
kn=0.194;
KN=25;
kf=0.2;
fpn=1.0;
vs=1;
h=0;
fon=0.5;
anp=10;
r=0.2*1.08;
dp=0.5;
a=0.2;
b=0.3;
m=1;
gT=0;
N=1;
P=1;
N1=1;
C=1;
L=1;


 zk = zeros(5,1);

% Compute m equation m=umaxg(I) ---%
% function m = compute()


  H = [ 1 0 0 0 0; 
      0 1 0 0 0; 
      0 0 0 1 0; 
      0 0 0 1 0;
      0 0 0 0 1];
  
  Q = [ 0.0001 0      0    0      0;
        0      0.0001 0    0      0;
        0      0      0.1  0      0;
        0      0      0    0.001  0;
        0      0      0    0      0];
     
  R = [  6  0 0 0 0;
         0  6 0 0 0;
         0  0 6 0 0;
         0  0 0 6 0;
         0  0 0 0 6];
     U = zeros(5,1);

%   x = [0 0 0]';  
%   P = 10*eye(3);



  
  firstRun = 1;  


Xa = [ 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 0];
Pa = eye(5);
%  zk(1,1)= z(1,1);
%  zk(1,2)= z(1,2);
%  zk(1,3)= z(1,3);
%  zk(1,4)= z(1,4);
%  zk(1,5)= z(1,5);






M = Mjacob(kn1,kn,KN,kf,fpn,vs,fon,anp,r,dp,a,b,h,m,N,P,C,L,gT);
Xf = (M*Xa)+U;
Pf = M*Pa*M'+Q;

%Kalman Gain Matrix
K = Pa*H'*inv(H*Pa*H' + R); 

x  = update(Xf, K, Pf,H);

Obs1 = zk(1);
Pred1 = Xf(1);
Ekf1 = x(1);




%------JaccobianMatrixEquation------%
function M = Mjacob(kn1,kn,KN,kf,fpn,vs,fon,anp,r,dp,a,b,h,m,N,P,C,L,gT)
M = zeros(5,5);

% N1 Derv ---- %
M(1,1) = -(kn1+kf+(fpn*(vs/h)));
M(1,2) = (fon*anp*(r+dp))/1000;
M(1,3) = 0;
M(1,4) = 0;
M(1,5) = 0;

% P Derv ---- %
M(2,1) = 0;
M(2,2) = m*N/(KN+N);
M(2,3) = (m*kn*P)/(KN+N)^2;
M(2,4) = (L*N/(N+KN)- h);
M(2,5) = 0;

% N Derv ---- %
M(3,1) = 0;
M(3,2) = b+ a*gT*(N/(N+KN));
M(3,3) = 0;
M(3,4) = 0;
M(3,5) = 0;

% C Derv ---- %
M(4,1) = 0;
M(4,2) = 0;
M(4,3) = 0;
M(4,4) = kn;
M(4,5) = 0;

% Wf Derv ---- %
M(5,1) = 0;
M(5,2) = 0;
M(5,3) = 0;
M(5,4) = 0;
M(5,5) = 0;

%----------Innovation --------%
function x  = update(Xf, K, zk,H);

x = Xf + K*(zk - (H*Xf));
% Prop = (I - K*H)*Pf;








