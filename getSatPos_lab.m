%% ��ó: brdc0320.15n; PRN = 5; 2015�� 2�� 1��,11�� 45�� 0��
%--------------------------------------------------------------------------------
%  5 15  2  1 10  0  0.0-0.285015441477D-03 0.511590769747D-11 0.000000000000D+00
%     0.740000000000D+02 0.909375000000D+01 0.523593238331D-08-0.727187106719D+00
%     0.445172190666D-06 0.404126662761D-02 0.516325235367D-05 0.515375448418D+04
%     0.360000000000D+05 0.856816768646D-07 0.111411160164D+01 0.279396772385D-07
%     0.946363554606D+00 0.272281250000D+03 0.420438314041D+00-0.839106380720D-08
%     0.525021869268D-10 0.100000000000D+01 0.183000000000D+04 0.000000000000D+00
%     0.200000000000D+01 0.000000000000D+00-0.107102096081D-07 0.740000000000D+02
%     0.351300000000D+05 0.400000000000D+01 0.000000000000D+00 0.000000000000D+00
%--------------------------------------------------------------------------------

sqrtA = 0.515375448418D+04;         %: (3,4)
delta_n = 0.523593238331D-08;       %: (2,3)
toe = 0.360000000000D+05;           %: (4,1)
M0 = -0.727187106719D+00;           %: (2,4)
e = 0.404126662761D-02;             %: (3,2)
omega = 0.420438314041D+00;         %: (5,3)
Cuc = 0.445172190666D-06;           %: (3,1)
Cus =  0.516325235367D-05;          %: (3,3)
Crc =  0.272281250000D+03;          %: (5,2)
Crs = 0.909375000000D+01;           %: (2,2)
Cic = 0.856816768646D-07;           %: (4,2)
Cis = 0.279396772385D-07;           %: (4,4)
i0 = 0.946363554606D+00;            %: (5,1)
i_dot = 0.525021869268D-10;         %: (6,1)
Omega0 = 0.111411160164D+01;        %: (4,3)
Omega_dot = -0.839106380720D-08;    %: (5,4)

% Step 1
mu = 3.986005e14;
omegaE = 7.2921151467e-5;

% Step 2
a = sqrtA^2;
n0 = sqrt(mu/a^3);

% Step 3
n = n0 + delta_n;

% Step 4
t = 42300; 
tk = t - toe;

% Step 5
Mk = M0 + n*tk;

% Step 6
Ek = solveKeplerEq(Mk, e);

% Step 7 
fk =  atan2((sqrt(1 - e^2)*sin(Ek)), (cos(Ek) - e));

% Step 8
phik = fk + omega;

% Step 9
delta_uk = Cus*sin(2*phik) + Cuc*cos(2*phik);
delta_rk = Crs*sin(2*phik) + Crc*cos(2*phik);
delta_ik = Cis*sin(2*phik) + Cic*cos(2*phik);

% Step 10
uk = phik + delta_uk;
rk = a*(1 - e*cos(Ek)) + delta_rk;
ik = i0 + delta_ik + i_dot*tk;

% Step 11
xkp = rk*cos(uk);
ykp = rk*sin(uk);

% Step 12
Omegak = Omega0 + (Omega_dot - omegaE)*tk - omegaE*toe;

% Step 13
xk = xkp*cos(Omegak) - ykp*cos(ik)*sin(Omegak);
yk = xkp*sin(Omegak) + ykp*cos(ik)*cos(Omegak);
zk = ykp*sin(ik);

% ������ ��
TrueSatPos = [-211838.444000000,-23390035.3790000,12360315.8720000];
CompSatPos = [xk, yk, zk];

fprintf('Computed X: %12.3f Y: %12.3f Z: %12.3f m\n', CompSatPos);
fprintf('True SP3 X: %12.3f Y: %12.3f Z: %12.3f m\n', TrueSatPos);
fprintf('3D Error: %6.2f m\n', norm(CompSatPos - TrueSatPos));