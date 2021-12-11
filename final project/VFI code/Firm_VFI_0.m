%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Firm problem
% Implementing VFI for eta=0
% Firm_VFI_0.m
%
% Sergey Sarkisyan. FNCE 714
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Implement VFI for eta=0')
disp(' ')
tic

%%%%%%%%%% do the VFI loop

%initialize guess for value function
V0_old = (1-tau)*(Rk-zz)+(1-delta)+tau*delta-(1-tau)*c*bb*1/pi;
V0 = V0_old(:,bnum/2+0.5);

%%%%%%%%%% some simple plots
V0 = reshape(V0,bnum,anum,znum);

figure;
plot(bgrid,V0(:,1,znum/2+0.5),'b',...
    bgrid,V0(:,floor(anum/2),znum/2+0.5),'g',...
    bgrid,V0(:,anum,znum/2+0.5),'r',...
    'LineWidth',lwidnum)
xlabel('Old Leverage b_{-1}')
ylabel('Firm Value V0(b_{-1},a,z)')
axis([bgrid(1) bgrid(bnum) min(V0(:))*0.95 max(V0(:))*1.05])
set(gca,'FontSize',fsizenum)
legend('Low a','Medium a','High a','FontSize',fsizenum,'Location','northwest')
legend boxoff

toc
disp(' ')

