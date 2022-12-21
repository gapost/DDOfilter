%% Test 2
%%
%% Filter a test signal+noise
%%
clear
% setup DDO simulation
fs = 50; % sampling freq Hz
dt = 1/fs; % s
ft = 0.2; % test signal freq Hz
f0 = 1; % filter freq Hz
t = 0:dt:(5/ft); % time in s, 5 test signal periods
% test signal and derivative
yo = sin(2*pi*ft*t);
y = yo + randn(size(t))*0.1;
dyo = 2*pi*ft*cos(2*pi*ft*t);
% DDO filtering
[G, h] = ddo(2*pi*f0*dt,1/sqrt(2));
n=size(t,2);
X = zeros(2,n);
for i=2:n,
  X(:,i) = G*X(:,i-1) + h*y(i-1);
end
% plot results
figure 1
clf
subplot(2,1,1)
plot(t,y,t,X(1,:))
title('Signal+noise and DDO filter output')
grid
subplot(2,1,2)
plot(t,dyo,t,X(2,:)*2*pi*f0)
xlabel('t (s)')
title('True signal derivative and DDO filter estimate')
grid


