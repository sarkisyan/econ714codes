function f = f(z,eta1,eta3)
%eta1 = 0.48;
%eta3 = 1.5-3*eta1;
    if z<=-1
        f = 0;
    elseif z>1
        f = 0;
    else f = eta1+eta3*z.^2;
    end
end