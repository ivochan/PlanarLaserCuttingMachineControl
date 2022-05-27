% circumference parametric function generator
function [ xf_m, yf_m] = circumference(ti, tf , Ox, Oy, r)  
%[x final movement, y final movement]
%Ox and Oy are the coordinates of the center of the circle
global lambda dt
t = ti:dt:tf;
% time parameterization
o =((t-ti)/(tf-ti));
% circumference generation
%tramite una funzione che descrive l'arco di circonferenza
%lungo le ascisse e un'altra lungo le ordinate
fCx=@(t,R)(Ox+R*cos(t));
fCy=@(t,R)(Oy+R*sin(t));
%variazione d'angolo da 3/2 pi a 3/2 pi (giro completo)
theta = 3/2*pi + lambda(o)*(2*pi);
% trajectory generation
%theta e' la variazione, in angolo, che si compie
%percorrendo la circonferenza
xf_m = fCx(theta,r);
yf_m = fCy(theta,r);
end
