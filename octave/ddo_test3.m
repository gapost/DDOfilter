%% Test 3
%%
%% Filter a test signal+noise
%% using the C++ program
%%
%% The path to the executable is assumed to be
%%   ../.build/ddo
%% Change if needed
%%
clear
ddoexec = '../.build/ddo';
% setup DDO simulation
fs = 50; % sampling freq Hz
dt = 1/fs; % s
ft = 0.2; % test signal freq Hz
f0 = 1; % filter freq Hz
t = (0:dt:(5/ft)).'; % time in s, 5 test signal periods
% test signal and derivative
yo = sin(2*pi*ft*t);
y = yo + randn(size(t))*0.1;
dyo = 2*pi*ft*cos(2*pi*ft*t);
% save signal data to a file
save -ascii in.dat y
% DDO options
wdt = 2*pi*f0*dt;
z = 1/sqrt(2); % = default
% run the ddo program and load results
opts = [' -dt' num2str(wdt) ' -z' num2str(z)];
system([ddoexec opts ' < in.dat > out.dat']);
X = load('out.dat','-ascii');
delete in.dat out.dat
% plot results
figure 1
clf
subplot(2,1,1)
plot(t,y,t,X(:,1))
title('Signal+noise and DDO filter output')
grid
subplot(2,1,2)
plot(t,dyo,t,X(:,2)*2*pi*f0)
xlabel('t (s)')
title('True signal derivative and DDO filter estimate')
grid


