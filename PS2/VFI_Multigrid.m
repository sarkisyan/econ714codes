%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code for VFI with multigrid for PS2 
% ECON 714
% Sergey Sarkisyan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Implement VFI with multigrid')
disp(' ')
tic

%%%%%% setup
knum = 100;
kmin = 0.7*kss;
kmax = 1.3*kss;
znum = 3;
statenum = knum*znum;

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

%%%%%%%%%% VFI first round
%initialize guess for value function
Vold = U(:,knum/2);
polindold = zeros(statenum,1);
polold = polindold;

for vfct=1:maxit
    
    %based on guess for value function, form continuation value EVmat 
    EVmat = kron((reshape(Vold,knum,znum)*(pr_mat_z'))',ones(knum,1));
    
    RHSmat = (1-beta)*U + beta*EVmat;
    
    %actually do the optimization
    [V,polind] = max(RHSmat,[],2);
    pol = kgrid(polind);
    
    %now, compute the error in the value function from one iteration to the next
    solerr = max(abs(V(:)-Vold(:)));
    polerr = max(abs(pol(:)-polold(:)));
    
    %display some diagnostics
    if (mod(vfct,50)==1) 
        disp(['For iter ' num2str(vfct) ', VF error = ' num2str(solerr)])
    end
    
    if (solerr<soltol)
        break
    end
    
    Vold = V;
    polindold=polind;
    polold = pol;
    
end

%%%%%%% setup second round
knum = 1000;
kmin = 0.7*kss;
kmax = 1.3*kss;
znum = 3;
statenum = knum*znum;

kgrid = linspace(kmin,kmax,knum)';

U1 = U(1:100, :);
U2 = U(101:200, :);
U3 = U(201:300, :);

U1 = interp2(linspace(kmin,kmax,100), linspace(kmin,kmax,100), U1, kgrid, kgrid', 'linear');
U2 = interp2(linspace(kmin,kmax,100), linspace(kmin,kmax,100), U2, kgrid, kgrid', 'linear');
U3 = interp2(linspace(kmin,kmax,100), linspace(kmin,kmax,100), U3, kgrid, kgrid', 'linear');
U = [U1;U2;U3];

%%%%%%%%%% VFI second round
%initialize guess for value function
V1 = V(1:100);
V2 = V(101:200);
V3 = V(201:300);
Vold1 = interp1(1:100,V1,1:1000,'linear')';
Vold2 = interp1(1:100,V2,1:1000,'linear')';
Vold3 = interp1(1:100,V3,1:1000,'linear')';
Vold = [Vold1;Vold2;Vold3];
polindold = zeros(statenum,1);
polold = polindold;

for vfct=1:maxit
    
    %based on guess for value function, form continuation value EVmat 
    EVmat = kron((reshape(Vold,knum,znum)*(pr_mat_z'))',ones(knum,1));
    
    RHSmat = (1-beta)*U + beta*EVmat;
    
    %actually do the optimization
    [V,polind] = max(RHSmat,[],2);
    pol = kgrid(polind);
    
    %now, compute the error in the value function from one iteration to the next
    solerr = max(abs(V(:)-Vold(:)));
    polerr = max(abs(pol(:)-polold(:)));
    
    %display some diagnostics
    if (mod(vfct,50)==1) 
        disp(['For iter ' num2str(vfct) ', VF error = ' num2str(solerr)])
    end
    
    if (solerr<soltol)
        break
    end
    
    Vold = V;
    polindold=polind;
    polold = pol;
    
end

%%%%%%% setup third round
knum = 10000;
kmin = 0.7*kss;
kmax = 1.3*kss;
znum = 3;
statenum = knum*znum;

kgrid = linspace(kmin,kmax,knum)';

U1 = U(1:1000, :);
U2 = U(1001:2000, :);
U3 = U(2001:3000, :);

U1 = interp2(linspace(kmin,kmax,1000), linspace(kmin,kmax,1000), U1, kgrid, kgrid', 'linear');
U2 = interp2(linspace(kmin,kmax,1000), linspace(kmin,kmax,1000), U2, kgrid, kgrid', 'linear');
U3 = interp2(linspace(kmin,kmax,1000), linspace(kmin,kmax,1000), U3, kgrid, kgrid', 'linear');
U = [U1;U2;U3];

%%%%%%%%%% VFI third round
%initialize guess for value function
V1 = V(1:1000);
V2 = V(1001:2000);
V3 = V(2001:3000);
Vold1 = interp1(1:1000,V1,1:10000,'linear')';
Vold2 = interp1(1:1000,V2,1:10000,'linear')';
Vold3 = interp1(1:1000,V3,1:10000,'linear')';
Vold = [Vold1;Vold2;Vold3];
polindold = zeros(statenum,1);
polold = polindold;


for vfct=1:maxit
    
    %based on guess for value function, form continuation value EVmat 
    EVmat = kron((reshape(Vold,knum,znum)*(pr_mat_z'))',ones(knum,1));
    
    RHSmat = (1-beta)*U + beta*EVmat;
    
    %actually do the optimization
    [V,polind] = max(RHSmat,[],2);
    pol = kgrid(polind);
    
    %now, compute the error in the value function from one iteration to the next
    solerr = max(abs(V(:)-Vold(:)));
    polerr = max(abs(pol(:)-polold(:)));
    
    %display some diagnostics
    if (mod(vfct,50)==1) 
        disp(['For iter ' num2str(vfct) ', VF error = ' num2str(solerr)])
    end
    
    if (solerr<soltol)
        break
    end
    
    Vold = V;
    polindold=polind;
    polold = pol;
    
end

V = reshape(V,knum,znum);
pol = reshape(pol,knum,znum);
polind = reshape(polind,knum,znum);

figure;
plot(kgrid,pol(:,1),'b',...
    kgrid,pol(:,2),'g',...
    kgrid,pol(:,znum),'r',...
    kgrid,kgrid,'k',...
    'LineWidth',lwidnum)
xlabel('Old Capital k_{-1}')
ylabel('New Capital k(k_{-1},z)')
axis([kgrid(1) kgrid(knum) kgrid(1) kgrid(knum)])
set(gca,'FontSize',fsizenum)
legend('Low z','Medium z','High z','Identity','FontSize',fsizenum,'Location','northwest')
legend boxoff

toc
disp(' ')

