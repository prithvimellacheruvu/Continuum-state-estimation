function yd = odefunKirchhoff(~,y,EI,fd)
% extract variables
th = y(3);
nx = y(4);
ny = y(5);
mz = y(6);

% linear material law
u = mz/EI;

% evaluate differential equations
pxd = cos(th);
pyd = sin(th);
thd = u;
nxd = -fd(1);
nyd = -fd(2);
mzd = -pxd*ny + pyd*nx;

% stack odes
yd = [pxd;pyd;thd;nxd;nyd;mzd];

end