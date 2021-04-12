function curve = cubicBezier3D(t,C1,C2,C3,C4)
    tau = [t;t;t];
    curve = C1.*(1-tau).^3 + C2.*3.*tau.*(1-tau).^2 + C3.*3.*(tau.^2).*(1-tau) + C4.*tau.^3;
end

