% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

function theta = fixPhase(theta)

N = length(theta);

% Restrain phase in [0,2pi]
theta = mod(theta,2*pi);

% Restrain phase in [-pi,pi]
e = pi;
de = 2*pi;
for j=1:N
    if abs(theta(j))>e
        theta(j) = theta(j) - sign(theta(j))*de;
    end
end
end