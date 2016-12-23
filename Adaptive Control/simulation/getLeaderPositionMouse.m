% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function position = getLeaderPositionMouse

global mouseMax

C = get(0,'PointerLocation');

% Position between [-0.5,0.5]
position = (C(1,1)-mouseMax/2)/mouseMax;

end