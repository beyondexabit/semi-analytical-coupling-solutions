clear
clc
close all

addpath(genpath('../../suplement_files'));

%% Physical constants
e0      = 8.854187817e-12;
u0      = 1.25663706e-6;
c0      = 1/sqrt(e0*u0);
f0      = c0/1550e-9;
w0      = 2*pi*f0;

%% Load
snop = 10;      nopF  = 800;
R1   = 10;      R2    = 200;%200;
targetDMD = 0;  lzMax = 1e4;        zLx = 1;        incF = 1/1000;      dMax = 0.8;

load pc
load KuvSurf
nopR = 101;     nopP = 101;
nopR1 = 401;    %101 201
nopP1 = 360;

%% deltaBeta1
for k1 = 1:6
    for k2 = 1:6
        deltaBeta1(k1,k2) = (pc(k1) - pc(k2));
    end
end

%% Kuv
rhoDisp = 0:0.05*4:2;
phiDisp = 0%-pi:pi/6:pi;
% rhoDisp = 1;%0:0.05/2:2;
% phiDisp = pi/4;%-pi:pi/6/2/2:pi;
xDisp = rhoDisp.' * cos(phiDisp);
yDisp = rhoDisp.' * sin(phiDisp);


%% Fiber Parameters
% Fiber Length
zMax = 1;
nOfP = 50000;

% Input vectors
% y0 = sqrt([ 1 1 1 1 1 1]);
y0 = sqrt([ 1 2 3 4 5 6]);
y0 = y0 / sqrt(sum(y0.^2));

sum(y0.^2)

A1 = y0(1);
A2 = y0(2);
A3 = y0(3);
A4 = y0(4);
A5 = y0(5);
A6 = y0(6);

% Displacement vector
nOfR = 120;
rhoDispR = 0.08%linspace(0,2,nOfR);
phiDispR = pi/3%0%linspace(0*pi/3.3,0*pi/3.3,nOfR);

% nOfR = 1;
% rhoDispR = 1;
% phiDispR = pi/4;

xDisp = rhoDispR.' * cos(phiDispR);
yDisp = rhoDispR.' * sin(phiDispR);

for kk1 = 1:6
    for kk2 = 1:6
        kuv(kk1,kk2) = KuvSurf(kk1,kk2).s(xDisp,yDisp);
    end
end

% Variable change (z = varC * z)
varC = 1;

% DeltaB
dB = deltaBeta1(1:1:6,1:1:6)/c0*w0/varC;

dB12 = (dB(1,2));
dB13 = (dB(1,3));
dB14 = (dB(1,4));
dB15 = (dB(1,5));
dB16 = (dB(1,6));
dB23 = (dB(2,3));
dB24 = (dB(2,4));
dB25 = (dB(2,5));
dB26 = (dB(2,6));
dB34 = (dB(3,4));
dB35 = (dB(3,5));
dB36 = (dB(3,6));
dB45 = (dB(4,5));
dB46 = (dB(4,6));
dB56 = (dB(5,6));

k  = kuv(1:1:6,1:1:6)/varC;

k12 = (k(1,2));
k13 = (k(1,3));
k14 = (k(1,4));
k15 = (k(1,5));
k16 = (k(1,6));
k23 = (k(2,3));
k24 = (k(2,4));
k25 = (k(2,5));
k26 = (k(2,6));
k34 = (k(3,4));
k35 = (k(3,5));
k36 = (k(3,6));
k45 = (k(4,5));
k46 = (k(4,6));
k56 = (k(5,6));

[~,~,cte1,cte2,cte3,cte4,cte5,cte6,rt1,rt2,rt3,rt4,rt5,rt6] = ...
    coupMat6x6_mat(1,dB12, dB13, dB14, dB15, dB16, dB23, dB24, dB25, dB26, dB34, dB35, dB36, dB45, dB46, dB56, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);

zAna = linspace(0,zMax,nOfP)*varC;

for nM = 1:6
    Aout(1,nM,:) = cte1(1,nM)*exp((1i*rt1(1,1))*zAna) + cte1(2,nM)*exp((1i*rt1(2,1))*zAna) + cte1(3,nM)*exp((1i*rt1(3,1))*zAna) + cte1(4,nM)*exp((1i*rt1(4,1))*zAna) + cte1(5,nM)*exp((1i*rt1(5,1))*zAna) + cte1(6,nM)*exp((1i*rt1(6,1))*zAna) + cte1(7,nM)*exp((1i*rt1(7,1))*zAna) + cte1(8,nM)*exp((1i*rt1(8,1))*zAna) + cte1(9,nM)*exp((1i*rt1(9,1))*zAna) + cte1(10,nM)*exp((1i*rt1(10,1))*zAna);
    Aout(2,nM,:) = cte2(1,nM)*exp((1i*rt2(1,1))*zAna) + cte2(2,nM)*exp((1i*rt2(2,1))*zAna) + cte2(3,nM)*exp((1i*rt2(3,1))*zAna) + cte2(4,nM)*exp((1i*rt2(4,1))*zAna) + cte2(5,nM)*exp((1i*rt2(5,1))*zAna) + cte2(6,nM)*exp((1i*rt2(6,1))*zAna) + cte2(7,nM)*exp((1i*rt2(7,1))*zAna) + cte2(8,nM)*exp((1i*rt2(8,1))*zAna) + cte2(9,nM)*exp((1i*rt2(9,1))*zAna) + cte2(10,nM)*exp((1i*rt2(10,1))*zAna);
    Aout(3,nM,:) = cte3(1,nM)*exp((1i*rt3(1,1))*zAna) + cte3(2,nM)*exp((1i*rt3(2,1))*zAna) + cte3(3,nM)*exp((1i*rt3(3,1))*zAna) + cte3(4,nM)*exp((1i*rt3(4,1))*zAna) + cte3(5,nM)*exp((1i*rt3(5,1))*zAna) + cte3(6,nM)*exp((1i*rt3(6,1))*zAna) + cte3(7,nM)*exp((1i*rt3(7,1))*zAna) + cte3(8,nM)*exp((1i*rt3(8,1))*zAna) + cte3(9,nM)*exp((1i*rt3(9,1))*zAna) + cte3(10,nM)*exp((1i*rt3(10,1))*zAna);
    Aout(4,nM,:) = cte4(1,nM)*exp((1i*rt4(1,1))*zAna) + cte4(2,nM)*exp((1i*rt4(2,1))*zAna) + cte4(3,nM)*exp((1i*rt4(3,1))*zAna) + cte4(4,nM)*exp((1i*rt4(4,1))*zAna) + cte4(5,nM)*exp((1i*rt4(5,1))*zAna) + cte4(6,nM)*exp((1i*rt4(6,1))*zAna) + cte4(7,nM)*exp((1i*rt4(7,1))*zAna) + cte4(8,nM)*exp((1i*rt4(8,1))*zAna) + cte4(9,nM)*exp((1i*rt4(9,1))*zAna) + cte4(10,nM)*exp((1i*rt4(10,1))*zAna);
    Aout(5,nM,:) = cte5(1,nM)*exp((1i*rt5(1,1))*zAna) + cte5(2,nM)*exp((1i*rt5(2,1))*zAna) + cte5(3,nM)*exp((1i*rt5(3,1))*zAna) + cte5(4,nM)*exp((1i*rt5(4,1))*zAna) + cte5(5,nM)*exp((1i*rt5(5,1))*zAna) + cte5(6,nM)*exp((1i*rt5(6,1))*zAna) + cte5(7,nM)*exp((1i*rt5(7,1))*zAna) + cte5(8,nM)*exp((1i*rt5(8,1))*zAna) + cte5(9,nM)*exp((1i*rt5(9,1))*zAna) + cte5(10,nM)*exp((1i*rt5(10,1))*zAna);
    Aout(6,nM,:) = cte6(1,nM)*exp((1i*rt6(1,1))*zAna) + cte6(2,nM)*exp((1i*rt6(2,1))*zAna) + cte6(3,nM)*exp((1i*rt6(3,1))*zAna) + cte6(4,nM)*exp((1i*rt6(4,1))*zAna) + cte6(5,nM)*exp((1i*rt6(5,1))*zAna) + cte6(6,nM)*exp((1i*rt6(6,1))*zAna) + cte6(7,nM)*exp((1i*rt6(7,1))*zAna) + cte6(8,nM)*exp((1i*rt6(8,1))*zAna) + cte6(9,nM)*exp((1i*rt6(9,1))*zAna) + cte6(10,nM)*exp((1i*rt6(10,1))*zAna);
    
    coupMat(:,nM,:) = Aout(:,nM,:);
end

E1 = (squeeze(coupMat(1,:,:)).' * y0.').';
E2 = (squeeze(coupMat(2,:,:)).' * y0.').';
E3 = (squeeze(coupMat(3,:,:)).' * y0.').';
E4 = (squeeze(coupMat(4,:,:)).' * y0.').';
E5 = (squeeze(coupMat(5,:,:)).' * y0.').';
E6 = (squeeze(coupMat(6,:,:)).' * y0.').';
%
Eana = [E1; E2; E3; E4; E5; E6];
min(sum(abs(Eana).^2))
max(sum(abs(Eana).^2))

% Solutions for specific z
tic
Ahandle = @(z,A)Amatrix6x6(z,A,k*varC,dB*varC);
options = odeset('RelTol',1e-9,'AbsTol',1e-9);%0.175e-6
[zNum, Enum] = ode45(Ahandle, [0 zMax], y0,options);
toc

D  = 0.2;
xx = D + 0.6; xy = D + 0.5005;

figure(123)
h0 = plot(zAna,abs(Eana).^2);%,zNum(1:100:end),abs(Enum(1:100:end,:)).^2,'k.')
xlabel(['Transmission Distance [m]'])%,'FontName','Times','FontSize',12,'FontWeight','bold')
ylabel(['Normalized Mode Power'])%,'FontName','Times','FontSize',12,'FontWeight','bold')
set(gca,'FontSize',14)
hold on
h1 = plot(-1,-1,'k-');
h2 = plot(-1,-1,'k.','MarkerSize',20);
legend([h1 h2],{'SA','RK45'},'box','off','location','NorthWest')
plot([xx xx],[0 0.5],'k')
% plot([xy xy],[0 0.7],'k')
plot([xx xx+0.05],[0.5 0.5],'k')
hold off
axis([0 zMax 0 0.6])
% saveas(gcf,'Fig_precision.emf')
tags = {'LP_{01}' 'LP_{02}' 'LP_{11a}' 'LP_{11b}' 'LP_{21a}' 'LP_{21b}'};
xPos = [zMax     0.93     zMax     zMax     zMax     zMax];
yPos = [0.030     0.24     0.1688     0.1230     0.07     0.4];
for k1 = 1:6
    text(xPos(k1),yPos(k1),tags(k1),'Color',h0(k1).Color,'FontWeight','Bold','FontSize',14)
end

set(gcf,'PaperUnits','inches','PaperPosition',[100, 100, 400, 300]/70)
saveas(gcf,'Fig_solutions_precision.emf')

figure(124)
D  = 0.2;
xx = D + 0.6; xy = D + 0.6005; nop = 10; zNumX = zNum(1:nop:end); EnumX = Enum(1:nop:end,:);
h = plot(zAna(zAna>xx&zAna<xy),abs(Eana(:,zAna>xx&zAna<xy)).^2,'LineWidth',2); hold on
for k1 = 1:6; plot(zNumX(zNumX>xx&zNumX<xy),abs(EnumX(zNumX>xx&zNumX<xy,k1)).^2,'.','Color',h(k1).Color,'LineWidth',2,'MarkerSize',20); end; hold off
% axis off
axis tight
box on
set(gca,'xtick',[]); set(gca,'ytick',[])
set(gcf,'Position',[-1500 400 180 120],'PaperPositionMode','auto')
axis([xx,xy,0,0.4])
saveas(gcf,'Fig_precision_SUB.emf')


%     axis([0 2 0 4])

set(gcf,'color','white')
