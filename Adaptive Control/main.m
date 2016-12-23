% Francesco Alderisio
% f.alderisio@bristol.ac.uk
% September 2015
 
clear all;
close all;
clc;

global choice t T
global X Xd
presentation;

choices;
choice = input('Choice: ');
setInterface;

T = input('\nSimulation duration (in seconds, maximum 60): ');
parameters_MouseAndLM;

parametersHC;
simulationParameters;
simulationHC;
close all;
t = linspace(0,T,length(X));
setPlots;
plotHCChoice(Xd,X);
evaluateMetrics;
