// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Dynare code for FNCE 714
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//Define variables
var Y,pt,N,K,pi,M,i,C,y,R,W,U,F,log_A,Rk,b,q,dqdb,vz,Phi_z,f_z,zst,Pm,Rst,qf,sp,Phi,spread,infl,lev,Yst,OpProf;

//Define exogenous variables
varexo eps_A,eps_R;

//Declare parameters
parameters alpha delta beta gamma v rho sigma g tau eta c xi pist eta1 eta3 rho_R sigma_R psi1 psi2 theta;

//Assign values to parameters
load parameters.mat;
set_param_value('alpha',alpha)
set_param_value('delta',delta)
set_param_value('beta',beta)
set_param_value('gamma',gamma)
set_param_value('v',v)
set_param_value('rho',rho)
set_param_value('sigma',sigma)
set_param_value('g',g)
set_param_value('tau',tau)
set_param_value('eta',eta)
set_param_value('c',c)
set_param_value('xi',xi)
set_param_value('pist',pist)
set_param_value('eta1',eta1)
set_param_value('eta3',eta3)
set_param_value('rho_R',rho_R)
set_param_value('sigma_R',sigma_R)
set_param_value('psi1',psi1)
set_param_value('psi2',psi2)
set_param_value('theta',theta)

model;
//Equilibrium conditions
pt=((1-gamma)^(v/(v-1))*(1-gamma*pi^(1/v-1))^(1/(1-v))+gamma*pi^(1/v)*pt(-1)^(-1/v))^(-v);
Y=pt^(1/v)*exp(log_A)*(K^alpha)*(N)^(1-alpha);
U=(1/(1-v))*Y*Pm+gamma*M*pi(+1)^(1/v)*U(+1);
F=Y+gamma*M*pi(+1)^(1/v-1)*F(+1);
U/F=((1-gamma*pi^(1/v-1))/(1-gamma))^(v/(v-1));
K=(1-delta+i)*K(-1);
Y=C+i*K(-1);
Rk=alpha*Pm*Y/K(-1);
y=exp(log_A)*K(-1)^alpha*(N)^(1-alpha);
R(+1)=1/(M/(1+pi(+1)))-1;
log_A=rho*log_A(-1)+sigma*eps_A;
log(1+R)=(1-rho_R)*log(1/beta*(1+pist))+rho_R*(log(1+R(-1)))+ (((1-rho_R)*psi1))*(log(1+pi)-log(1+pist))+ (1-rho_R)*0.2*(log(Y)-log(Y(-1)))+Rst;
Rst=0.85*Rst(-1)+sigma_R*eps_R;
M=beta*(C(+1)^(1-theta)*(3-N(+1))^theta)/(C^(1-theta)*(3-N)^theta)*(C(+1)/C)^(-1);
W=(1-alpha)*Pm*y/N;
W=theta/(1-theta)*C/(3-N);

Rk=R;
q(-1)+b*dqdb(-1)=M(-1)*eta*(Phi_z*((1-tau)*c+1)*1/(1+pi)+vz*f_z*1/(1+pi)*(c+1/(1-tau)));
Phi_z=eta1*zst+1/3*eta3*zst^3+0.5;
f_z=eta1+eta3*zst^2;
zst=Rk-((1-tau)*c+1)*b*1/(1+pi)/(1-tau)+(1-delta)/(1-tau)+tau*delta/(1-tau);
vz=(1-tau)*(Rk-zst)+(1-delta)+tau*delta-((1-tau)*c+1)*b/(1+pi);
q=M*Phi_z(+1)*((1-eta)*(c+q(+1))+eta*(c+1))/(1+pi(+1))+max(M/b(+1)*(((1-tau)*Rk(+1))*eta1*(1-zst(+1))+1/3*((1-tau)*Rk(+1))*eta3*(1-zst(+1)^3)-1/2*(1-tau)*eta1*(1-zst(+1)^2)-1/4*(1-tau)*eta3*(1-zst(+1)^4)+xi*(((1-delta)+tau*delta))*(1-min(Phi_z(+1),1))),0);
dqdb=-0.75856+2*(0.16982)*b(+1)+(-0.35822)*Rk(+1);
qf=M*((1-eta)*(c+qf(+1))+eta*(c+1))/(1+pi(+1));
sp=1/q-1/qf;
spread=sp(+1);
Phi=Phi_z(+1);
infl=pi(+1);
lev=Pm(+1)*b(+1);
OpProf=Rk(+1);
Yst=(1-v)^(1/1)*exp(log_A);
end;

//Initial values for computation of the Steady State
initval;
log_A=0;
b=0.262626;
zst=0.99512;
Rk=0.11879;
q=0.99708;
vz=0;
M=beta;
pi=pist;
R=exp(log(beta)+log(1+pist))-1;
Rst=R;
i=g-1+delta;
Pm=1;
pt=((1-gamma)^(-v/(v-1))*(1-gamma*pist)^(-v/(1-v)))/((1-gamma*pist)^(-v));
W=(1-alpha)*(Rk/alpha)^((2-alpha)/(1-alpha))*Pm;
N=((W^(1/1))/(pt^(1/v)*(Rk/alpha/Pm)^((2-alpha)/(1-alpha))-(g-1+delta)*(Rk/alpha/Pm)^(1/(1-alpha))))^(1/(1+theta));
C=W^(1/1)*((W^(1/1))/(pt^(1/v)*(Rk/alpha/Pm)^((2-alpha)/(1-alpha))-(g-1+delta)*(Rk/alpha/Pm)^(1/(1-alpha))))^(-theta/(1+theta));
K=(Rk/alpha/Pm)^(1/(1-alpha))*N;
Y=pt^(1/v)*K^alpha*N^(1-alpha);
y=K^alpha*N^(1-alpha);
U=1/(1-v)*Y*Pm/(1-gamma*beta*pist^(1/v));
F=Y/(1-gamma*beta*pi^(1/v-1));
Phi_z=1;
f_z=eta1+eta3*zst^2;
dqdb=-0.0634642;
qf=1;
sp=0;
spread=0;
Phi=Phi_z;
infl=pi;
lev=b;
Yst=(1-v)^(1/1);
end;
steady;

shocks;
var eps_R; stderr 1;
var eps_A; stderr 1;
end;

stoch_simul(order=1,irf=40,hp_filter=1600)
log_A Rst Y C R i lev Phi spread infl;

