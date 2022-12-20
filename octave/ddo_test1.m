%% Test 1
%%
%% Calculate the DDO response for
%%   z=1/sqrt(2), u(t)=0, x(0)=1
%% and compare to the analytic solution.
%%
clear
% setup DDO simulation
fs = 20; % sampling freq Hz
dt = 1/fs; % s
f0 = 1; % DDO freq Hz
w0 = 2*pi*f0;
ts = 0:dt:(2/f0); % s

% analytic solution for z=1/sqrt(2)
t = linspace(0,2/f0,101);
z = 1/sqrt(2);
x = sin(z*w0*t+pi/4).*exp(-z*w0*t)/z;
dxdt = -w0*sin(z*w0*t).*exp(-z*w0*t)/z;

% DDO filter
[G, h] = ddo(w0*dt,z);
n=size(ts,2);
X = zeros(2,n);
X(1,1)=1;
for i=2:n,
  X(:,i) = G*X(:,i-1);
end

figure 1
plot(ts,X(1,:),'.',t,x)
xlabel('t')
grid
figure 2
plot(ts,X(2,:)*w0,'.',t,dxdt)
xlabel('t')
grid


