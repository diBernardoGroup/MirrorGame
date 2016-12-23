% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function position = getLeaderPositionLeap

global Xd ti
global LMmax

f = matleap(1);

% Position between [-0.5,0.5]
if ~isempty(f.pointables)
    position = f.pointables(1).position(1)/LMmax;
else
    if ti>1
        position = Xd(1,ti);
    else
        position = 0;
    end
end

if abs(position)>0.5
    position = .5*sign(position);
end

end