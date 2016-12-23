% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015


%% Evaluate metrics
global CV relativePhase
CV = circularVariance(relativePhase);

global emd X Xd
emd = evaluateVelocityEmd(X(2,:),Xd(2,:));

global RMS
RMS = myMSE (X(1,:),Xd(1,:));

global Au U
Au = myEnergy(U);


%% Show metrics
display('Circular Variance');
CV

display('EMD between leader and follower')
emd

display('RMS between leader and follower')
RMS

display('Control effort')
Au