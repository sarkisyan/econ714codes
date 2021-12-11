%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Firm problem
% Implementing VFI for eta=1
% Firm_VFI_full.m
%
% Sergey Sarkisyan. FNCE 714
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Implement baseline VFI solution for eta=0.7')
disp(' ')
tic

%%%%%%%%%% do the VFI loop

%initialize guess for value function
V_old = (1-tau)*(Rk-zz)+(1-delta)+tau*delta-((1-tau)*c+eta)*bb*1/pi;
V = V_old(:,bnum/2+0.5);
polindold = zeros(statenum,1);
polold = polindold;
   
    %form price and RHS matrix with static and continutation payoff for state i
    %qu1 = beta*Phi(zstar,eta1,eta3)*((1-eta_1)*c+eta_1*(1+c))/pi+max(beta*(((1-tau)*Rk).*eta1.*(1-zstar)+1/3*((1-tau)*Rk).*eta3.*(1-zstar.^3)-1/2*(1-tau)*eta1*(1-zstar.^2)-1/4*(1-tau)*eta3*(1-zstar.^4)+(EVmat1full-EVmat1)*xi)./bbp,0);
    qu = beta*Phi(zstar,eta1,eta3)*((1-eta)*c+eta*(1+c))/pi+max(beta*(((1-tau)*Rk).*eta1.*(1-zstar)+1/3*((1-tau)*Rk).*eta3.*(1-zstar.^3)-1/2*(1-tau)*eta1*(1-zstar.^2)-1/4*(1-tau)*eta3*(1-zstar.^4)+xi*(((1-delta)+tau*delta)).*(1-Phi(zstar,eta1,eta3)))./bbp,0);
    %qu1aux = reshape(qu1,bnum,anum,znum,bnum);
    %qu1aux2 = reshape(qu1aux(1,:,:,:),bnum*anum,znum);
    %qu11 = kron(kron((reshape(qu1aux2(:,znum/2+0.5),bnum,anum)*(pr_mat_a'))',ones(bnum,1)),ones(znum,1));
    qu1 = qu;
    q0 = 1-(bbp/bbp(end)).^2;
    
    for numit=1:maxit
        q1 = qu1+beta*Phi(zstar,eta1,eta3).*(1-eta).*q0/pi;
        %q1aux = reshape(q11(:,bnum/2+0.5),bnum*anum,znum);
        %q1 = kron(kron((reshape(q1aux(:,znum/2+0.5),bnum,anum)*(pr_mat_a'))',ones(bnum,1)),ones(znum,1));
        q = q1;
        solerrq = max(abs(q(:)-q0(:)));
        if (solerrq<soltol)
            break
        end
        q0 = q;
    end


if (max(mean(q1))>1)
    disp(' ')
    disp('q1 has values above 1')
end

if (max(diff(mean(q1)))>0)
    disp(' ')
    disp('q1 is non-monotone')
end

%V_new = ((1-tau)*(Rk)+(1-delta)+tau*delta-((1-tau)*c+eta)*bbp*1/pi).*Phi(zstar,eta1,eta3)-(1-tau)*(eta1*0.5*zstar.^2-0.5*eta1+eta3*0.25*zstar.^4-0.25*eta3);
V_new = eta*V1_new+(1-eta)*((1-tau)*(Rk-zz)+(1-delta)+tau*delta-(1-tau)*c*bbp*1/pi);
RHSmat = q.*bbp*g+(1-tau)*(Rk-zz)+(1-delta)-g+tau*delta-((1-tau)*c+1)*bb/pi+beta*g*V_new;

[Vv,polind] = max(RHSmat,[],2);
pol = bgrid(polind);

V = reshape(V,bnum,anum,znum);
pol = reshape(pol,bnum,anum,znum);
polind = reshape(polind,bnum,anum,znum);

figure;
plot(bgrid,mean(V(:,1,:),3),'b',...
    bgrid,mean(V(:,floor(anum/2),:),3),'g',...
    bgrid,mean(V(:,anum,:),3),'r',...
    'LineWidth',lwidnum)
xlabel('Old Leverage b_{-1}')
ylabel('Firm Value V(b_{-1},a,z)')
axis([bgrid(1) bgrid(bnum) min(V(:))*0.95 max(V(:))*1.05])
set(gca,'FontSize',fsizenum)
legend('Low a','Medium a','High a','FontSize',fsizenum,'Location','northwest')
legend boxoff

figure
plot(bgrid,mean(pol(:,2,:),3),'b',...
    bgrid,mean(pol(:,floor(anum/2),:),3),'g',...
    bgrid,mean(pol(:,anum,:),3),'r',...
    bgrid,bgrid,'k',...
    'LineWidth',lwidnum)
xlabel('Old Leverage b_{-1}')
ylabel('New Leverage b(b_{-1},a,z)')
axis([bgrid(1) bgrid(bnum) bgrid(1) bgrid(bnum)])
set(gca,'FontSize',fsizenum)
legend('Low a','Medium a','High a','Identity','FontSize',fsizenum,'Location','northwest')
legend boxoff


toc
disp(' ')

