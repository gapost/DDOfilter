function [G,h] = ddo(t,z)
% function [G,h] = ddo(t,z)
%
% Return the matrix G = e^{A*t} and the vector h that
% can be used to advance the state x of a damped driven
% oscillator (DDO) filter
%
% t is the sampling interval and z the damping factor

if z<=0,
  error('z must be positive');
end
if t<=0,
 error('t must be positive');
end

if z<1,
  q = sqrt(1-z^2);
  c = cos(q*t)*exp(-z*t);
  s = sin(q*t)/q*exp(-z*t);
elseif z==1,
  c = exp(-t);
  s = t*exp(-t);
else  % z > 1
  q = sqrt(z^2-1);
  c = cosh(q*t)*exp(-z*t);
  s = sinh(q*t)/q*exp(-z*t);
end

G = [c+z*s  s; -s c-z*s];
h = [1-c-z*s; s];
