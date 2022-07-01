function res = beamShooting(y0,E,I,L,fd,fend)
% extract base values
n0 = y0(1:2,1);
m0 = y0(3,1);
p0 = zeros(2,1); % fixed base position
th0 = 0; % fixed base orientation

y0 = [p0;th0;n0;m0];

% integrate ODEs
fun = @(s,y) odefunKirchhoff(s,y,E*I,fd);
[~,y] = ode45(fun,[0,L],y0);

% extract results
nend = y(end,4:5)';
mend = y(end,6)';

% distal conditions

res = [nend-fend; mend];

end