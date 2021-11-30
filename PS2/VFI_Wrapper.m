%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code for steady-states and VFI Wrapper for PS2 
% ECON 714
% Sergey Sarkisyan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;

% Assign parameter values
beta = 0.97;
alpha = 1/3;
delta = 0.1;

% Compute steady-states
Wss = 1;
rss = 1/beta-1+delta;
FunC = @(C) C-((C-Wss^2/C)*beta/(1-beta))^alpha*(Wss/C)^(1-alpha)+delta*(C-Wss^2/C)*beta/(1-beta);
[Css, fval] = fsolve(FunC, 1);
kss = (Css-Wss^2/Css)*beta/(1-beta);
lss = Wss/Css;

% Fixed grid
knum = 250;
kmin = 0.7*kss;
kmax = 1.3*kss;
znum = 3;
statenum = knum*znum;

%solution parameters
soltol = 1e-7; 
maxit = 1000; 

%some formatting stuff
lwidnum = 2;
fsizenum = 12;

%%%%%%% Setup utilities
VFI_Setup;

%%%%%%% Implement VFI with fixed grid
VFI_Fixedgrid;

%%%%%%% Implement VFI with accelerator
%VFI_Accelerator;

%%%%%%% Implement VFI with multigrid
%VFI_Multigrid;






