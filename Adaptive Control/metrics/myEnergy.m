% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function Au = myEnergy(x)

Au = 0;
N = length(x);

for i=1:N
    Au = Au + abs(x(i));
end

Au = Au/N;

end