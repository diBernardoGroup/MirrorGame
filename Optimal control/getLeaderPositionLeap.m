% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

function position = getLeaderPositionLeap(old_pos)

f = matleap(1);

% Position between [-0.5,0.5]
if ~isempty(f.pointables)
    position = f.pointables(1).position(1)/500;
    
    if abs(position) > .5
        position = .5*abs(position);
    end
    
else
    position = old_pos;
end

end