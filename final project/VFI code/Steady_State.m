%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Firm problem
% Computing steady-states
% Steady-State.m
%
% Sergey Sarkisyan. FNCE 714
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%% Computing steady-states')
disp(' ')
tic

zstar_forgrid = zeros(anum, bnum);
for t = 1:anum
    for h = 1:bnum
        zstar_forgrid(t,h)= max(min(A(t)-((1-tau)*c+eta)*bgrid(h)*1/pi/(1-tau)+(1-delta)/(1-tau)+tau*delta/(1-tau),1),-1);
    end
end

Rk_steady = A(1);
b_steady = mean(mean(pol(:,find(agrid==Rk_steady),:)));
z_steady = max(min(Rk_steady-((1-tau)*c+eta)*b_steady*1/pi/(1-tau)+(1-delta)/(1-tau)+tau*delta/(1-tau),1),-1);
q_aux = q(:,min(find(bgrid>=b_steady)));
q_aux2 = reshape(q_aux,bnum,anum,znum);
q_steady = q_aux2(min(find(bgrid>=b_steady)),find(agrid==Rk_steady),min(find(zgrid>=z_steady)));
Phi_steady = Phi(z_steady,eta1,eta3);

q_resh = reshape(q, bnum, anum, znum, bnum);
q_ab = q_resh(min(find(bgrid>=b_steady)),:,min(find(zgrid>=z_steady)),:);
q_ab = reshape(q_ab, bnum*anum, 1);
Rk_resh = reshape(Rk, bnum, anum, znum, bnum);
Rk_ab = Rk_resh(min(find(bgrid>=b_steady)),:,min(find(zgrid>=z_steady)),:);
Rk_ab = reshape(Rk_ab, bnum*anum, 1);
bbp_resh = reshape(bbp, bnum, anum, znum, bnum);
bbp_ab = bbp_resh(min(find(bgrid>=b_steady)),:,min(find(zgrid>=z_steady)),:);
bbp_ab = reshape(bbp_ab, bnum*anum, 1);
regmat = [ones(bnum*anum,1) bbp_ab bbp_ab.^2 bbp_ab.^3 bbp_ab.^4 Rk_ab Rk_ab.*bbp_ab Rk_ab.*bbp_ab.^2 Rk_ab.*bbp_ab.^3];
%b_reg = regress(q_ab,regmat);
dq_db = zeros(bnum*anum, 1);
dq_db(1) = 0;
diff_q = diff(q_ab);
diff_b = bgrid(2)-bgrid(1);
for i=2:bnum*anum
    dq_db(i) = diff_q(i-1)./diff_b;
end
b_reg = regress(dq_db, regmat);
%dqdb_steady = b_reg(2)+b_reg(3)*2*b_steady+b_reg(4)*3*b_steady^2+b_reg(6)*Rk_steady+b_reg(7)*2*Rk_steady*b_steady;
dqdb_steady = b_reg(1)+b_reg(2)*b_steady+b_reg(3)*b_steady^2+b_reg(4)*b_steady^3+b_reg(5)*b_steady^4+b_reg(6)*Rk_steady+b_reg(7)*Rk_steady*b_steady+b_reg(8)*Rk_steady*b_steady^2+b_reg(9)*Rk_steady*b_steady^3;
vz = V(min(find(bgrid>=b_steady)),min(find(agrid==Rk_steady)),min(find(zgrid>=z_steady)));

toc
disp(' ')
disp(['Steady-states for the firm:'])
disp(' ')
disp(['Rk = ' num2str(Rk_steady)])
disp(' ')
disp(['b = ' num2str(b_steady)])
disp(' ')
disp(['zstar = ' num2str(z_steady)])
disp(' ')
disp(['Phi_z = ' num2str(Phi_steady)])
disp(' ')
disp(['q = ' num2str(q_steady)])
disp(' ')
disp(['vz = ' num2str(vz)])
disp(' ')
disp(' ')
disp(['Mean integral for Rk:'])
disp(' ')
disp(['meanint = ' num2str(meanint)])  
disp(' ')

