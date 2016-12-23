% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ x ] = constrain( x,MAX )

if ~(abs(x)<=MAX) && ~(isnan(x))
    x = sign(x)*MAX;
elseif isnan(x)
    x = sign(-.5+rand)*MAX;
end

end