% Chao Zhai, Francesco Alderisio
% zhaichao@amss.ac.cn, f.alderisio@bristol.ac.uk
% December 2016

function phase = evaluatePhase(x)

clc;

% Protophase->phase method
[protophase,~] = co_hilbproto(x);
[phase,~,~] = co_fbtrT(protophase);


end