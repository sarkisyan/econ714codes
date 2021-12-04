% Chebyshev polynomials for PS2, ECON 714
%
% This file calls:
%
% (i) tauchen.m: approximates AR(1) process.
%
% (ii) residual_fcn.m: solves for the coefficients associated to the Chebychev polynomials.
%
% (iii) eulerr_grid.m: computes Euler errors on a grid for capital and the exogenous shock.
%
% (iv) simulation.m
%
% Sergey Sarkisyan
%

%----------------------------------------------------------------
% 0. Housekeeping
%----------------------------------------------------------------

clc
%clear all
close all

%----------------------------------------------------------------
% 1. Calibration
%----------------------------------------------------------------

% Technology
alpha = 1/3;                       % Capital Share
beta  = 0.97;                     % Discount factor
delta = 0.1;                    % Depreciation

% Productivity shocks
lambda = 0.95;                     % Persistence parameter of the productivity shock
sigma  = 0.007;                    % S.D. of the productivity shock Z

%----------------------------------------------------------------
% 2. Declare size vectors
%----------------------------------------------------------------

% Productivity and capital
shock_num = 3;                     % number of nodes for technology process Z
nodeSizeList = 5;             % number of polynomials for capital
listSize  = length(nodeSizeList);  % steps in multinode iteration for capital

% Euler errors
grid_num  = 3000;                  % # of grid points for  capital (to compute euler errors)

% Simulation
T         = 10000;                 % Number of periods for the simulation of the economy
dropT     = 1000;                  % Burn-in

%----------------------------------------------------------------
% 3. Steady State + Tauchen 
%----------------------------------------------------------------

% Compute Steady State values

Wss = 1;
rss = 1/beta-1+delta;
FunC = @(C) C-((C-Wss^2/C)*beta/(1-beta))^alpha*(Wss/C)^(1-alpha)+delta*(C-Wss^2/C)*beta/(1-beta);
[Css, fval] = fsolve(FunC, 1);
kss = (Css-Wss^2/Css)*beta/(1-beta);
lss = Wss/Css;
vss = log(css)-lss^2/2;

[Z,PI] = tauchen(shock_num,0,lambda,sigma,3);

%----------------------------------------------------------------
% 4. Spectral Method using Chebychev Polynomials
%----------------------------------------------------------------

% Define boundaries for capital
cover_grid = 0.25;
k_min = kss*(1-cover_grid);
k_max = kss*(1+cover_grid);
interval = kss*2*cover_grid;

tic

for multinode_step = 1:listSize
    
    node_num = nodeSizeList(multinode_step);
    M = node_num*shock_num;
    
    % Find Zeros of the Chebychev Polynomial on order M 
    ZC = -cos((2*(1:node_num)'-1)*pi/(2*node_num));

    % Define Chebychev polynomials
    T_k = ones(node_num,node_num);
    T_k(:,2) = ZC;

    for i1 = 3:node_num
        T_k(:,i1) = 2*ZC.*T_k(:,i1-1)-T_k(:,i1-2);
    end

        % Project collocation points in the K space
        grid_k = ((ZC+1)*(k_max-k_min))/2+k_min;

        % Initial Guess for Chebyshev coefficients
        rho_guess = zeros(2*M,1);
        if(multinode_step == 1)
            for z_index = 1:shock_num
                rho_guess((z_index-1)*node_num+1)   = vss;
                rho_guess((z_index-1)*node_num+M+1) = lss;
            end
        else
            for z_index = 1:2*shock_num
                rho_guess((z_index-1)*node_num+1:(z_index-1)*node_num+node_num_old)...
                    = rho_old((z_index-1)*node_num_old+1:z_index*node_num_old);
            end
        end
    
        % Solve for Chebyshev coefficients
        rho = residual_fcn(alpha,beta,delta,k_min,k_max,rho_guess,grid_k,T_k,Z,PI,node_num,shock_num,M);
        rho_old = rho;
        node_num_old = node_num;
    
end

toc

%----------------------------------------------------------------
% 3. Compute Euler Errors and Decision rules
%----------------------------------------------------------------

grid_k_complete = zeros(grid_num,1);

for i = 1:grid_num
    grid_k_complete(i) = k_min+(i-1)*interval/(grid_num-1);
end

[g_k,g_c,g_l,value_fcn,euler_error,max_error]= ...
    eulerr_grid(alpha,beta,delta,rho,Z,PI,...
    k_min,k_max,grid_k_complete,shock_num,node_num,grid_num,M);

[vSeries,kSeries,cSeries,lSeries,ySeries,...
    eeSeries,rbSeries,rkSeries,rkCondSeries] = ...
    simulation(alpha,beta,delta,kss,rho,Z,PI,k_min,k_max,node_num,shock_num,M,T,dropT);

mean_error    = sum(eeSeries)/(T-dropT);
max_error_sim = max(eeSeries);

disp(' ')
disp('Integral of Euler Equation Error:')
disp(mean_error)
disp('Max Euler Equation Error Simulation:')
disp(max_error_sim)

%----------------------------------------------------------------
% 4. Figures
%----------------------------------------------------------------

% Decision Rules
figure(1)
subplot(2,2,1)
plot(grid_k_complete,value_fcn)
title('Value Function')
subplot(2,2,2)
plot(grid_k_complete,g_c)
title('Consumption Decision Rule')
subplot(2,2,3)
plot(grid_k_complete,g_l)
title('Labor Decision Rule')
subplot(2,2,4)
plot(grid_k_complete,g_k,grid_k_complete,grid_k_complete)
title('Capital Decision Rule')

% Euler Equation Error on the Grid
figure(2)
plot(grid_k_complete,euler_error)
title('Log10 Euler Error')

% Distribution of simulated variables

[f_c,x_c]   = ksdensity(cSeries);
[f_k,x_k]   = ksdensity(kSeries);
[f_y,x_y]   = ksdensity(ySeries);
[f_l,x_l]   = ksdensity(lSeries);
[f_rb,x_rb] = ksdensity(rbSeries);
[f_rk,x_rk] = ksdensity(rkSeries);

figure(3)
subplot(3,2,1)
plot(x_c,f_c)
title('Density of Consumption')
subplot(3,2,2)
plot(x_l,f_l)
title('Density of Labor')
subplot(3,2,3)
plot(x_k,f_k)
title('Density of Capital')
subplot(3,2,4)
plot(x_y,f_y)
title('Density of Output')
subplot(3,2,5)
plot(x_rb,f_rb)
title('Density of Return on Risk Free bond')
subplot(3,2,6)
plot(x_rk,f_rk)
title('Density of Return on Equity')