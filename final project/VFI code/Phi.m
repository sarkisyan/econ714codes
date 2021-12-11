function Phi = Phi(z,eta1,eta3)
%eta1 = 0.48;
%eta3 = 1.5-3*eta1;
    if z<=-1
        Phi = 0;
    elseif z>1
        Phi = 1;
    else Phi = eta1*z+1/3*eta3*z.^3+0.5;
    end
end