%% Do the DDO math with SymPy - symbolic package
clear

pkg load symbolic

% Non-Oscillatory solution z>1
syms z positive
syms t t1 positive
A = [[0 1]; [-1 -2*z]];
q = sqrt(z^2-1);

% G = exp(A*t)
G = exp(-z*t)*( cosh(q*t)*eye(2) + ...
  sinh(q*t)/q * ...
  [[z 1]; [-1 -z]]);

##%% Proof
##[P,L]=eig(A);
##P=simplify(P);
##L=simplify(L);
##iP=simplify(inv(P));
##L1 = simplify(expm(L*t)*exp(z*t));
##G1 = simplify(P*L1*iP)
##Q=simplify(expand(G*exp(z*t)-G1)) %= 0

h = int(G*[0; 1],t,0,t1);
h = simplify(H)




