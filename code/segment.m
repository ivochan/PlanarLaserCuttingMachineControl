%segment parametric function generator 
function [ xf_m, yf_m] = segment(xi, yi, ti, tf, xf, yf)
%[x final movement, y final movement]

global lambda speed cutting_speed dt
% segment between (xi;yi) and (xf;yf) points has been create
t = ti:dt:tf;
% time parameterization
o =((t-ti)/(tf-ti));
% segment generation
xf_m = xi + lambda(o)*(xf - xi);% movement along x axis
yf_m = yi + lambda(o)*(yf - yi);% movement along y axis
end
