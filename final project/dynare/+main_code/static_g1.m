function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
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
%   g1
%

if T_flag
    T = main_code.static_g1_tt(T, y, x, params);
end
g1 = zeros(32, 32);
g1(1,2)=1-params(4)*T(5)*getPowerDeriv(y(2),(-1)/params(5),1)*T(18);
g1(1,5)=(-(T(18)*(T(1)*(-(params(4)*T(21)))*getPowerDeriv(1-params(4)*T(3),T(4),1)+T(6)*params(4)*T(22))));
g1(2,1)=1;
g1(2,2)=(-(T(11)*T(9)*exp(y(14))*getPowerDeriv(y(2),T(2),1)));
g1(2,3)=(-(T(10)*T(19)));
g1(2,4)=(-(T(11)*T(8)*T(20)));
g1(2,14)=(-(T(10)*T(11)));
g1(3,1)=(-(T(4)*y(23)));
g1(3,5)=(-(y(12)*params(4)*y(6)*T(22)));
g1(3,6)=(-(params(4)*T(5)*y(12)));
g1(3,12)=1-T(5)*params(4)*y(6);
g1(3,23)=(-(T(4)*y(1)));
g1(4,1)=(-1);
g1(4,5)=(-(y(13)*params(4)*y(6)*T(21)));
g1(4,6)=(-(params(4)*T(3)*y(13)));
g1(4,13)=1-T(3)*params(4)*y(6);
g1(5,5)=(-((-(params(4)*T(21)))/(1-params(4))*getPowerDeriv((1-params(4)*T(3))/(1-params(4)),params(5)/(params(5)-1),1)));
g1(5,12)=1/y(13);
g1(5,13)=(-y(12))/(y(13)*y(13));
g1(6,4)=1-(1-params(2)+y(7));
g1(6,7)=(-y(4));
g1(7,1)=1;
g1(7,4)=(-y(7));
g1(7,7)=(-y(4));
g1(7,8)=(-1);
g1(8,1)=(-(params(1)*y(23)/y(4)));
g1(8,4)=(-((-(y(1)*params(1)*y(23)))/(y(4)*y(4))));
g1(8,15)=1;
g1(8,23)=(-(y(1)*params(1)/y(4)));
g1(9,3)=(-(exp(y(14))*T(9)*T(19)));
g1(9,4)=(-(T(11)*exp(y(14))*T(20)));
g1(9,9)=1;
g1(9,14)=(-(T(11)*exp(y(14))*T(9)));
g1(10,5)=(-((-((-y(6))/((1+y(5))*(1+y(5)))))/T(23)));
g1(10,6)=(-((-(1/(1+y(5))))/T(23)));
g1(10,10)=1;
g1(11,14)=1-params(6);
g1(12,5)=(-((1-params(16))*params(18)*1/(1+y(5))));
g1(12,10)=1/(1+y(10))-params(16)*1/(1+y(10));
g1(12,24)=(-1);
g1(13,24)=0.15;
g1(14,6)=1;
g1(15,3)=(-((-(y(9)*(1-params(1))*y(23)))/(y(3)*y(3))));
g1(15,9)=(-((1-params(1))*y(23)/y(3)));
g1(15,11)=1;
g1(15,23)=(-((1-params(1))*y(9)/y(3)));
g1(16,3)=(-(y(8)*params(20)/(1-params(20))/((3-y(3))*(3-y(3)))));
g1(16,8)=(-(params(20)/(1-params(20))/(3-y(3))));
g1(16,11)=1;
g1(17,10)=(-1);
g1(17,15)=1;
g1(18,5)=(-(y(6)*params(10)*((-(y(20)*(1+(1-params(9))*params(11))))/((1+y(5))*(1+y(5)))+T(12)*(-(y(19)*y(21)))/((1+y(5))*(1+y(5))))));
g1(18,6)=(-(params(10)*T(13)));
g1(18,16)=y(18);
g1(18,17)=1;
g1(18,18)=y(16);
g1(18,19)=(-(y(6)*params(10)*T(12)*y(21)/(1+y(5))));
g1(18,20)=(-(y(6)*params(10)*T(25)));
g1(18,21)=(-(y(6)*params(10)*T(12)*y(19)/(1+y(5))));
g1(19,20)=1;
g1(19,22)=(-(params(14)+0.3333333333333333*params(15)*3*T(15)));
g1(20,21)=1;
g1(20,22)=(-(params(15)*2*y(22)));
g1(21,5)=(-(y(16)*(1+(1-params(9))*params(11))))/((1+y(5))*(1+y(5)))/(1-params(9));
g1(21,15)=(-1);
g1(21,16)=T(25)/(1-params(9));
g1(21,22)=1;
g1(22,5)=(-(y(16)*(1+(1-params(9))*params(11))))/((1+y(5))*(1+y(5)));
g1(22,15)=(-(1-params(9)));
g1(22,16)=T(25);
g1(22,19)=1;
g1(22,22)=1-params(9);
g1(23,5)=(-((-(y(6)*y(20)*((1-params(10))*(y(17)+params(11))+params(10)*(1+params(11)))))/((1+y(5))*(1+y(5)))));
g1(23,6)=(-(y(20)*((1-params(10))*(y(17)+params(11))+params(10)*(1+params(11)))/(1+y(5))+T(17)*1/y(16)*T(24)));
g1(23,15)=(-(T(24)*T(16)*((1-y(22))*(1-params(9))*params(14)+(1-T(14))*params(15)*(1-params(9))*0.3333333333333333)));
g1(23,16)=(-(T(24)*T(17)*(-y(6))/(y(16)*y(16))));
g1(23,17)=1-y(6)*y(20)*(1-params(10))/(1+y(5));
g1(23,20)=(-(y(6)*((1-params(10))*(y(17)+params(11))+params(10)*(1+params(11)))/(1+y(5))+T(24)*T(16)*params(12)*(1-params(2)+params(2)*params(9))*(-(1>y(20)))));
g1(23,22)=(-(T(24)*T(16)*(params(15)*0.3333333333333333*y(15)*(1-params(9))*(-(3*T(15)))-params(14)*y(15)*(1-params(9))-params(14)*(1-params(9))*0.5*(-(2*y(22)))-params(15)*(1-params(9))*0.25*(-(T(14)*4)))));
g1(24,15)=0.35822;
g1(24,16)=(-0.33964);
g1(24,18)=1;
g1(25,5)=(-((-(y(6)*(params(10)*(1+params(11))+(1-params(10))*(params(11)+y(25)))))/((1+y(5))*(1+y(5)))));
g1(25,6)=(-((params(10)*(1+params(11))+(1-params(10))*(params(11)+y(25)))/(1+y(5))));
g1(25,25)=1-y(6)*(1-params(10))/(1+y(5));
g1(26,17)=(-((-1)/(y(17)*y(17))));
g1(26,25)=(-1)/(y(25)*y(25));
g1(26,26)=1;
g1(27,26)=(-1);
g1(27,28)=1;
g1(28,20)=(-1);
g1(28,27)=1;
g1(29,5)=(-1);
g1(29,29)=1;
g1(30,16)=(-y(23));
g1(30,23)=(-y(16));
g1(30,30)=1;
g1(31,15)=(-1);
g1(31,32)=1;
g1(32,14)=(-((1-params(5))*exp(y(14))));
g1(32,31)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
