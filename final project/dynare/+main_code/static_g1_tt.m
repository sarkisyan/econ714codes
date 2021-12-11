function T = static_g1_tt(T, y, x, params)
% function T = static_g1_tt(T, y, x, params)
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

assert(length(T) >= 25);

T = main_code.static_resid_tt(T, y, x, params);

T(18) = getPowerDeriv(T(7),(-params(5)),1);
T(19) = getPowerDeriv(y(3),1-params(1),1);
T(20) = getPowerDeriv(y(4),params(1),1);
T(21) = getPowerDeriv(y(5),T(2)-1,1);
T(22) = getPowerDeriv(y(5),T(2),1);
T(23) = y(6)/(1+y(5))*y(6)/(1+y(5));
T(24) = T(16)*T(17)>0;
T(25) = (1+(1-params(9))*params(11))/(1+y(5));

end
