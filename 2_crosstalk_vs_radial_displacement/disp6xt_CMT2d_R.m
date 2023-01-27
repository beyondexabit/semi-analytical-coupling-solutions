clear 
close all
clc

addpath(genpath('../../suplement_files'));

%% Physical constans
e0      = 8.854187817e-12;
u0      = 1.25663706e-6;
c0      = 1/sqrt(e0*u0);

%% Source parameters
lambda0  = 1550e-9;
w        = 2*pi*c0/lambda0;
w0       = 2*pi*c0/lambda0;

%% Fiber Parameters
lzMax = 1e4;
zLx   = 1;
load pc
load KuvSurf
nModes = 6;
for k1 = 1:nModes
    for k2 = 1:nModes
        deltaBeta1(k1,k2) = ( pc(k1) - pc(k2) ) * w0 / c0 / 2;
    end
end

%% Mode Field
dMax = 0.8; 
    % fast low resolution
    nopR1 = 20; nopP1 = 20;
    rho = [1e-4:1e-3:0.01 0:dMax/nopR1:dMax];
%     $
%     % slow high resolution
%     nopR1 = 401; nopP1 = 360;
%     rho = [1e-4:1e-4:0.01 0:dMax/nopR1:dMax];
%     $
rho = unique(rho); rho = sort(rho); 
phi = -pi:2*pi/(nopP1-1):pi-2*pi/(nopP1-1);

rDisp = ones(length(phi),1)*rho;
pDisp = phi.'*ones(1,length(rho));
xDisp = rDisp.*cos(pDisp);
yDisp = rDisp.*sin(pDisp);

%% Coupling Coefficients
coupMat = zeros(nModes,nModes,lzMax);
Aout    = zeros(nModes,nModes,lzMax);

XT1d_temp = zeros(nModes,lzMax);
XT2d_temp = zeros(nModes,nModes,lzMax);

XT1d_max = zeros(size(xDisp,1),size(yDisp,2),nModes);
XT2d_max = zeros(size(xDisp,1),size(yDisp,2),nModes,nModes);

XT1d_mean = zeros(size(xDisp,1),size(yDisp,2),nModes);
XT2d_mean = zeros(size(xDisp,1),size(yDisp,2),nModes,nModes);

XT1d_mean2 = zeros(size(xDisp,1),size(yDisp,2),nModes);
XT2d_mean2 = zeros(size(xDisp,1),size(yDisp,2),nModes,nModes);

mKuv12 = KuvSurf(1,2).s(xDisp , yDisp);
mKuv13 = KuvSurf(1,3).s(xDisp , yDisp);
mKuv14 = KuvSurf(1,4).s(xDisp , yDisp);
mKuv15 = KuvSurf(1,5).s(xDisp , yDisp);
mKuv16 = KuvSurf(1,6).s(xDisp , yDisp);
mKuv23 = KuvSurf(2,3).s(xDisp , yDisp);
mKuv24 = KuvSurf(2,4).s(xDisp , yDisp);
mKuv25 = KuvSurf(2,5).s(xDisp , yDisp);
mKuv26 = KuvSurf(2,6).s(xDisp , yDisp);
mKuv34 = KuvSurf(3,4).s(xDisp , yDisp);
mKuv35 = KuvSurf(3,5).s(xDisp , yDisp);
mKuv36 = KuvSurf(3,6).s(xDisp , yDisp);
mKuv45 = KuvSurf(4,5).s(xDisp , yDisp);
mKuv46 = KuvSurf(4,6).s(xDisp , yDisp);
mKuv56 = KuvSurf(5,6).s(xDisp , yDisp);

%% Plot coupling coefficients
figure(1652)
subplot(6,6,2);  mesh(xDisp , yDisp, mKuv12); %view([0 0 1])
subplot(6,6,3);  mesh(xDisp , yDisp, mKuv13); %view([0 0 1])
subplot(6,6,4);  mesh(xDisp , yDisp, mKuv14); %view([0 0 1])
subplot(6,6,5);  mesh(xDisp , yDisp, mKuv15); %view([0 0 1])
subplot(6,6,6);  mesh(xDisp , yDisp, mKuv16); %view([0 0 1])
subplot(6,6,9);  mesh(xDisp , yDisp, mKuv23); %view([0 0 1])
subplot(6,6,10);  mesh(xDisp , yDisp, mKuv24); %view([0 0 1])
subplot(6,6,11);  mesh(xDisp , yDisp, mKuv25); %view([0 0 1])
subplot(6,6,12);  mesh(xDisp , yDisp, mKuv26); %view([0 0 1])
subplot(6,6,16); mesh(xDisp , yDisp, mKuv34); %view([0 0 1])
subplot(6,6,17); mesh(xDisp , yDisp, mKuv35); %view([0 0 1])
subplot(6,6,18); mesh(xDisp , yDisp, mKuv36); %view([0 0 1])
subplot(6,6,23); mesh(xDisp , yDisp, mKuv45); %view([0 0 1])
subplot(6,6,24); mesh(xDisp , yDisp, mKuv46); %view([0 0 1])
subplot(6,6,30); mesh(xDisp , yDisp, mKuv56); %view([0 0 1])

%% Calculate crosstalk versus displacement
auxT = [0:0.1:100];
sentence = ['Finding Disp'];

h = tic;
errord = zeros(1,lzMax);
PoutZ = zeros(6,lzMax);
for kk1 = 1:size(yDisp,1)
    perct = (kk1)/(size(yDisp,1));
    
    if min(abs(perct*100 - auxT)) < 1
        disp(perct);
    end

    if kk1 > 1
        tt = toc(h);
        h = tic;
        fprintf([num2str(kk1),' out of ',num2str(size(yDisp,1)),' - time to finish = ',num2str(tt*(size(yDisp,1)-kk1)/60),' min \n'])
    else
        fprintf([num2str(kk1),' out of ',num2str(size(yDisp,1)),'\n'])
    end
    for kk2 = 1:size(yDisp,2)
        fprintf([num2str(kk1),' out of ',num2str(size(yDisp,1)),' - ',num2str(kk2),' out of ',num2str(size(yDisp,2)),'\n'])

        % Coupling Coefficients between LPuv,ab (ignoring polarizations)
        k12 = mKuv12(kk1,kk2); k13 = mKuv13(kk1,kk2); k14 = mKuv14(kk1,kk2); k15 = mKuv15(kk1,kk2); k16 = mKuv16(kk1,kk2);
        k23 = mKuv23(kk1,kk2); k24 = mKuv24(kk1,kk2); k25 = mKuv25(kk1,kk2); k26 = mKuv26(kk1,kk2);
        k34 = mKuv34(kk1,kk2); k35 = mKuv35(kk1,kk2); k36 = mKuv36(kk1,kk2);      
        k45 = mKuv45(kk1,kk2); k46 = mKuv46(kk1,kk2); 
        k56 = mKuv56(kk1,kk2);
        
        dB12 = deltaBeta1(1,2); dB13 = deltaBeta1(1,3); dB14 = deltaBeta1(1,4); dB15 = deltaBeta1(1,5); dB16 = deltaBeta1(1,6);
        dB23 = deltaBeta1(2,3); dB24 = deltaBeta1(2,4); dB25 = deltaBeta1(2,5); dB26 = deltaBeta1(2,6);
        dB34 = deltaBeta1(3,4); dB35 = deltaBeta1(3,5); dB36 = deltaBeta1(3,6);
        dB45 = deltaBeta1(4,5); dB46 = deltaBeta1(4,6);
        dB56 = deltaBeta1(5,6);
        
        zMax = rand(1,lzMax)*zLx; zMax = sort(zMax);
        [coupMat] = coupMat6x6_mat(zMax,dB12, dB13, dB14, dB15, dB16, dB23, dB24, dB25, dB26, dB34, dB35, dB36, dB45, dB46, dB56, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);
       
        PoutZ = [];
        XT1d_temp = [];
        XT2d_temp = [];
        for nM = 1:nModes
            if nM == 3 || nM == 4
                PoutZ(:,:) = abs(sum(1*coupMat(:,3:4,:),2)).^2;
                XT1d_temp(nM,:) = 10*log10((sum(PoutZ,1)-sum(PoutZ(3:4,:)))./sum(PoutZ(3:4,:)));
            elseif nM == 5 || nM == 6
                PoutZ(:,:) = abs(sum(1*coupMat(:,5:6,:),2)).^2;
                XT1d_temp(nM,:) = 10*log10((sum(PoutZ,1)-sum(PoutZ(5:6,:)))./sum(PoutZ(5:6,:)));
            else
                PoutZ(:,:) = abs(coupMat(:,nM,:)).^2;
                XT1d_temp(nM,:) = 10*log10((sum(PoutZ,1)-PoutZ(nM,:))./PoutZ(nM,:));
            end

            XT1d_temp(isinf(XT1d_temp)) = -100;

        end
        XT1d_max(kk1,kk2,:)   = max(XT1d_temp(:,:),[],2);
    end
end

XT1d_rho_max   = squeeze(mean(XT1d_max,1));

%% Plot Crosstalk as a function of displacement
figure(111);
semilogx(rho,XT1d_rho_max,'LineWidth',2);grid
axis([1e-4 1e-1 -80 20])
legend('LP01','LP02','LP11','LP21')
