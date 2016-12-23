% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ u ] = LBA(aee,bee,x,r,uI)

u = (aee+bee*(x(1)-r(1))^2)*(x(2)-r(2))-uI;

end