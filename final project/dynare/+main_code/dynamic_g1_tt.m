function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 36);

T = main_code.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(30) = getPowerDeriv(T(7),(-params(5)),1);
T(31) = getPowerDeriv(y(12),1-params(1),1);
T(32) = (-(params(4)*getPowerDeriv(y(14),T(2)-1,1)));
T(33) = y(15)/(1+y(43))*y(15)/(1+y(43));
T(34) = T(25)*T(29)>0;
T(35) = getPowerDeriv(y(44)/y(17),(-1),1);
T(36) = (1+(1-params(9))*params(11))/(1+y(14));

end
