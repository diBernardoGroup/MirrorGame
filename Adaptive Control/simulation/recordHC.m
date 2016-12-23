% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function recordHC

global ti

global x xd u
global X Xd U
X(:,ti) = x;
Xd(:,ti) = xd;
U(:,ti) = u;

end