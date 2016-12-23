% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015

%% System order
global n
n = 2;

%% HKB parameters
global a b g w
a = 10;
b = 20;
g = -1;
w = .1;

%% Control parameters
global Cp d etaAL
Cp = 40;
d = .25;
etaAL = 30;

%% Elastic force parameters
global xA xB kE
xA = -.4;
xB = .4;
kE = 5*15;

%% Beginning
clc;
if choice==1 || choice==3 || choice==5
    display('Get ready for your mouse');
elseif choice==2 || choice==4 || choice==6
    matleap(0);
    display('Place your finger over the Leap Motion');
end

pause(2);