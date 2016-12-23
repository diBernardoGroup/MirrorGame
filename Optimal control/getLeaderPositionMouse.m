% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

function position = getLeaderPositionMouse

C = get(0,'PointerLocation');

% % Position between [-0.5,0.5]: do not use double screen
position = (C(1,1)-1280/2)/1280;

end