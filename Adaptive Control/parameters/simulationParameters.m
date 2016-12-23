% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

% time index
global ti
ti = 1;
 
% x: state of the VP
% xd: state of the HP
% e: position error
% u: control signal
global x xd e u
x = zeros(n,1);
xd = zeros(n,1);
e = zeros(n,1);
u = 0;

% adaptive parameters a and b
global aee bee 
aee = -5;
bee = -5;
