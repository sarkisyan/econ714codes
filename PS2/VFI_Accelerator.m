%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code for VFI with accelerator for PS2 
% ECON 714
% Sergey Sarkisyan
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Implement VFI with accelerator')
disp(' ')
tic

%%%%%%%%%% do the VFI loop

%initialize guess for Value function
Vaold = U(:,knum/2);
polaindold = zeros(statenum,1);
polaold = polaindold;

for vfct=1:maxit
    
    %based on guess for Value function, form continuation Value EVamat 
    EVamat = kron((reshape(Vaold,knum,znum)*(pr_mat_z'))',ones(knum,1));
    
    RHSmata = (1-beta)*U + beta*EVamat;
    
    %actually do the optimization
    if (mod(vfct,10)==1)
        [Va,polaind] = max(RHSmata,[],2);
        pola = kgrid(polaind);
    else
        Va = RHSmata(:,max(floor(mean(polaindold)),1));
        pola = kgrid(max(polaindold,1));
    end
    
    %now, compute the error in the Vaalue function from one iteration to the next
    solerr = max(abs(Va(:)-Vaold(:)));
    polaerr = max(abs(pola(:)-polaold(:)));
    
    %display some diagnostics
    if (mod(vfct,50)==1) 
        disp(['For iter ' num2str(vfct) ', VF error = ' num2str(solerr)])
    end
    
    if (solerr<soltol)
        break
    end
    
    Vaold = Va;
    polaindold=polaind;
    polaold = pola;
    
end

Va = reshape(Va,knum,znum);
pola = reshape(pola,knum,znum);
polaind = reshape(polaind,knum,znum);

figure;
plot(kgrid,pola(:,1),'b',...
    kgrid,pola(:,2),'g',...
    kgrid,pola(:,znum),'r',...
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



