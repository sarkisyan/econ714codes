%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code for VFI setup for PS2 
% ECON 714
% Sergey Sarkisyan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Set up grids and discretization and payoffs')
disp(' ')
tic

kgrid = linspace(kmin,kmax,knum)';
zgrid = [-0.05 0 0.05]';
pr_mat_z = [0.97 0.03 0; 0.01 0.98 0.01; 0 0.03 0.97];

%%%%%%%%%% set up joint indexes of the state space

grid_val = zeros(statenum,2); 
grid_ind = zeros(statenum,2);

%insert values
grid_val(:,1) = kron(ones(znum,1),kgrid);
grid_val(:,2) = kron(zgrid,ones(knum,1));

%insert indexes
grid_ind(:,1) = kron(ones(znum,1),(1:knum)');
grid_ind(:,2) = kron((1:znum)',ones(knum,1));

%%%%%%%%%% set up payoff matrices
kk = repmat(grid_val(:,1),1,knum);
zz = repmat(grid_val(:,2),1,knum);
kkp = repmat(kgrid',statenum,1);

kkint = repmat(kron(ones(znum,1),linspace(kmin,kmax,40)'),1,40);
zzint = repmat(kron(zgrid,ones(40,1)),1,40);
kkpint = repmat(linspace(kmin,kmax,40),40*znum,1);
lfun = @(l) exp(zzint).*kkint.^alpha.*l.^(1-alpha)-Wss*l-rss*kkint;
llint = fsolve(lfun, ones(40*znum,40));
llint1 = llint(1:40, :);
llint2 = llint(41:80, :);
llint3 = llint(81:120, :);

ll1 = interp2(linspace(kmin,kmax,40), linspace(kmin,kmax,40), llint1, kgrid, kgrid', 'linear');
ll2 = interp2(linspace(kmin,kmax,40), linspace(kmin,kmax,40), llint2, kgrid, kgrid', 'linear');
ll3 = interp2(linspace(kmin,kmax,40), linspace(kmin,kmax,40), llint3, kgrid, kgrid', 'linear');
ll = [ll1;ll2;ll3];

cc = max(exp(zz).*kk.^alpha.*ll.^(1-alpha)-kkp+(1-delta)*kk,0.01);
U = log(cc)-ll.^2/2;

toc
disp(' ')



