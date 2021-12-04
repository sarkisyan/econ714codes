function y = chebyshev_poly(x,t,a,b)
	
% Chebyshev polinomial of degree t (t=0,1,...)
% evaluated at x, when the domain is a,b
% columns are for each x
% rows are for each t

	x = 2*(x-a)/(b-a)-1;
	y = cos(t'*acos(x));