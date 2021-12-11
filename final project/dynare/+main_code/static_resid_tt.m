function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 17);

T(1) = (1-params(4))^(params(5)/(params(5)-1));
T(2) = 1/params(5);
T(3) = y(5)^(T(2)-1);
T(4) = 1/(1-params(5));
T(5) = y(5)^T(2);
T(6) = y(2)^((-1)/params(5));
T(7) = T(1)*(1-params(4)*T(3))^T(4)+params(4)*T(5)*T(6);
T(8) = y(2)^T(2)*exp(y(14));
T(9) = y(4)^params(1);
T(10) = T(8)*T(9);
T(11) = y(3)^(1-params(1));
T(12) = params(11)+1/(1-params(9));
T(13) = y(20)*(1+(1-params(9))*params(11))/(1+y(5))+y(19)*y(21)/(1+y(5))*T(12);
T(14) = y(22)^3;
T(15) = y(22)^2;
T(16) = y(6)/y(16);
T(17) = params(14)*y(15)*(1-params(9))*(1-y(22))+params(15)*0.3333333333333333*y(15)*(1-params(9))*(1-T(14))-params(14)*(1-params(9))*0.5*(1-T(15))-params(15)*(1-params(9))*0.25*(1-y(22)^4)+params(12)*(1-params(2)+params(2)*params(9))*(1-min(y(20),1));

end
