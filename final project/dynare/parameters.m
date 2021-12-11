%Declare parameter values

clear all;
alpha=0.33; %capital productivity 
delta=0.025; %depreciation rate
beta=0.99; %discount rate
gamma=0.6; %price stickiness
v=0.2; %output aggregation parameter
rho=0.95; %persistence of TFP shock
sigma=0.007; %variance of TFP shock
tau=0.3; %tax rate
eta=0.7; %corporate debt maturity probability
xi=0.4; %takeover costs
pist=0.005; %inflation target
eta1=0.48; %shock distribution parameter
eta3=1.5-3*eta1;
rho_R=0.5; %feedback rule
sigma_R=0.004; %variance of monetary shock
psi1=1.5; %Taylor rule inflation weight
psi2=0.5; %Taylor rule output gap weight
c = (1+pist)/beta-1; %coupon rate
g=1; %steady-state capital growth 
eta_1=1; %one-period debt maturity
theta=0.63;

save('parameters.mat')