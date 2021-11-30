%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code for VFI with fixed grid for PS2 
% ECON 714
% Sergey Sarkisyan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Implement VFI with fixed grid')
disp(' ')
tic

%%%%%%%%%% do the VFI loop

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



