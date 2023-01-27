function [CoupMatLPab] = fmf6CoupMat_DEN_MULT(rho,XT1d_rho_max,XT2d_rho_max,fNmodes,pc,vg,Disp,S,bf,KuvSurf,f0,lossCoef,L,dz,XTavg_km,XTstd,RR,RefL,xtTagl,xtTagr,backOff,lzMax,MF)
%Three Mode Fiber Linear Transmission Matrix (LP01, LP11a, LP11b)
%
% USAGE
%	SigOut = fmf3_matrix(f,lossCoef,L,dz);
%
% INPUTS
%    pc        - [mode 1 effective index ; mode 2 effective index ; ... ]
%    vg        - [mode 1 group velocity  ; mode 2 group velocity  ; ... ]
%    Disp      - [mode 1 dispersion      ; mode 2 dispersion      ; ... ]
%    S         - [mode 1 dispersion slope; mode 2 dispersion slope; ... ]
%    bf        - fiber birefringence (typical value: 1e-7)
%    Kuv_surf  - mode strength surface of the form:
%                       Kuv12 = KuvSurf(1,2).s(dx , dy);
%                       Kuv13 = KuvSurf(1,3).s(dx , dy);
%                       Kuv23 = KuvSurf(2,3).s(dx , dy);
%    maxDisp   - maximum radial displacement (typical value: 1/100)
%    f         - Frequency Vector (Centered at 0)
%    f0        - Center Frequency
%    lossCoef  - Fiber attenuation (dB/km)
%    L         - Fiber length (m)
%    dz        - Step length (m) (typical value: 100)
%
% OUTPUTS
%    H - three mode fiber matrix
%
%
% REFERENCES
%
%
% REVISION
%	18-07-2011 10:08:29 - created by Filipe Ferreira
%	02-04-2012 12:10:01

%% Physical constans
e0      = 8.854187817e-12;
u0      = 1.25663706e-6;
c0      = 1/sqrt(e0*u0);

%% Propagations constants load or calculation
nModes = 6;

%% parameters and global variables
att = lossCoef/(10*log10(exp(1)))/1e3;	% Np/m

w0      = 2*pi*f0;

nsteps = ceil(L/dz);

%% deltaBeta1 for LPuv,ab,xy
for k1 = 1:nModes
    for k2 = 1:nModes
        deltaBeta1(k1,k2) = ( pc(k1) - pc(k2) ) * w0 / c0 / 2;
    end
end
dB12 = deltaBeta1(1,2); dB13 = deltaBeta1(1,3); dB14 = deltaBeta1(1,4); dB15 = deltaBeta1(1,5); dB16 = deltaBeta1(1,6);
dB23 = deltaBeta1(2,3); dB24 = deltaBeta1(2,4); dB25 = deltaBeta1(2,5); dB26 = deltaBeta1(2,6);
dB34 = deltaBeta1(3,4); dB35 = deltaBeta1(3,5); dB36 = deltaBeta1(3,6);
dB45 = deltaBeta1(4,5); dB46 = deltaBeta1(4,6);
dB56 = deltaBeta1(5,6);

%% Input & Output Modes
inM = [];
for k1 = 1:6
    if fNmodes(xtTagl).vIndex == fNmodes(k1).vIndex && fNmodes(xtTagl).uIndex == fNmodes(k1).uIndex
        inM = [inM k1];
    end
end
outM = [];
if xtTagr > 0
    for k1 = 1:6
        if fNmodes(xtTagr).vIndex == fNmodes(k1).vIndex && fNmodes(xtTagr).uIndex == fNmodes(k1).uIndex
            outM = [outM k1];
        end
    end
else
    for k1 = 1:6
        if isempty(find(k1 == inM))
            outM = [outM k1];
        end
    end
end

% %% Calculate average Displacement
% tic
% [PATHSTR,NAME,EXT] = fileparts(pwd);
% [PATHSTR,NAME,EXT] = fileparts(PATHSTR);
% if strcmp(NAME,'execute') == 1 || strcmp(NAME,'CondorASTON') == 1
%     fileName1  = ['targetDMD=',num2str(0),'_',num2str(1/1000),'_',num2str(0.8),'_',num2str(10000),'_DEN'];
%     load(['rho_',fileName1,'.mat'])
%     if xtTagr == 0
%         load(['XT1d_rho_max_', fileName1,'.mat']);
%     else
%         load(['XT2d_rho_max_', fileName1,'.mat']);
%     end
% else
%     [rho,XT1d_rho_max,XT2d_rho_max] = disp6xt_CMT2d_DEN( 0, 10000, 1/1000 , 0.8);%1/1000
% end
% toc
% 123
% ,XT1d_rho_mean,XT1d_rho_mean2,XT2d_rho_mean,XT2d_rho_mean2,xDisp,yDisp,phi,XT1d_max,XT2d_max,XT1d_mean,XT2d_mean,XT1d_mean2,XT2d_mean2
% figure(3)
% for k1 = 1:6
%     subplot(3,2,k1)
%     contour(xDisp,yDisp,XT1d_max(:,:,k1).',[-40 -30 -20 -10 -5  0  5 10 15 20],'ShowText','On');
% end
% figure(31)
% for k1 = 1:6
%     subplot(3,2,k1)
%     clear aux; aux(:,:) = XT1d_max(:,:,k1).';
%     aux(aux<-50)=-50;
%     aux(aux>+10)=+10;
%     surf(xDisp,yDisp,aux,'EdgeColor','none','LineStyle','none','FaceLighting','phong');colorbar;view([0 0 1])
% end
% 
% figure(4)
% for k1 = 1:6
%     for k2 = 1:6
%         if k1 == k2; continue; end
%         subplot(6,6,6*(k1-1)+k2)
%         contour(xDisp,yDisp,XT2d_max(:,:,k1,k2).',[-40 -20 -10 0 10 ],'ShowText','On');
%     end
% end
% figure(41)
% for k1 = 1:6
%     for k2 = 1:6
%         if k1 == k2; continue; end
%         subplot(6,6,6*(k1-1)+k2)
%         clear aux; aux(:,:) = XT2d_max(:,:,k1,k2).';
%         aux(aux<-50)=-50;
%     	aux(aux>+10)=+10;
%         surf(xDisp,yDisp,aux,'EdgeColor','none','LineStyle','none','FaceLighting','phong');view([0 0 1])
%     end
% end
% 
% figure(5)
% for k1 = 1:6
%     for k2 = 1:6
%         if k1 == k2; continue; end
%         subplot(6,6,6*(k1-1)+k2)
%         clear aux; aux(:,:) = XT2d_max(:,:,k1,k2).'+0;
%         aux(aux < -50) = -50;
% aux(aux < 0) = -5;
% aux(aux > 0) = 5;
%         surf(xDisp,yDisp,aux,'EdgeColor','none');view([0 0 1])
%     end
% end
% 
% 
% figure(123);
% for k1 = 1:6
%     subplot(3,2,k1)
%     plot(10*log10(rho),XT1d_rho_max(:,k1),'.-'); hold on
% %     plot(rho,XT1d_rho_max(:,k1)-backOff,'r');
% %     plot(rho,XT1d_rho_mean(:,k1),'--');
% %     plot(rho,XT1d_rho_mean2(:,k1),':'); hold off
%     grid
%     axis([-40 0 -50 20])
% end
% 
% figure(324);
% for k1 = 1:6
%     for k2 = 1:6
%         if k1 == k2; continue; end
%         subplot(6,6,6*(k1-1)+k2)
%         plot(10*log10(rho),XT2d_rho_max(:,k1,k2)); hold on
%         plot(10*log10(rho),XT2d_rho_max(:,k1,k2)-backOff,'r');
% %         plot(rho,XT2d_rho_mean(:,k1,k2),'--');
% %         plot(rho,XT2d_rho_mean2(:,k1,k2),':'); hold off
%         grid
%         axis([-40 0 -50 20])
%     end
% end

% figure(623)
% plot(rho,XT2d_rho_max(:,2,5),'-'); hold on
% plot(rho,XT2d_rho_max(:,2,5)-backOff,'r');
% plot(rho,XT2d_rho_mean(:,2,5),'--');
% plot(rho,XT2d_rho_mean2(:,2,5),':'); hold off
% axis([0 0.15 -50 20]);grid

if ~isinf(XTavg_km)
    clear aux;
    if xtTagr == 0
        aux(:,:) = XT1d_rho_max(:,xtTagl) - backOff;
    else
        aux(:,:) = XT2d_rho_max(:,xtTagl,xtTagr) - backOff;
    end

    rhoExt = rho(2):1/10000:rho(end);
    auxExt = interp1(rho(2:end),aux(2:end),rhoExt);
    % clear rho;

    XTavg_dz   = XTavg_km + 10*log10(dz/1000);
    Ind    = 2;
    auxExt(isnan(auxExt)) = -100;
    while auxExt(Ind) < XTavg_dz && Ind < length(auxExt)
        Ind = Ind + 1;
    end

    XTavg      = XTavg_km + 10*log10(L/1000);

    XTavg_RefL = XTavg_km + 10*log10(RefL/1000);
end

% figure(623)
% plot(rho,aux+backOff,'-'); hold on
% plot(rho,aux,'r');
% plot(rhoExt(Ind),auxExt(Ind),'+');hold off
% axis([0 0.3 -50 20]);grid

%% Coupling Matrix between LPuv,ab (ignoring polarizations)
coupMat = zeros(nModes,nModes,lzMax);
Aout    = zeros(nModes,nModes,lzMax);

XT1d_temp = zeros(nModes,lzMax);
XT2d_temp = zeros(nModes,nModes,lzMax);

if XTavg_km == +Inf
    for z = 1:nsteps
        % auxCoup = randn(6,6);
        % [Q,R] = qr(auxCoup);
        % CoupMatLPab(z).c(1:1:6,1:1:6) = Q;
        auxCoup = sqrt(1/2) * (randn(nModes,nModes) + 1i*randn(nModes,nModes));
        [Q,R] = qr(auxCoup);
        CoupMatLPab(z).c(1:1:6,1:1:6) = Q;
    end
elseif XTavg_km == -Inf
    for z = 1:nsteps
        CoupMatLPab(z).c(1:1:6,1:1:6) = eye(nModes);
    end
else
    nsteps_RefL = RefL/dz;
    h = tic;
    for kx = 1:MF:nsteps/nsteps_RefL
        if rem(kx,100) == 0
            tt = toc(h);
            disp([num2str(kx),' out of ',num2str(nsteps/nsteps_RefL),' - tte = ',num2str(tt*(nsteps/nsteps_RefL-kx)/60/100),' min'])
            h = tic;
%             disp(tt)
        end
%         tic
        while 1
            % Random Fiber Core Displacement
            rInd = Ind + RR*round(2*(rand-0.5));
            if rInd < 1; rInd = 1; end
            drho = rhoExt( rInd ); % Uniform distribution
            dphi = 2*pi    * rand(1); % Uniform distribution
            
            dx = drho .* cos(dphi);
            dy = drho .* sin(dphi);
            
            varC = 1;
            
            k12 = KuvSurf(1,2).s(dx , dy)/varC; k13 = KuvSurf(1,3).s(dx , dy)/varC; k14 = KuvSurf(1,4).s(dx , dy)/varC; k15 = KuvSurf(1,5).s(dx , dy)/varC; k16 = KuvSurf(1,6).s(dx , dy)/varC;
            k23 = KuvSurf(2,3).s(dx , dy)/varC; k24 = KuvSurf(2,4).s(dx , dy)/varC; k25 = KuvSurf(2,5).s(dx , dy)/varC; k26 = KuvSurf(2,6).s(dx , dy)/varC;
            k34 = KuvSurf(3,4).s(dx , dy)/varC; k35 = KuvSurf(3,5).s(dx , dy)/varC; k36 = KuvSurf(3,6).s(dx , dy)/varC;
            k45 = KuvSurf(4,5).s(dx , dy)/varC; k46 = KuvSurf(4,6).s(dx , dy)/varC;
            k56 = KuvSurf(5,6).s(dx , dy)/varC;
            
            kuvX = [0   k12 k13 k14 k15 k16 
                    k12 0   k23 k24 k25 k26 
                    k13 k23 0   k34 k35 k36
                    k14 k24 k34 0   k45 k46
                    k15 k25 k35 k45 0   k56
                    k16 k26 k36 k46 k56 0  ];

%             var1 = 8*2*2*8*2*pi / sqrt(abs(dB25^2 + 4*k12^2 + 4*k13^2 + 4*k14^2 + 4*k23^2 + 4*k24^2 + 4*k34^2));
            zMax = rand(1,lzMax)*100;%linspace(0,100,lzMax);
%             tic
            [coupMat] = coupMat6x6_mat(zMax,dB12, dB13, dB14, dB15, dB16, dB23, dB24, dB25, dB26, dB34, dB35, dB36, dB45, dB46, dB56, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);
%             toc
%             tic
            PoutX(:,:,:) = abs(coupMat).^2;
            for nM = 1:6
                if nM == 3 || nM == 4
                    PoutZ(:,:) = abs(coupMat(:,nM,:)).^2;
                    
                    XT1d_temp(nM,:) = 10*log10((sum(PoutZ,1)-sum(PoutZ(3:4,:)))./sum(PoutZ(3:4,:)));
                elseif nM == 5 || nM == 6
                    PoutZ(:,:) = abs(coupMat(:,nM,:)).^2;
                    
                    XT1d_temp(nM,:) = 10*log10((sum(PoutZ,1)-sum(PoutZ(5:6,:)))./sum(PoutZ(5:6,:)));
                else
                    PoutZ(:,:) = abs(coupMat(:,nM,:)).^2;
                    
                    XT1d_temp(nM,:) = 10*log10((sum(PoutZ,1)-PoutZ(nM,:))./PoutZ(nM,:));
                end
                
                
                if nM == 3 || nM == 4
                    XT2d_temp(nM,1,:) = 10*log10((PoutZ(1,:))./sum(PoutZ(3:4,:)));
                    XT2d_temp(nM,2,:) = 10*log10((PoutZ(2,:))./sum(PoutZ(3:4,:)));
                    if nM == 3
                        XT2d_temp(nM,3,:) = 10*log10(sum(PoutZ(3,:))./sum(PoutZ(3,:)));
                        XT2d_temp(nM,4,:) = 10*log10(sum(PoutZ(4,:))./sum(PoutZ(3,:)));
                    else
                        XT2d_temp(nM,3,:) = 10*log10(sum(PoutZ(3,:))./sum(PoutZ(4,:)));
                        XT2d_temp(nM,4,:) = 10*log10(sum(PoutZ(4,:))./sum(PoutZ(4,:)));
                    end
                    XT2d_temp(nM,5,:) = 10*log10(sum(PoutZ(5:6,:))./sum(PoutZ(3:4,:)));
                    XT2d_temp(nM,6,:) = 10*log10(sum(PoutZ(5:6,:))./sum(PoutZ(3:4,:)));
                elseif nM == 5 || nM == 6
                    XT2d_temp(nM,1,:) = 10*log10((PoutZ(1,:))./sum(PoutZ(5:6,:)));
                    XT2d_temp(nM,2,:) = 10*log10((PoutZ(2,:))./sum(PoutZ(5:6,:)));
                    XT2d_temp(nM,3,:) = 10*log10(sum(PoutZ(3:4,:))./sum(PoutZ(5:6,:)));
                    XT2d_temp(nM,4,:) = 10*log10(sum(PoutZ(3:4,:))./sum(PoutZ(5:6,:)));
                    if nM == 5
                        XT2d_temp(nM,5,:) = 10*log10(sum(PoutZ(5,:))./sum(PoutZ(5,:)));
                        XT2d_temp(nM,6,:) = 10*log10(sum(PoutZ(6,:))./sum(PoutZ(5,:)));
                    else
                        XT2d_temp(nM,5,:) = 10*log10(sum(PoutZ(5,:))./sum(PoutZ(6,:)));
                        XT2d_temp(nM,6,:) = 10*log10(sum(PoutZ(6,:))./sum(PoutZ(6,:)));
                    end
                else
                    XT2d_temp(nM,1,:) = 10*log10((PoutZ(1,:))./PoutZ(nM,:));
                    XT2d_temp(nM,2,:) = 10*log10((PoutZ(2,:))./PoutZ(nM,:));
                    XT2d_temp(nM,3,:) = 10*log10((PoutZ(3,:))./PoutZ(nM,:));
                    XT2d_temp(nM,4,:) = 10*log10((PoutZ(4,:))./PoutZ(nM,:));
                    XT2d_temp(nM,5,:) = 10*log10((PoutZ(5,:))./PoutZ(nM,:));
                    XT2d_temp(nM,6,:) = 10*log10((PoutZ(6,:))./PoutZ(nM,:));
                end
                
                XT1d_temp(isinf(XT1d_temp)) = -100;
                XT2d_temp(isinf(XT2d_temp)) = -100;
            end
%             toc


% %             tic
%             for z1 = 1:lzMax
% %                 [Q,R] = qr(coupMat(:,:,z1));
%                 Q = coupMat(:,:,z1);
%                 PoutX(:,:) = abs(Q).^2;
%                 
%                 for nM = 1:6
%                     PoutZ = PoutX(:,nM);
%                     XT1d_temp(nM,:) = 10*log10((sum(PoutZ,1)-PoutZ(nM,:))./PoutZ(nM,:));
% 
%                     XT2d_temp(nM,:,z1) = 10*log10((PoutZ(:,:))./PoutZ(nM,:));
% %                     XT2d_temp(nM,2,z1) = 10*log10((PoutZ(2,:))./PoutZ(nM,:));
% %                     XT2d_temp(nM,3,z1) = 10*log10((PoutZ(3,:))./PoutZ(nM,:));
% %                     XT2d_temp(nM,4,z1) = 10*log10((PoutZ(4,:))./PoutZ(nM,:));
% %                     XT2d_temp(nM,5,z1) = 10*log10((PoutZ(5,:))./PoutZ(nM,:));
% %                     XT2d_temp(nM,6,z1) = 10*log10((PoutZ(6,:))./PoutZ(nM,:));
%                 end
%             end
% %             toc
            
            if xtTagr == 0
                [difer,IndX] = sort( abs( XT1d_temp(xtTagl,:) - XTavg_RefL ) );
                XT = mean(XT1d_temp(xtTagl,IndX(1:MF)));
            else
                [difer,IndX] = sort( abs( XT2d_temp(xtTagl,xtTagr,:) - XTavg_RefL ) );
                XT = mean(XT2d_temp(xtTagl,xtTagr,IndX));
            end

            for c1 = 0:MF-1
                CoupMatLPab(kx+c1).c = coupMat(:,:,IndX(c1+1));
%                 abs(coupMat(:,:,IndX(c1+1)))
            end
            
%             figure(515)
%             plot(zMax,XT1d_temp,'.',zMax(IndX),XT1d_temp(xtTagl,IndX),'s');
            
%             figure(854)
%             for k1 = 1:6
%                 for k2 = 1:6
%                     if k1 == k2; continue; end
%                     subplot(6,6,6*(k1-1) + k2)
%                     clear aux; aux(:,:) = XT2d_temp(k1,k2,:);
%                     plot(zMax,aux,'.')
%                     axis([min(zMax) max(zMax) -60 20])
%                     title(['dB/k=',num2str(deltaBeta1(k1,k2) ./ kuvX(k1,k2))])
%                     grid
%                 end
%             end
%             toc
            if ~(XT > XTavg_RefL+XTstd || XT < XTavg_RefL-XTstd)
%                 disp(['XTfmf = ',num2str(XT),' dB - target XT = ',num2str(XTavg_RefL),' dB'])
                break;
            else
                %                 disp(['XT = ',num2str(XT),'dB - Try again!  '])
                %                 123;
            end
        end
    end
end