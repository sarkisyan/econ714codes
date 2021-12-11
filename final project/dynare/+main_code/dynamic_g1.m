function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
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
%   g1
%

if T_flag
    T = main_code.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(32, 57);
g1(1,2)=(-(T(5)*getPowerDeriv(y(2),(-1)/params(5),1)*T(30)));
g1(1,11)=1;
g1(1,14)=(-(T(30)*(T(1)*T(32)*getPowerDeriv(T(3),T(4),1)+T(6)*params(4)*getPowerDeriv(y(14),T(2),1))));
g1(2,10)=1;
g1(2,11)=(-(T(11)*T(9)*exp(y(23))*getPowerDeriv(y(11),T(2),1)));
g1(2,12)=(-(T(10)*T(31)));
g1(2,13)=(-(T(11)*T(8)*getPowerDeriv(y(13),params(1),1)));
g1(2,23)=(-(T(10)*T(11)));
g1(3,10)=(-(T(4)*y(32)));
g1(3,43)=(-(y(46)*params(4)*y(15)*getPowerDeriv(y(43),T(2),1)));
g1(3,15)=(-(y(46)*params(4)*T(12)));
g1(3,21)=1;
g1(3,46)=(-(params(4)*y(15)*T(12)));
g1(3,32)=(-(T(4)*y(10)));
g1(4,10)=(-1);
g1(4,43)=(-(y(47)*params(4)*y(15)*getPowerDeriv(y(43),T(2)-1,1)));
g1(4,15)=(-(y(47)*params(4)*T(13)));
g1(4,22)=1;
g1(4,47)=(-(params(4)*y(15)*T(13)));
g1(5,14)=(-(T(32)/(1-params(4))*getPowerDeriv(T(3)/(1-params(4)),params(5)/(params(5)-1),1)));
g1(5,21)=1/y(22);
g1(5,22)=(-y(21))/(y(22)*y(22));
g1(6,3)=(-(1-params(2)+y(16)));
g1(6,13)=1;
g1(6,16)=(-y(3));
g1(7,10)=1;
g1(7,3)=(-y(16));
g1(7,16)=(-y(3));
g1(7,17)=(-1);
g1(8,10)=(-(params(1)*y(32)/y(3)));
g1(8,3)=(-((-(y(10)*params(1)*y(32)))/(y(3)*y(3))));
g1(8,24)=1;
g1(8,32)=(-(y(10)*params(1)/y(3)));
g1(9,12)=(-(T(14)*T(31)));
g1(9,3)=(-(T(11)*exp(y(23))*getPowerDeriv(y(3),params(1),1)));
g1(9,18)=1;
g1(9,23)=(-(T(11)*T(14)));
g1(10,43)=(-((-((-y(15))/((1+y(43))*(1+y(43)))))/T(33)));
g1(10,15)=(-((-(1/(1+y(43))))/T(33)));
g1(10,45)=1;
g1(11,6)=(-params(6));
g1(11,23)=1;
g1(11,56)=(-params(7));
g1(12,1)=(-((1-params(16))*0.2*(-(1/y(1)))));
g1(12,10)=(-((1-params(16))*0.2*1/y(10)));
g1(12,14)=(-((1-params(16))*params(18)*1/(1+y(14))));
g1(12,5)=(-(params(16)*1/(1+y(5))));
g1(12,19)=1/(1+y(19));
g1(12,33)=(-1);
g1(13,9)=(-0.85);
g1(13,33)=1;
g1(13,57)=(-params(17));
g1(14,12)=(-(T(21)*(-(T(17)*T(18)*(-(getPowerDeriv(3-y(12),params(20),1)))))/(T(20)*T(20))));
g1(14,42)=(-(T(21)*params(3)*T(15)*(-(getPowerDeriv(3-y(42),params(20),1)))/T(20)));
g1(14,15)=1;
g1(14,17)=(-(T(21)*(-(T(17)*T(19)*getPowerDeriv(y(17),1-params(20),1)))/(T(20)*T(20))+T(17)/T(20)*(-y(44))/(y(17)*y(17))*T(35)));
g1(14,44)=(-(T(21)*params(3)*T(16)*getPowerDeriv(y(44),1-params(20),1)/T(20)+T(17)/T(20)*T(35)*1/y(17)));
g1(15,12)=(-((-(y(18)*(1-params(1))*y(32)))/(y(12)*y(12))));
g1(15,18)=(-((1-params(1))*y(32)/y(12)));
g1(15,20)=1;
g1(15,32)=(-((1-params(1))*y(18)/y(12)));
g1(16,12)=(-(y(17)*params(20)/(1-params(20))/((3-y(12))*(3-y(12)))));
g1(16,17)=(-(params(20)/(1-params(20))/(3-y(12))));
g1(16,20)=1;
g1(17,19)=(-1);
g1(17,24)=1;
g1(18,14)=(-(y(4)*params(10)*((-(y(29)*(1+(1-params(9))*params(11))))/((1+y(14))*(1+y(14)))+T(22)*(-(y(28)*y(30)))/((1+y(14))*(1+y(14))))));
g1(18,4)=(-(params(10)*T(23)));
g1(18,25)=y(8);
g1(18,7)=1;
g1(18,8)=y(25);
g1(18,28)=(-(y(4)*params(10)*T(22)*y(30)/(1+y(14))));
g1(18,29)=(-(y(4)*params(10)*T(36)));
g1(18,30)=(-(y(4)*params(10)*T(22)*y(28)/(1+y(14))));
g1(19,29)=1;
g1(19,31)=(-(params(14)+0.3333333333333333*params(15)*3*T(24)));
g1(20,30)=1;
g1(20,31)=(-(params(15)*2*y(31)));
g1(21,14)=(-(y(25)*(1+(1-params(9))*params(11))))/((1+y(14))*(1+y(14)))/(1-params(9));
g1(21,24)=(-1);
g1(21,25)=T(36)/(1-params(9));
g1(21,31)=1;
g1(22,14)=(-(y(25)*(1+(1-params(9))*params(11))))/((1+y(14))*(1+y(14)));
g1(22,24)=(-(1-params(9)));
g1(22,25)=T(36);
g1(22,28)=1;
g1(22,31)=1-params(9);
g1(23,43)=(-((-(y(15)*y(51)*((1-params(10))*(params(11)+y(50))+params(10)*(1+params(11)))))/((1+y(43))*(1+y(43)))));
g1(23,15)=(-(y(51)*((1-params(10))*(params(11)+y(50))+params(10)*(1+params(11)))/(1+y(43))+T(29)*1/y(49)*T(34)));
g1(23,48)=(-(T(34)*T(25)*((1-y(52))*(1-params(9))*params(14)+T(27)*params(15)*(1-params(9))*0.3333333333333333)));
g1(23,49)=(-(T(34)*T(29)*(-y(15))/(y(49)*y(49))));
g1(23,26)=1;
g1(23,50)=(-(y(15)*y(51)*(1-params(10))/(1+y(43))));
g1(23,51)=(-(y(15)*((1-params(10))*(params(11)+y(50))+params(10)*(1+params(11)))/(1+y(43))+T(34)*T(25)*params(12)*(1-params(2)+params(2)*params(9))*(-(1>y(51)))));
g1(23,52)=(-(T(34)*T(25)*(params(15)*0.3333333333333333*(1-params(9))*y(48)*(-(3*T(28)))-params(14)*(1-params(9))*y(48)-params(14)*(1-params(9))*0.5*(-(2*y(52)))-params(15)*(1-params(9))*0.25*(-(T(26)*4)))));
g1(24,48)=0.35822;
g1(24,49)=(-0.33964);
g1(24,27)=1;
g1(25,43)=(-((-(y(15)*(params(10)*(1+params(11))+(1-params(10))*(params(11)+y(54)))))/((1+y(43))*(1+y(43)))));
g1(25,15)=(-((params(10)*(1+params(11))+(1-params(10))*(params(11)+y(54)))/(1+y(43))));
g1(25,34)=1;
g1(25,54)=(-(y(15)*(1-params(10))/(1+y(43))));
g1(26,26)=(-((-1)/(y(26)*y(26))));
g1(26,34)=(-1)/(y(34)*y(34));
g1(26,35)=1;
g1(27,55)=(-1);
g1(27,37)=1;
g1(28,51)=(-1);
g1(28,36)=1;
g1(29,43)=(-1);
g1(29,38)=1;
g1(30,49)=(-y(53));
g1(30,53)=(-y(49));
g1(30,39)=1;
g1(31,48)=(-1);
g1(31,41)=1;
g1(32,23)=(-((1-params(5))*exp(y(23))));
g1(32,40)=1;

end
