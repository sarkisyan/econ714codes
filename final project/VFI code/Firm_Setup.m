%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Firm problem
% Setting up grids and discretization and payoff matrices
% Firm_Setup.m
%
% Gomes and Sarkisyan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Set up grids and discretization and payoffs')
disp(' ')
tic

%%%%%%%%%% set up grid for endogenous prices

bgrid = linspace(bmin,bmax,bnum)';
%bgrid = exp(bgrid)'; %convert to levels, bnum x 1

%%%%%%%%%% set up grid & discretization for exogenous process

[agrid, pr_mat_a] = tauchen(0, sigma, rho, anstdev, anum);
pr_mat_a(pr_mat_a<0) = 0; %fix rounding issue leading to negatives in tauchen() function
A=agrid-min(agrid)+1;
A=A.^(1/4);

%%%%%%%%% set up z grid
%Rk_forgrid =A.^(1/alpha)*(1-alpha)^((1-alpha)/alpha)-A.^(1/alpha)*(1-alpha)^(1/alpha);
%Rkstep = (Rkmax-Rkmin)/(anum-1);
%Rk_forgrid = Rkmin:Rkstep:Rkmax;
Rk_forgrid = agrid-min(agrid)+Rkmin;
zstar1_forgrid = zeros(anum, bnum);
for t = 1:anum
    for h = 1:bnum
        zstar1_forgrid(t,h)= max(min(Rk_forgrid(t)-((1-tau)*c+eta_1)*bgrid(h)*1/pi/(1-tau)+(1-delta)/(1-tau)+tau*delta/(1-tau),1),-1);
    end
end

zstar_forgrid = zeros(anum, bnum);
for t = 1:anum
    for h = 1:bnum
        zstar_forgrid(t,h)= max(min(Rk_forgrid(t)-((1-tau)*c+eta)*bgrid(h)*1/pi/(1-tau)+(1-delta)/(1-tau)+tau*delta/(1-tau),1),-1);
    end
end

zgrid_1_incr = ((min(min(zstar1_forgrid)))+1)/((znum-1)/3);
zgrid_2_incr = (1-(min(min(zstar1_forgrid))))/((znum-1)*2/3);
zgrid_1 = -1:zgrid_1_incr:min(min(zstar1_forgrid));
zgrid_2 = min(min(zstar1_forgrid)):zgrid_2_incr:1;
zgrid = [zgrid_1, zgrid_2(2:end)]';
zgrid_diff = zeros(znum,1);
for z = 2:znum
    zgrid_diff(z) = zgrid(z)-zgrid(z-1);
end
current0 = zeros(bnum*anum,znum);
    int0 = zeros(bnum*anum,1);
    for i=1:bnum*anum
        for k=1:znum
            current0(i,k) = zgrid(k)*f(zgrid(k),eta1,eta3)*zgrid_diff(k);
            int0(i,:) = sum(current0(i,:));
        end
    end
meanint=mean(int0);
save('../dynare/parameters.mat','alpha','delta','beta','gamma','v','rho','sigma','rho_g','sigma_g','tau','eta','xi','pist','theta','kappa','eta1','eta3','rho_R','sigma_R','psi1','psi2','c','g','meanint','eta_1')
A=Rk_forgrid+meanint;
agrid = A';

%%%%%%%%%% set up joint indexes of the state space

grid_val = zeros(statenum,3); %anum*bnum x 3, with (i,1) = value of b, (i,2) = value of a, (i,3) = value of z
grid_ind = zeros(statenum,3); %anum*bnum x 3, with (i,1) = index of b, (i,2) = index of a, (i,3) = index of z

%insert values
grid_val(:,1) = kron(kron(ones(anum,1),ones(znum,1)),bgrid);
grid_val(:,2) = kron(kron(ones(znum,1),agrid),ones(bnum,1));
grid_val(:,3) = kron(zgrid,kron(ones(bnum,1),ones(anum,1)));

%insert indexes
grid_ind(:,1) = kron(kron(ones(anum,1),ones(znum,1)),(1:bnum)');
grid_ind(:,2) = kron(kron(ones(znum,1),(1:anum)'),ones(bnum,1));
grid_ind(:,3) = kron((1:znum)',kron(ones(bnum,1),ones(anum,1)));

%%%%%%%%%% set up payoff matrices
bb = repmat(grid_val(:,1),1,bnum);
aa = repmat(grid_val(:,2),1,bnum);
zz = repmat(grid_val(:,3),1,bnum);
bbp = repmat(bgrid',statenum,1);

%Rk = aa.^(1/alpha)*(1-alpha)^((1-alpha)/alpha)-aa.^(1/alpha)*(1-alpha)^(1/alpha);
Rk=aa;
zstar1 = max(min(Rk-((1-tau)*c+eta_1)*bbp*1/pi/(1-tau)+(1-delta)/(1-tau)+tau*delta/(1-tau),1),-1);
zstar = max(min(Rk-((1-tau)*c+eta)*bbp*1/pi/(1-tau)+(1-delta)/(1-tau)+tau*delta/(1-tau),1),-1);
U0 = (1-tau)*(Rk-zz)+(1-delta)-g+tau*delta-(1-tau)*c*bb*1/pi;

toc
disp(' ')
