%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'main_code';
M_.dynare_version = '4.6.4';
oo_.dynare_version = '4.6.4';
options_.dynare_version = '4.6.4';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('main_code.log');
M_.exo_names = cell(2,1);
M_.exo_names_tex = cell(2,1);
M_.exo_names_long = cell(2,1);
M_.exo_names(1) = {'eps_A'};
M_.exo_names_tex(1) = {'eps\_A'};
M_.exo_names_long(1) = {'eps_A'};
M_.exo_names(2) = {'eps_R'};
M_.exo_names_tex(2) = {'eps\_R'};
M_.exo_names_long(2) = {'eps_R'};
M_.endo_names = cell(32,1);
M_.endo_names_tex = cell(32,1);
M_.endo_names_long = cell(32,1);
M_.endo_names(1) = {'Y'};
M_.endo_names_tex(1) = {'Y'};
M_.endo_names_long(1) = {'Y'};
M_.endo_names(2) = {'pt'};
M_.endo_names_tex(2) = {'pt'};
M_.endo_names_long(2) = {'pt'};
M_.endo_names(3) = {'N'};
M_.endo_names_tex(3) = {'N'};
M_.endo_names_long(3) = {'N'};
M_.endo_names(4) = {'K'};
M_.endo_names_tex(4) = {'K'};
M_.endo_names_long(4) = {'K'};
M_.endo_names(5) = {'pi'};
M_.endo_names_tex(5) = {'pi'};
M_.endo_names_long(5) = {'pi'};
M_.endo_names(6) = {'M'};
M_.endo_names_tex(6) = {'M'};
M_.endo_names_long(6) = {'M'};
M_.endo_names(7) = {'i'};
M_.endo_names_tex(7) = {'i'};
M_.endo_names_long(7) = {'i'};
M_.endo_names(8) = {'C'};
M_.endo_names_tex(8) = {'C'};
M_.endo_names_long(8) = {'C'};
M_.endo_names(9) = {'y'};
M_.endo_names_tex(9) = {'y'};
M_.endo_names_long(9) = {'y'};
M_.endo_names(10) = {'R'};
M_.endo_names_tex(10) = {'R'};
M_.endo_names_long(10) = {'R'};
M_.endo_names(11) = {'W'};
M_.endo_names_tex(11) = {'W'};
M_.endo_names_long(11) = {'W'};
M_.endo_names(12) = {'U'};
M_.endo_names_tex(12) = {'U'};
M_.endo_names_long(12) = {'U'};
M_.endo_names(13) = {'F'};
M_.endo_names_tex(13) = {'F'};
M_.endo_names_long(13) = {'F'};
M_.endo_names(14) = {'log_A'};
M_.endo_names_tex(14) = {'log\_A'};
M_.endo_names_long(14) = {'log_A'};
M_.endo_names(15) = {'Rk'};
M_.endo_names_tex(15) = {'Rk'};
M_.endo_names_long(15) = {'Rk'};
M_.endo_names(16) = {'b'};
M_.endo_names_tex(16) = {'b'};
M_.endo_names_long(16) = {'b'};
M_.endo_names(17) = {'q'};
M_.endo_names_tex(17) = {'q'};
M_.endo_names_long(17) = {'q'};
M_.endo_names(18) = {'dqdb'};
M_.endo_names_tex(18) = {'dqdb'};
M_.endo_names_long(18) = {'dqdb'};
M_.endo_names(19) = {'vz'};
M_.endo_names_tex(19) = {'vz'};
M_.endo_names_long(19) = {'vz'};
M_.endo_names(20) = {'Phi_z'};
M_.endo_names_tex(20) = {'Phi\_z'};
M_.endo_names_long(20) = {'Phi_z'};
M_.endo_names(21) = {'f_z'};
M_.endo_names_tex(21) = {'f\_z'};
M_.endo_names_long(21) = {'f_z'};
M_.endo_names(22) = {'zst'};
M_.endo_names_tex(22) = {'zst'};
M_.endo_names_long(22) = {'zst'};
M_.endo_names(23) = {'Pm'};
M_.endo_names_tex(23) = {'Pm'};
M_.endo_names_long(23) = {'Pm'};
M_.endo_names(24) = {'Rst'};
M_.endo_names_tex(24) = {'Rst'};
M_.endo_names_long(24) = {'Rst'};
M_.endo_names(25) = {'qf'};
M_.endo_names_tex(25) = {'qf'};
M_.endo_names_long(25) = {'qf'};
M_.endo_names(26) = {'sp'};
M_.endo_names_tex(26) = {'sp'};
M_.endo_names_long(26) = {'sp'};
M_.endo_names(27) = {'Phi'};
M_.endo_names_tex(27) = {'Phi'};
M_.endo_names_long(27) = {'Phi'};
M_.endo_names(28) = {'spread'};
M_.endo_names_tex(28) = {'spread'};
M_.endo_names_long(28) = {'spread'};
M_.endo_names(29) = {'infl'};
M_.endo_names_tex(29) = {'infl'};
M_.endo_names_long(29) = {'infl'};
M_.endo_names(30) = {'lev'};
M_.endo_names_tex(30) = {'lev'};
M_.endo_names_long(30) = {'lev'};
M_.endo_names(31) = {'Yst'};
M_.endo_names_tex(31) = {'Yst'};
M_.endo_names_long(31) = {'Yst'};
M_.endo_names(32) = {'OpProf'};
M_.endo_names_tex(32) = {'OpProf'};
M_.endo_names_long(32) = {'OpProf'};
M_.endo_partitions = struct();
M_.param_names = cell(20,1);
M_.param_names_tex = cell(20,1);
M_.param_names_long = cell(20,1);
M_.param_names(1) = {'alpha'};
M_.param_names_tex(1) = {'alpha'};
M_.param_names_long(1) = {'alpha'};
M_.param_names(2) = {'delta'};
M_.param_names_tex(2) = {'delta'};
M_.param_names_long(2) = {'delta'};
M_.param_names(3) = {'beta'};
M_.param_names_tex(3) = {'beta'};
M_.param_names_long(3) = {'beta'};
M_.param_names(4) = {'gamma'};
M_.param_names_tex(4) = {'gamma'};
M_.param_names_long(4) = {'gamma'};
M_.param_names(5) = {'v'};
M_.param_names_tex(5) = {'v'};
M_.param_names_long(5) = {'v'};
M_.param_names(6) = {'rho'};
M_.param_names_tex(6) = {'rho'};
M_.param_names_long(6) = {'rho'};
M_.param_names(7) = {'sigma'};
M_.param_names_tex(7) = {'sigma'};
M_.param_names_long(7) = {'sigma'};
M_.param_names(8) = {'g'};
M_.param_names_tex(8) = {'g'};
M_.param_names_long(8) = {'g'};
M_.param_names(9) = {'tau'};
M_.param_names_tex(9) = {'tau'};
M_.param_names_long(9) = {'tau'};
M_.param_names(10) = {'eta'};
M_.param_names_tex(10) = {'eta'};
M_.param_names_long(10) = {'eta'};
M_.param_names(11) = {'c'};
M_.param_names_tex(11) = {'c'};
M_.param_names_long(11) = {'c'};
M_.param_names(12) = {'xi'};
M_.param_names_tex(12) = {'xi'};
M_.param_names_long(12) = {'xi'};
M_.param_names(13) = {'pist'};
M_.param_names_tex(13) = {'pist'};
M_.param_names_long(13) = {'pist'};
M_.param_names(14) = {'eta1'};
M_.param_names_tex(14) = {'eta1'};
M_.param_names_long(14) = {'eta1'};
M_.param_names(15) = {'eta3'};
M_.param_names_tex(15) = {'eta3'};
M_.param_names_long(15) = {'eta3'};
M_.param_names(16) = {'rho_R'};
M_.param_names_tex(16) = {'rho\_R'};
M_.param_names_long(16) = {'rho_R'};
M_.param_names(17) = {'sigma_R'};
M_.param_names_tex(17) = {'sigma\_R'};
M_.param_names_long(17) = {'sigma_R'};
M_.param_names(18) = {'psi1'};
M_.param_names_tex(18) = {'psi1'};
M_.param_names_long(18) = {'psi1'};
M_.param_names(19) = {'psi2'};
M_.param_names_tex(19) = {'psi2'};
M_.param_names_long(19) = {'psi2'};
M_.param_names(20) = {'theta'};
M_.param_names_tex(20) = {'theta'};
M_.param_names_long(20) = {'theta'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 32;
M_.param_nbr = 20;
M_.orig_endo_nbr = 32;
M_.aux_vars = [];
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.linear_decomposition = false;
M_.orig_eq_nbr = 32;
M_.eq_nbr = 32;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 1 10 0;
 2 11 0;
 0 12 42;
 3 13 0;
 0 14 43;
 4 15 0;
 0 16 0;
 0 17 44;
 0 18 0;
 5 19 45;
 0 20 0;
 0 21 46;
 0 22 47;
 6 23 0;
 0 24 48;
 0 25 49;
 7 26 50;
 8 27 0;
 0 28 0;
 0 29 51;
 0 30 0;
 0 31 52;
 0 32 53;
 9 33 0;
 0 34 54;
 0 35 55;
 0 36 0;
 0 37 0;
 0 38 0;
 0 39 0;
 0 40 0;
 0 41 0;]';
M_.nstatic = 11;
M_.nfwrd   = 12;
M_.npred   = 7;
M_.nboth   = 2;
M_.nsfwrd   = 14;
M_.nspred   = 9;
M_.ndynamic   = 21;
M_.dynamic_tmp_nbr = [29; 7; 0; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , 'pt' ;
  2 , 'name' , 'Y' ;
  3 , 'name' , 'U' ;
  4 , 'name' , 'F' ;
  5 , 'name' , '5' ;
  6 , 'name' , 'K' ;
  7 , 'name' , '7' ;
  8 , 'name' , 'Rk' ;
  9 , 'name' , 'y' ;
  10 , 'name' , 'R' ;
  11 , 'name' , 'log_A' ;
  12 , 'name' , '12' ;
  13 , 'name' , 'Rst' ;
  14 , 'name' , 'M' ;
  15 , 'name' , 'W' ;
  16 , 'name' , '16' ;
  17 , 'name' , '17' ;
  18 , 'name' , '18' ;
  19 , 'name' , 'Phi_z' ;
  20 , 'name' , 'f_z' ;
  21 , 'name' , 'zst' ;
  22 , 'name' , 'vz' ;
  23 , 'name' , 'q' ;
  24 , 'name' , 'dqdb' ;
  25 , 'name' , 'qf' ;
  26 , 'name' , 'sp' ;
  27 , 'name' , 'spread' ;
  28 , 'name' , 'Phi' ;
  29 , 'name' , 'infl' ;
  30 , 'name' , 'lev' ;
  31 , 'name' , 'OpProf' ;
  32 , 'name' , 'Yst' ;
};
M_.mapping.Y.eqidx = [2 3 4 7 8 12 ];
M_.mapping.pt.eqidx = [1 2 ];
M_.mapping.N.eqidx = [2 9 14 15 16 ];
M_.mapping.K.eqidx = [2 6 7 8 9 ];
M_.mapping.pi.eqidx = [1 3 4 5 10 12 18 21 22 23 25 29 ];
M_.mapping.M.eqidx = [3 4 10 14 18 23 25 ];
M_.mapping.i.eqidx = [6 7 ];
M_.mapping.C.eqidx = [7 14 16 ];
M_.mapping.y.eqidx = [9 15 ];
M_.mapping.R.eqidx = [10 12 17 ];
M_.mapping.W.eqidx = [15 16 ];
M_.mapping.U.eqidx = [3 5 ];
M_.mapping.F.eqidx = [4 5 ];
M_.mapping.log_A.eqidx = [2 9 11 32 ];
M_.mapping.Rk.eqidx = [8 17 21 22 23 24 31 ];
M_.mapping.b.eqidx = [18 21 22 23 24 30 ];
M_.mapping.q.eqidx = [18 23 26 ];
M_.mapping.dqdb.eqidx = [18 24 ];
M_.mapping.vz.eqidx = [18 22 ];
M_.mapping.Phi_z.eqidx = [18 19 23 28 ];
M_.mapping.f_z.eqidx = [18 20 ];
M_.mapping.zst.eqidx = [19 20 21 22 23 ];
M_.mapping.Pm.eqidx = [3 8 15 30 ];
M_.mapping.Rst.eqidx = [12 13 ];
M_.mapping.qf.eqidx = [25 26 ];
M_.mapping.sp.eqidx = [26 27 ];
M_.mapping.Phi.eqidx = [28 ];
M_.mapping.spread.eqidx = [27 ];
M_.mapping.infl.eqidx = [29 ];
M_.mapping.lev.eqidx = [30 ];
M_.mapping.Yst.eqidx = [32 ];
M_.mapping.OpProf.eqidx = [31 ];
M_.mapping.eps_A.eqidx = [11 ];
M_.mapping.eps_R.eqidx = [13 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [1 2 4 6 10 14 17 18 24 ];
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(32, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(20, 1);
M_.endo_trends = struct('deflator', cell(32, 1), 'log_deflator', cell(32, 1), 'growth_factor', cell(32, 1), 'log_growth_factor', cell(32, 1));
M_.NNZDerivatives = [118; -1; -1; ];
M_.static_tmp_nbr = [17; 8; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
load parameters.mat;
set_param_value('alpha',alpha)
set_param_value('delta',delta)
set_param_value('beta',beta)
set_param_value('gamma',gamma)
set_param_value('v',v)
set_param_value('rho',rho)
set_param_value('sigma',sigma)
set_param_value('g',g)
set_param_value('tau',tau)
set_param_value('eta',eta)
set_param_value('c',c)
set_param_value('xi',xi)
set_param_value('pist',pist)
set_param_value('eta1',eta1)
set_param_value('eta3',eta3)
set_param_value('rho_R',rho_R)
set_param_value('sigma_R',sigma_R)
set_param_value('psi1',psi1)
set_param_value('psi2',psi2)
set_param_value('theta',theta)
%
% INITVAL instructions
%
options_.initval_file = false;
oo_.steady_state(14) = 0;
oo_.steady_state(16) = 0.262626;
oo_.steady_state(22) = 0.99512;
oo_.steady_state(15) = 0.11879;
oo_.steady_state(17) = 0.99708;
oo_.steady_state(19) = 0;
oo_.steady_state(6) = M_.params(3);
oo_.steady_state(5) = M_.params(13);
oo_.steady_state(10) = exp(log(M_.params(3))+log(1+M_.params(13)))-1;
oo_.steady_state(24) = oo_.steady_state(10);
oo_.steady_state(7) = M_.params(8)-1+M_.params(2);
oo_.steady_state(23) = 1;
oo_.steady_state(2) = (1-M_.params(4))^((-M_.params(5))/(M_.params(5)-1))*(1-M_.params(13)*M_.params(4))^((-M_.params(5))/(1-M_.params(5)))/(1-M_.params(13)*M_.params(4))^(-M_.params(5));
oo_.steady_state(11) = (1-M_.params(1))*(oo_.steady_state(15)/M_.params(1))^((2-M_.params(1))/(1-M_.params(1)))*oo_.steady_state(23);
oo_.steady_state(3) = (oo_.steady_state(11)/(oo_.steady_state(2)^(1/M_.params(5))*(oo_.steady_state(15)/M_.params(1)/oo_.steady_state(23))^((2-M_.params(1))/(1-M_.params(1)))-(M_.params(8)-1+M_.params(2))*(oo_.steady_state(15)/M_.params(1)/oo_.steady_state(23))^(1/(1-M_.params(1)))))^(1/(1+M_.params(20)));
oo_.steady_state(8) = oo_.steady_state(11)*(oo_.steady_state(11)/(oo_.steady_state(2)^(1/M_.params(5))*(oo_.steady_state(15)/M_.params(1)/oo_.steady_state(23))^((2-M_.params(1))/(1-M_.params(1)))-(M_.params(8)-1+M_.params(2))*(oo_.steady_state(15)/M_.params(1)/oo_.steady_state(23))^(1/(1-M_.params(1)))))^((-M_.params(20))/(1+M_.params(20)));
oo_.steady_state(4) = (oo_.steady_state(15)/M_.params(1)/oo_.steady_state(23))^(1/(1-M_.params(1)))*oo_.steady_state(3);
oo_.steady_state(1) = oo_.steady_state(2)^(1/M_.params(5))*oo_.steady_state(4)^M_.params(1)*oo_.steady_state(3)^(1-M_.params(1));
oo_.steady_state(9) = oo_.steady_state(4)^M_.params(1)*oo_.steady_state(3)^(1-M_.params(1));
oo_.steady_state(12) = oo_.steady_state(23)*1/(1-M_.params(5))*oo_.steady_state(1)/(1-M_.params(3)*M_.params(4)*M_.params(13)^(1/M_.params(5)));
oo_.steady_state(13) = oo_.steady_state(1)/(1-M_.params(3)*M_.params(4)*oo_.steady_state(5)^(1/M_.params(5)-1));
oo_.steady_state(20) = 1;
oo_.steady_state(21) = M_.params(14)+M_.params(15)*oo_.steady_state(22)^2;
oo_.steady_state(18) = (-0.0634642);
oo_.steady_state(25) = 1;
oo_.steady_state(26) = 0;
oo_.steady_state(28) = 0;
oo_.steady_state(27) = oo_.steady_state(20);
oo_.steady_state(29) = oo_.steady_state(5);
oo_.steady_state(30) = oo_.steady_state(16);
oo_.steady_state(31) = 1-M_.params(5);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (1)^2;
M_.Sigma_e(2, 2) = (1)^2;
options_.hp_filter = 1600;
options_.irf = 40;
options_.order = 1;
var_list_ = {'log_A';'Rst';'Y';'C';'R';'i';'lev';'Phi';'spread';'infl'};
[info, oo_, options_, M_] = stoch_simul(M_, options_, oo_, var_list_);
save('main_code_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('main_code_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('main_code_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('main_code_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('main_code_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('main_code_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('main_code_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
disp('Note: 1 warning(s) encountered in the preprocessor')
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
