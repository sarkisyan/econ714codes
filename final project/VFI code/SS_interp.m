%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Firm problem
% Computing q derivative with interpolation
% SS_interp.m
%
% Sergey Sarkisyan. FNCE 714
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Computing q derivative with interpolation')
disp(' ')
tic

qu_grid = zeros(anum,bnum);
q0_grid = zeros(anum,bnum);
for i=1:anum
    for h=1:bnum
        qu_grid(i,h)=beta*Phi(zstar_forgrid(i,h),eta1,eta3)*((1-eta)*c+eta*(1+c))/pi+max(beta*(((1-tau)*agrid(i)).*eta1.*(1-zstar_forgrid(i,h))+1/3*((1-tau)*agrid(i)).*eta3.*(1-zstar_forgrid(i,h)^3)-1/2*(1-tau)*eta1*(1-zstar_forgrid(i,h)^2)-1/4*(1-tau)*eta3*(1-zstar_forgrid(i,h)^4)+xi*(((1-delta)+tau*delta).*(1-Phi(zstar_forgrid(i,h),eta1,eta3))))./bgrid(h),0);
        q0_grid(i,h) = 1-(bgrid(h)/bgrid(end)).^2;
    end
end

for numit=1:maxit
        q_grid = qu_grid+beta*Phi(zstar_forgrid,eta1,eta3).*(1-eta).*q0_grid/pi;
        solerrq = max(abs(q_grid(:)-q0_grid(:)));
        if (solerrq<soltol)
            break
        end
        q0_grid = q_grid;
end

bnum_int=1001;
anum_int=901;
b_interp = linspace(max(b_steady-0.02,bmin), min(b_steady+0.02,bmax), bnum_int)';
Rk_interp = linspace(min(agrid), max(agrid), anum_int)';
for i=1:anum_int
    for h=1:bnum_int
        zst_interp(h,i) = max(min(Rk_interp(i)-((1-tau)*c+eta)*b_interp(h)*1/pi/(1-tau)+(1-delta)/(1-tau)+tau*delta/(1-tau),1),-1);
    end
end
zst_interp = zst_interp';

q_interp = min(interp2(bgrid', agrid', q_grid, b_interp', Rk_interp, 'cubic'),1);
dqdb_interp = zeros(anum_int,bnum_int);
dqdb_interp(:,1) = 0;
for h=2:bnum_int
    for i=1:anum_int
        dqdb_interp(i,h) = min((q_interp(i,h)-q_interp(i,h-1))/(b_interp(2)-b_interp(1)),0);
    end
end
q_resh = reshape(q_interp, anum_int*bnum_int,1);
dqdb_resh = reshape(dqdb_interp, anum_int*bnum_int,1);
zst_resh = reshape(zst_interp, anum_int*bnum_int,1);
b_resh = kron(b_interp,ones(anum_int,1));
Rk_resh = kron(ones(bnum_int,1),Rk_interp);


%regmat_int = [ones(bnum_int*anum_int,1) b_resh b_resh.^2 Rk_resh Rk_resh.*b_resh Rk_resh.*b_resh.^2 Rk_resh.^2 Rk_resh.^2.*b_resh Rk_resh.^2.*b_resh.^2];
regmat_int = [ones(bnum_int*anum_int,1) b_resh b_resh.^2 Rk_resh Rk_resh.*b_resh];
[b_reg_int, b_int, r, rint, stats] = regress(q_resh, regmat_int);

%dqdb_ss = b_reg_int(1)+b_reg_int(2)*b_steady+b_reg_int(3)*b_steady^2+b_reg_int(4)*Rk_steady+b_reg_int(5)*Rk_steady*b_steady+b_reg_int(6)*Rk_steady*b_steady^2+b_reg_int(7)*Rk_steady^2+b_reg_int(8)*Rk_steady^2*b_steady+b_reg_int(9)*Rk_steady^2*b_steady^2;
b_reg_int
stats(1)
disp(' ')
%disp(['dqdb = ' num2str(b_reg_int(1)) ' + ' num2str(b_reg_int(2)) '*b(+1) + ' num2str(b_reg_int(3)) '*b(+1)^2 + ' num2str(b_reg_int(4)) '*Rk +' num2str(b_reg_int(5)) '*Rk*b(+1) + ' num2str(b_reg_int(6)) '*Rk*b(+1)^2 + ' num2str(b_reg_int(7)) '*Rk^2 + ' num2str(b_reg_int(8)) '*Rk^2*b(+1) + ' num2str(b_reg_int(9)) '*Rk^2*b(+1)^2; '])  
disp(' ')


