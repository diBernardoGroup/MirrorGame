% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ u ] = elasticForce ( x )

global xA xB kE

u = 0;

if x(1)<=xA
    u = -kE*(x(1)-xA);
elseif x(1)>=xB
    u = -kE*(x(1)-xB);
end

end