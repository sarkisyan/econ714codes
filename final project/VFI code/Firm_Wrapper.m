%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Firm problem
% Wrapper for model solution and simulation
% Firm_Wrapper.m
%
% Sergey Sarkisyan. FNCE 714
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;

disp('%%%%%%%%%%%%% Solving the firm price adjustment problem')
disp(' ')

%%%%%%%%%% set model parameters
load '../dynare/parameters.mat';
pi = 1.005;
eta=0.7;
tau=0.4;
xi=0.4;

%%%%%%%%%% set solution parameters

%grid parameters
bnum = 101; %number of leverage grid points
bmin = 0.15; %lowest grid point for leverage
bmax = 1; %highest grid point for leverage
Rkmin = 0.0151515+delta; %lowest grid point for Rk
anum = 11; %number of TFP grid points
anstdev = 1; %number of standard deviations to cover around steady state TFP
znum=61; %number of z grid points
statenum = anum*bnum*znum; %total number of state grid points

%solution parameters
soltol = 1e-4; %tolerance on model solution
maxit = 1000; %max iterations on model solution
howardnum = 10; %number of push forward periods in Howard acceleration

%some formatting stuff
lwidnum = 2;
fsizenum = 12;

%%%%%%%%%% set up the grids, discretization of marg cost, payoff matrices
Firm_Setup;

%%%%%%%%%% implement simple VFI with eta=0
Firm_VFI_0;

%%%%%%%%%% implement simple VFI with eta=1
Firm_VFI_1;

%%%%%%%%%% implement VFI with eta
Firm_VFI_full;

%%%%%%%%%% compute steady-states
Steady_State;

%%%%%%%%%% compute dqdb
SS_interp;

