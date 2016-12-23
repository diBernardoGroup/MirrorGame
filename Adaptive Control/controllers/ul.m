% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [ u ] = uI ( x,r )

global choice
global Cp d CpL deltaL

% Follower Model (HP: leader, VP: follower)
if choice==1 || choice==2
    c = Cp;
    del = d;
    
% Leader Model (HP: follower, VP: leader)
elseif choice==5 || choice==6
    c = CpL;
    del = deltaL;
end

u = c * exp(-del*(x(2)-r(2))^2) * (x(1)-r(1));

end
