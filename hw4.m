clear all; clc;
% Data: brdc0320.15n; igs18300.sp3; suwn0320.15o


%% 참값: 수원 상시관측소(SUWN) 고시 좌표 수신기 좌표

TruePos=[-3062023.563 4055449.033 3841819.213];
TNEV=xyz2gd(TruePos);

% %% 상수 - 빛의 속도 [m/s]
% 
CCC = 299792458.;
% 
% %% suwn0320.15o에서 C1(C/A)관측값 / 9개의 관측 GPS 위성
% % m단위
% 
obss= [ 22056747.586 20694498.633 20541819.469 22889994.445 24255473.586 21704870.031  24958566.391];


%% suwn0320.15o에서 GPS 위성 PRN Num 산출

prns = [18 15 24 13 5 21 22] ;
NoSats = length(prns);


Tgd =[-0.111758708954D-07;
       -0.107102096081D-07;
      0.232830643654D-08;
      -0.102445483208D-07;
      -0.107102096081D-07;
      -0.116415321827D-07;
       -0.176951289177D-07 ];

% 
% % 2. 방송궤도력 기반, 신호전달시간을 고려한 좌표 사용
% 
% % 기준시각(toe), 계산시각(gs = toe + 1시간), tk
% 
% STT=zeros(NoSats,1);
% tc=zeros(NoSats,1);
% 
% toe = 14400;
% gs = date2gwgs(2015,02,01,04,45,00); % Calcualte gs
% t = gs;
% tk = t - toe;
% 
% %%
% 
% 
% 
% dtSatC = [0.376350246370D-03 0.272848410532D-11 0.000000000000D+00;
%           -0.229666009545D-03 -0.227373675443D-11 0.000000000000D+00;
%           -0.427016057074D-04 -0.568434188608D-12 0.000000000000D+00;
%            -0.840867869556D-04 -0.352429196937D-11 0.000000000000D+00;
%             -0.285126734525D-03 0.511590769747D-11 0.000000000000D+00;
%             -0.411805696785D-03 -0.420641299570D-11 0.000000000000D+00;
%             0.313465949148D-03 0.420641299570D-11 0.000000000000D+00 ];
% Tgd =[-0.111758708954D-07;
%        -0.107102096081D-07;
%       0.232830643654D-08;
%       -0.102445483208D-07;
%       -0.107102096081D-07;
%       -0.116415321827D-07;
%        -0.176951289177D-07 ];
% SatPos = [   3151.541837  15922.498494  21506.829887;
%             -12700.261135   9352.557559  21290.677982;
%             -14707.469492  20287.582890   8568.418759;
%              -17813.227217  -4774.848679  18915.918942;
%             -26508.468957   2266.586686  -1748.842388;
%             -172.216490  23878.833895  11869.233880;
%              16377.461444  11328.161903  17871.750324;];
% 
% Computed=SatPos*1000;
% for i = 1:NoSats
% 
%     STT(i,1) = obss(i)/CCC;
%     tc(i,1) = gs - STT(i,1);
% 
%     
% 
% end
% 
% %% 위성시계오차 계수 a, b, c
% 
% a = dtSatC(:,1);
% b = dtSatC(:,2);
% c = dtSatC(:,3);
% 
% %% 초기값 설정
% x = [0,0,0,1];
% H=zeros(NoSats,4);
% y=zeros(NoSats,1);
% 
% fprintf('\n\n[ SP3, 신호전달시간을 고려한 좌표 사용 ]\n\n')
% %% 
% 
% for i = 1 : 10 %Maxiter
% 
%     for j = 1 : NoSats
% 
%         
%         %dtsat = a(j) + b(j)*tk + c(j)*tk^2;%- Tgd(j);
% 
%         vec_site = x(1:3);
%         vec_rho = Computed(j,1:3) - vec_site;
%         rho = norm(vec_rho);
%         com = rho + x(4) ;%-(dtsat*CCC);%+delino;
% 
%        
%         H(j,1) = -(Computed(j,1) - vec_site(1,1)) / rho;
%         H(j,2) = -(Computed(j,2) - vec_site(1,2)) / rho;
%         H(j,3) = -(Computed(j,3) - vec_site(1,3)) / rho;
%         H(j,4)=1;
% 
%         y(j,1) = obss(j) - com;
% 
%     end % i(Nosats) end
% 
%     xhat =(H'*H)\(H'*y);
%     x = x + xhat';
% 
%     if norm(xhat) < 1e-5
%         break;
%     end
% 
%     computedPos=x(1:3);
% 
%     XYZError=computedPos-TruePos;
% 
%     fprintf(1,'#%d 3D Error : %12.4f [m]\n',i,norm(XYZError))
% 
% 
% end %Maxiter end
% 
% CNEV=xyz2gd(computedPos);
% TNEV=xyz2gd(TruePos);
% NEVError=CNEV-TNEV;
% 
% fprintf(1,'\n\ndXYZ[m] : x = %6.2f     y = %6.2f    z = %6.2f \n', XYZError(1),XYZError(2),XYZError(3))
% fprintf(1,'\ndNEV[m] : x = %6.2f    y = %6.2f     z = %6.2f \n\n', NEVError(1),NEVError(2),NEVError(3))
% 
% fprintf(1,"X좌표 : %10.6f Y좌표 : %10.6f Z좌표 : %11.6f \n",x(1),x(2),x(3))
% fprintf(1,"x좌표 오차: %10.6f y좌표 오차: %10.6f z좌표 오차: %10.6f\n",abs(TruePos(1)-x(1)),abs(TruePos(2)-x(2)),abs(TruePos(3)-x(3)))


% 3. 방송궤도력 기반, 신호전달시간,지구 자전 보정함수를 고려한 좌표 사용


% 기준시각(toe), 계산시각(gs = toe , tk
toe = 14400;
gs = date2gwgs(2015,02,01,04,45,00); % Calcualte gs
t = gs;
tk = t - toe;

for i = 1:NoSats

    STT(i,1) = obss(i)/CCC;
    tc(i,1) = gs-STT(i,1);

  

   
end
dtSatC = [0.376350246370D-03 0.272848410532D-11 0.000000000000D+00;
          -0.229666009545D-03 -0.227373675443D-11 0.000000000000D+00;
          -0.427016057074D-04 -0.568434188608D-12 0.000000000000D+00;
           -0.840867869556D-04 -0.352429196937D-11 0.000000000000D+00;
            -0.285126734525D-03 0.511590769747D-11 0.000000000000D+00;
            -0.411805696785D-03 -0.420641299570D-11 0.000000000000D+00;
            0.313465949148D-03 0.420641299570D-11 0.000000000000D+00 ];

Computed= [  3151627.565429 15922480.249332 21506828.962157;
-12700210.092132 9352622.438984 21290677.469134;
-14707368.067574 20287654.703034 8568418.749825;
-17813253.091828 -4774750.129394 18915917.113245;
-26508455.426945 2266743.080048 -1748843.389053;
-172089.550020 23878833.457792 11869233.402607;
16377532.715815 11328060.380790 17871749.480904;];



%% 위성시계오차 계수 a, b, c
a = dtSatC(:,1);
b = dtSatC(:,2);
c = dtSatC(:,3);


%%
x = [0, 0, 0, 1];
H=zeros(NoSats,4);
y=zeros(NoSats,1);
com=zeros(NoSats,1);

aa=zeros(NoSats,3);

fprintf('[ 방송궤도력 기반, 신호전달시간,지구 자전 보정함수를 고려한 좌표 사용 ]\n\n')

for i = 1 : 10 %Maxiter

    for j = 1 : NoSats

        % delino=(2.5457*L1(j)-1.5457*L2(j))*1e-6;

        Vec_Sat=Rotation(Computed(j,1:3),STT(j));
        aa(j,1:3)=Vec_Sat(1:3);
        dtsat = a(j)+(b(j)*tk)+(c(j)*tk)^2-Tgd(j);

        vec_site = x(1:3);
        vec_rho = Vec_Sat - vec_site;
        rho = norm(vec_rho);
        com = rho + x(4) -(dtsat*CCC);%+delino;

        H(j,1) = -(Vec_Sat(1) - vec_site(1,1)) / rho;
        H(j,2) = -(Vec_Sat(2) - vec_site(1,2)) / rho;
        H(j,3) = -(Vec_Sat(3) - vec_site(1,3)) / rho;
        H(j,4)=1;

        y(j,1) = obss(j) - com;


    end % i(Nosats) end

    xhat =(H'*H)\(H'*y);
    x = x + xhat';

    if norm(xhat) < 1e-5
        break;
    end

    computedPos=x(1:3);
    XYZError=computedPos(1:3)-TruePos;

    fprintf(1,'#%d 3D Error : %12.4f [m]\n',i,norm(XYZError));


end %Maxiter end



CNEV=xyz2gd(computedPos);
TNEV=xyz2gd(TruePos);
NEVError=CNEV-TNEV;

fprintf('\n\ndXYZ[m] : [x = %6.2f ]    [y = %6.2f ]    [z = %6.2f ]\n', XYZError(1),XYZError(2),XYZError(3))
fprintf('\ndNEV[m] : [x = %6.2f ]    [y = %6.2f ]    [z = %6.2f ]\n', NEVError(1),NEVError(2),NEVError(3))

fprintf(1,"X좌표 : %10.6f Y좌표 : %10.6f Z좌표 : %11.6f \n",x(1),x(2),x(3))
fprintf(1,"x좌표 오차: %10.6f y좌표 오차: %10.6f z좌표 오차: %10.6f\n",abs(TruePos(1)-x(1)),abs(TruePos(2)-x(2)),abs(TruePos(3)-x(3)))
%  fprintf('PRN %3d %12.4f  %12.4f  %12.4f\n',PRN(i),Computed(i),Computed(i),Computed(i));







