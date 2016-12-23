% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ beep ] = adaptiveLawB( bee,x,r,u )

global a b g w etaAL

beep = (x(2)-r(2))/exp(2*bee) * ( w^2*x(1)+(a*x(1)^2+b*x(2)^2-g)*x(2)- etaAL * (x(2)-r(2))-u ) - etaAL;

end