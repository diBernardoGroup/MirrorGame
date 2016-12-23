% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function mse = myMSE (x,y)

mse = 0;
N = length(x);

for i=1:N
    mse = mse + (x(i)-y(i))^2;
end

mse = sqrt(mse/N);

end
