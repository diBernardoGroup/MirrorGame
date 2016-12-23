% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ aeep ] = adaptiveLawA( aee,x,r )

global etaAL

aeep = -exp(-2*aee) * ((x(1)-r(1))*(x(2)-r(2)) + etaAL*(x(1)-r(1))^2) - etaAL;

end