function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = main_code.static_resid_tt(T, y, x, params);
end
residual = zeros(32, 1);
lhs = y(2);
rhs = T(7)^(-params(5));
residual(1) = lhs - rhs;
lhs = y(1);
rhs = T(10)*T(11);
residual(2) = lhs - rhs;
lhs = y(12);
rhs = T(4)*y(1)*y(23)+y(12)*T(5)*params(4)*y(6);
residual(3) = lhs - rhs;
lhs = y(13);
rhs = y(1)+y(13)*T(3)*params(4)*y(6);
residual(4) = lhs - rhs;
lhs = y(12)/y(13);
rhs = ((1-params(4)*T(3))/(1-params(4)))^(params(5)/(params(5)-1));
residual(5) = lhs - rhs;
lhs = y(4);
rhs = y(4)*(1-params(2)+y(7));
residual(6) = lhs - rhs;
lhs = y(1);
rhs = y(8)+y(4)*y(7);
residual(7) = lhs - rhs;
lhs = y(15);
rhs = y(1)*params(1)*y(23)/y(4);
residual(8) = lhs - rhs;
lhs = y(9);
rhs = T(11)*exp(y(14))*T(9);
residual(9) = lhs - rhs;
lhs = y(10);
rhs = 1/(y(6)/(1+y(5)))-1;
residual(10) = lhs - rhs;
lhs = y(14);
rhs = y(14)*params(6)+params(7)*x(1);
residual(11) = lhs - rhs;
lhs = log(1+y(10));
rhs = (1-params(16))*log(1/params(3)*(1+params(13)))+log(1+y(10))*params(16)+(1-params(16))*params(18)*(log(1+y(5))-log(1+params(13)))+y(24);
residual(12) = lhs - rhs;
lhs = y(24);
rhs = y(24)*0.85+params(17)*x(2);
residual(13) = lhs - rhs;
lhs = y(6);
rhs = params(3);
residual(14) = lhs - rhs;
lhs = y(11);
rhs = y(9)*(1-params(1))*y(23)/y(3);
residual(15) = lhs - rhs;
lhs = y(11);
rhs = y(8)*params(20)/(1-params(20))/(3-y(3));
residual(16) = lhs - rhs;
lhs = y(15);
rhs = y(10);
residual(17) = lhs - rhs;
lhs = y(17)+y(16)*y(18);
rhs = y(6)*params(10)*T(13);
residual(18) = lhs - rhs;
lhs = y(20);
rhs = params(14)*y(22)+0.3333333333333333*params(15)*T(14)+0.5;
residual(19) = lhs - rhs;
lhs = y(21);
rhs = params(14)+params(15)*T(15);
residual(20) = lhs - rhs;
lhs = y(22);
rhs = y(15)-y(16)*(1+(1-params(9))*params(11))/(1+y(5))/(1-params(9))+(1-params(2))/(1-params(9))+params(2)*params(9)/(1-params(9));
residual(21) = lhs - rhs;
lhs = y(19);
rhs = params(2)*params(9)+1-params(2)+(1-params(9))*(y(15)-y(22))-y(16)*(1+(1-params(9))*params(11))/(1+y(5));
residual(22) = lhs - rhs;
lhs = y(17);
rhs = y(6)*y(20)*((1-params(10))*(y(17)+params(11))+params(10)*(1+params(11)))/(1+y(5))+max(T(16)*T(17),0);
residual(23) = lhs - rhs;
lhs = y(18);
rhs = y(16)*0.33964-0.75856+y(15)*(-0.35822);
residual(24) = lhs - rhs;
lhs = y(25);
rhs = y(6)*(params(10)*(1+params(11))+(1-params(10))*(params(11)+y(25)))/(1+y(5));
residual(25) = lhs - rhs;
lhs = y(26);
rhs = 1/y(17)-1/y(25);
residual(26) = lhs - rhs;
lhs = y(28);
rhs = y(26);
residual(27) = lhs - rhs;
lhs = y(27);
rhs = y(20);
residual(28) = lhs - rhs;
lhs = y(29);
rhs = y(5);
residual(29) = lhs - rhs;
lhs = y(30);
rhs = y(23)*y(16);
residual(30) = lhs - rhs;
lhs = y(32);
rhs = y(15);
residual(31) = lhs - rhs;
lhs = y(31);
rhs = (1-params(5))*exp(y(14));
residual(32) = lhs - rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
end
