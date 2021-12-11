function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = main_code.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(32, 1);
lhs = y(11);
rhs = T(7)^(-params(5));
residual(1) = lhs - rhs;
lhs = y(10);
rhs = T(10)*T(11);
residual(2) = lhs - rhs;
lhs = y(21);
rhs = T(4)*y(10)*y(32)+params(4)*y(15)*T(12)*y(46);
residual(3) = lhs - rhs;
lhs = y(22);
rhs = y(10)+params(4)*y(15)*T(13)*y(47);
residual(4) = lhs - rhs;
lhs = y(21)/y(22);
rhs = (T(3)/(1-params(4)))^(params(5)/(params(5)-1));
residual(5) = lhs - rhs;
lhs = y(13);
rhs = (1-params(2)+y(16))*y(3);
residual(6) = lhs - rhs;
lhs = y(10);
rhs = y(17)+y(16)*y(3);
residual(7) = lhs - rhs;
lhs = y(24);
rhs = y(10)*params(1)*y(32)/y(3);
residual(8) = lhs - rhs;
lhs = y(18);
rhs = T(11)*T(14);
residual(9) = lhs - rhs;
lhs = y(45);
rhs = 1/(y(15)/(1+y(43)))-1;
residual(10) = lhs - rhs;
lhs = y(23);
rhs = params(6)*y(6)+params(7)*x(it_, 1);
residual(11) = lhs - rhs;
lhs = log(1+y(19));
rhs = (1-params(16))*log(1/params(3)*(1+params(13)))+params(16)*log(1+y(5))+(1-params(16))*params(18)*(log(1+y(14))-log(1+params(13)))+(1-params(16))*0.2*(log(y(10))-log(y(1)))+y(33);
residual(12) = lhs - rhs;
lhs = y(33);
rhs = 0.85*y(9)+params(17)*x(it_, 2);
residual(13) = lhs - rhs;
lhs = y(15);
rhs = T(17)/T(20)*T(21);
residual(14) = lhs - rhs;
lhs = y(20);
rhs = y(18)*(1-params(1))*y(32)/y(12);
residual(15) = lhs - rhs;
lhs = y(20);
rhs = y(17)*params(20)/(1-params(20))/(3-y(12));
residual(16) = lhs - rhs;
lhs = y(24);
rhs = y(19);
residual(17) = lhs - rhs;
lhs = y(7)+y(25)*y(8);
rhs = y(4)*params(10)*T(23);
residual(18) = lhs - rhs;
lhs = y(29);
rhs = params(14)*y(31)+0.3333333333333333*params(15)*y(31)^3+0.5;
residual(19) = lhs - rhs;
lhs = y(30);
rhs = params(14)+params(15)*T(24);
residual(20) = lhs - rhs;
lhs = y(31);
rhs = y(24)-y(25)*(1+(1-params(9))*params(11))/(1+y(14))/(1-params(9))+(1-params(2))/(1-params(9))+params(2)*params(9)/(1-params(9));
residual(21) = lhs - rhs;
lhs = y(28);
rhs = params(2)*params(9)+1-params(2)+(1-params(9))*(y(24)-y(31))-y(25)*(1+(1-params(9))*params(11))/(1+y(14));
residual(22) = lhs - rhs;
lhs = y(26);
rhs = y(15)*y(51)*((1-params(10))*(params(11)+y(50))+params(10)*(1+params(11)))/(1+y(43))+max(T(25)*T(29),0);
residual(23) = lhs - rhs;
lhs = y(27);
rhs = y(49)*0.33964-0.75856+y(48)*(-0.35822);
residual(24) = lhs - rhs;
lhs = y(34);
rhs = y(15)*(params(10)*(1+params(11))+(1-params(10))*(params(11)+y(54)))/(1+y(43));
residual(25) = lhs - rhs;
lhs = y(35);
rhs = 1/y(26)-1/y(34);
residual(26) = lhs - rhs;
lhs = y(37);
rhs = y(55);
residual(27) = lhs - rhs;
lhs = y(36);
rhs = y(51);
residual(28) = lhs - rhs;
lhs = y(38);
rhs = y(43);
residual(29) = lhs - rhs;
lhs = y(39);
rhs = y(49)*y(53);
residual(30) = lhs - rhs;
lhs = y(41);
rhs = y(48);
residual(31) = lhs - rhs;
lhs = y(40);
rhs = (1-params(5))*exp(y(23));
residual(32) = lhs - rhs;

end
