function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 29);

T(1) = (1-params(4))^(params(5)/(params(5)-1));
T(2) = 1/params(5);
T(3) = 1-params(4)*y(14)^(T(2)-1);
T(4) = 1/(1-params(5));
T(5) = params(4)*y(14)^T(2);
T(6) = y(2)^((-1)/params(5));
T(7) = T(1)*T(3)^T(4)+T(5)*T(6);
T(8) = y(11)^T(2)*exp(y(23));
T(9) = y(13)^params(1);
T(10) = T(8)*T(9);
T(11) = y(12)^(1-params(1));
T(12) = y(43)^T(2);
T(13) = y(43)^(T(2)-1);
T(14) = exp(y(23))*y(3)^params(1);
T(15) = y(44)^(1-params(20));
T(16) = (3-y(42))^params(20);
T(17) = params(3)*T(15)*T(16);
T(18) = y(17)^(1-params(20));
T(19) = (3-y(12))^params(20);
T(20) = T(18)*T(19);
T(21) = (y(44)/y(17))^(-1);
T(22) = params(11)+1/(1-params(9));
T(23) = y(29)*(1+(1-params(9))*params(11))/(1+y(14))+y(28)*y(30)/(1+y(14))*T(22);
T(24) = y(31)^2;
T(25) = y(15)/y(49);
T(26) = y(52)^3;
T(27) = 1-T(26);
T(28) = y(52)^2;
T(29) = params(14)*(1-params(9))*y(48)*(1-y(52))+params(15)*0.3333333333333333*(1-params(9))*y(48)*T(27)-params(14)*(1-params(9))*0.5*(1-T(28))-params(15)*(1-params(9))*0.25*(1-y(52)^4)+params(12)*(1-params(2)+params(2)*params(9))*(1-min(y(51),1));

end
