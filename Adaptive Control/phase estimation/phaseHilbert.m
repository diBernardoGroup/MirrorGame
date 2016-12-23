% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ Hpos,theta ] = phaseHilbert ( pos )

Np = length(pos);
theta = zeros(1,Np);

Hpos = hilbert(pos);
Hpos = imag(Hpos);

for i=1:Np
    theta(i) = -atan2(-Hpos(i),pos(i)) + pi/2;
end

end
