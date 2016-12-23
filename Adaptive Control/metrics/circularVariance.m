% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ gamma ] = circularVariance ( relPhase )

N = length(relPhase);

gamma = 0;

for i=1:N
    gamma = gamma + exp(1i*relPhase(i));
end

gamma = abs(gamma/N);

end