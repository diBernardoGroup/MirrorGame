% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

function [phase] = phaseEvaluation(lp,fp)

% lp: leader position
% fp: follower position    

%% Hilbert Transform method
% [~,thetaL] = phaseHilbert(lp);
% [~,thetaF] = phaseHilbert(fp);
% phase = thetaL - thetaF;

%% Protophase to phase method
[protophaseX,~] = co_hilbproto(fp);
[phiX,~,~] = co_fbtrT(protophaseX);
[protophaseY,~] = co_hilbproto(lp);
[phiY,~,~] = co_fbtrT(protophaseY);
phase = phiY-phiX;

%% Bound phase into the interval [-pi,pi]
% Phase = Phase_leader - Phase_follower
phase = fixPhase(phase);
    
end