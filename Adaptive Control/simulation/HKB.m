% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ xp ] = HKB( x,u )

global a b g w

xp = zeros(2,1);

xp(1) = x(2);
xp(2) = -(a*x(1)^2+b*x(2)^2-g)*x(2)-w^2*x(1) + u;

end