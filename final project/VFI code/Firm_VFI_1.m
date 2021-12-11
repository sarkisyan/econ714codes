%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Firm problem
% Implementing VFI for eta=1
% Firm_VFI_1.m
%
% Sergey Sarkisyan. FNCE 714
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Implement baseline VFI solution for eta=1')
disp(' ')
tic

%%%%%%%%%% do the VFI loop

%initialize guess for value function
V1_old = (1-tau)*(Rk-zz)+(1-delta)+tau*delta-((1-tau)*c+eta_1)*bb*1/pi;
V1 = V1_old(:,bnum/2+0.5);
polindold1 = zeros(statenum,1);
polold1 = polindold1;
   
    %form price and RHS matrix with static and continutation payoff for state i
    %qu1 = beta*Phi(zstar1,eta1,eta3)*((1-eta_1)*c+eta_1*(1+c))/pi+max(beta*(((1-tau)*Rk).*eta1.*(1-zstar1)+1/3*((1-tau)*Rk).*eta3.*(1-zstar1.^3)-1/2*(1-tau)*eta1*(1-zstar1.^2)-1/4*(1-tau)*eta3*(1-zstar1.^4)+(EVmat1full-EVmat1)*xi)./bbp,0);
    qu1 = beta*Phi(zstar1,eta1,eta3)*((1-eta_1)*c+eta_1*(1+c))/pi+max(beta*(((1-tau)*Rk).*eta1.*(1-zstar1)+1/3*((1-tau)*Rk).*eta3.*(1-zstar1.^3)-1/2*(1-tau)*eta1*(1-zstar1.^2)-1/4*(1-tau)*eta3*(1-zstar1.^4)+xi*(((1-delta)+tau*delta)).*(1-Phi(zstar1,eta1,eta3)))./bbp,0);
    %qu1aux = reshape(qu1,bnum,anum,znum,bnum);
    %qu1aux2 = reshape(qu1aux(1,:,:,:),bnum*anum,znum);
    %qu11 = kron(kron((reshape(qu1aux2(:,znum/2+0.5),bnum,anum)*(pr_mat_a'))',ones(bnum,1)),ones(znum,1));
    qu11 = qu1;
    q01 = 1-(bbp/bbp(end)).^2;
    
    for numit=1:maxit
        q11 = qu11+beta*Phi(zstar1,eta1,eta3).*(1-eta_1).*q01/pi;
        %q1aux = reshape(q11(:,bnum/2+0.5),bnum*anum,znum);
        %q1 = kron(kron((reshape(q1aux(:,znum/2+0.5),bnum,anum)*(pr_mat_a'))',ones(bnum,1)),ones(znum,1));
        q1 = q11;
        solerrq = max(abs(q1(:)-q01(:)));
        if (solerrq<soltol)
            break
        end
        q01 = q1;
    end


if (max(mean(q1))>1)
    disp(' ')
    disp('q1 has values above 1')
end

if (max(diff(mean(q1)))>0)
    disp(' ')
    disp('q1 is non-monotone')
end

V1_new = ((1-tau)*(Rk)+(1-delta)+tau*delta-((1-tau)*c+eta_1)*bbp*1/pi).*Phi(zstar1,eta1,eta3)-(1-tau)*(eta1*0.5*zstar1.^2-0.5*eta1+eta3*0.25*zstar1.^4-0.25*eta3);
RHSmat1 = eta_1*q1.*bbp*g+(1-tau)*(Rk-zz)+(1-delta)-g+tau*delta-((1-tau)*c+eta_1)*bb/pi+beta*g*V1_new;

[Vv,polind1] = max(RHSmat1,[],2);
pol1 = bgrid(polind1);

V1 = reshape(V1,bnum,anum,znum);
pol1 = reshape(pol1,bnum,anum,znum);
polind1 = reshape(polind1,bnum,anum,znum);

figure;
plot(bgrid,mean(V1(:,1,:),3),'b',...
    bgrid,mean(V1(:,floor(anum/2),:),3),'g',...
    bgrid,mean(V1(:,anum,:),3),'r',...
    'LineWidth',lwidnum)
xlabel('Old Leverage b_{-1}')
ylabel('Firm Value V1(b_{-1},a,z)')
axis([bgrid(1) bgrid(bnum) min(V1(:))*0.95 max(V1(:))*1.05])
set(gca,'FontSize',fsizenum)
legend('Low a','Medium a','High a','FontSize',fsizenum,'Location','northwest')
legend boxoff

figure
plot(bgrid,mean(pol1(:,2,:),3),'b',...
    bgrid,mean(pol1(:,floor(anum/2),:),3),'g',...
    bgrid,mean(pol1(:,anum,:),3),'r',...
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

