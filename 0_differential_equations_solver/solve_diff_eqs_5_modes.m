clc
clear
close all

%% ODE symbolic math solution
%% Solve coupled differential equation system
syms k12 k13 k14 k15 k16 k23 k24 k25 k34 k35 k45 B1 B2 B3 B4 B5 w

A1 = sym('A1(w)'); A2 = sym('A2(w)'); A3 = sym('A3(w)'); A4 = sym('A4(w)'); A5 = sym('A5(w)');

% system
aA1 = (-1*k12*subs(A2,w,w-(B1-B2))-1*k13*subs(A3,w,w-(B1-B3))-1*k14*subs(A4,w,w-(B1-B4))-1*k15*subs(A5,w,w-(B1-B5)))/w;
aA2 = (-1*k12*subs(A1,w,w+(B1-B2))-1*k23*subs(A3,w,w-(B2-B3))-1*k24*subs(A4,w,w-(B2-B4))-1*k25*subs(A5,w,w-(B2-B5)))/w;
aA3 = (-1*k13*subs(A1,w,w+(B1-B3))-1*k23*subs(A2,w,w+(B2-B3))-1*k34*subs(A4,w,w-(B3-B4))-1*k35*subs(A5,w,w-(B3-B5)))/w;
aA4 = (-1*k14*subs(A1,w,w+(B1-B4))-1*k24*subs(A2,w,w+(B2-B4))-1*k34*subs(A3,w,w+(B3-B4))-1*k45*subs(A5,w,w-(B4-B5)))/w;
aA5 = (-1*k15*subs(A1,w,w+(B1-B5))-1*k25*subs(A2,w,w+(B2-B5))-1*k35*subs(A3,w,w+(B3-B5))-1*k45*subs(A4,w,w+(B4-B5)))/w;


%% E4 - E5
%1 - Elimination of E1
a2A2 = (subs(aA2,'A1(w+(B1-B2))',subs(aA1,w,w+(B1-B2))));
a2A3 = (subs(aA3,'A1(w+(B1-B3))',subs(aA1,w,w+(B1-B3))));
a2A4 = (subs(aA4,'A1(w+(B1-B4))',subs(aA1,w,w+(B1-B4))));
a2A5 = (subs(aA5,'A1(w+(B1-B5))',subs(aA1,w,w+(B1-B5))));

coef_a2A2 = simplify(subs((a2A2-subs(a2A2,'A2(w)',0)),'A2(w)',1));
coef_a2A3 = simplify(subs((a2A3-subs(a2A3,'A3(w)',0)),'A3(w)',1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,'A4(w)',0)),'A4(w)',1));
coef_a2A5 = simplify(subs((a2A5-subs(a2A5,'A5(w)',0)),'A5(w)',1));

a2A2 = subs(a2A2,'A2(w)',0) / (1-coef_a2A2);
a2A3 = subs(a2A3,'A3(w)',0) / (1-coef_a2A3);
a2A4 = subs(a2A4,'A4(w)',0) / (1-coef_a2A4);
a2A5 = subs(a2A5,'A5(w)',0) / (1-coef_a2A5);

%2 - Elimination of E2
a3A3 = (subs(a2A3,'A2(w+(B2-B3))',subs(a2A2,w,w+(B2-B3))));
a3A4 = (subs(a2A4,'A2(w+(B2-B4))',subs(a2A2,w,w+(B2-B4))));
a3A5 = (subs(a2A5,'A2(w+(B2-B5))',subs(a2A2,w,w+(B2-B5))));

coef_a3A3 = simplify(subs((a3A3-subs(a3A3,'A3(w)',0)),'A3(w)',1));
coef_a3A4 = simplify(subs((a3A4-subs(a3A4,'A4(w)',0)),'A4(w)',1));
coef_a3A5 = simplify(subs((a3A5-subs(a3A5,'A5(w)',0)),'A5(w)',1));

a3A3 = simplify(subs(a3A3,'A3(w)',0) / (1-coef_a3A3));
a3A4 = simplify(subs(a3A4,'A4(w)',0) / (1-coef_a3A4));
a3A5 = simplify(subs(a3A5,'A5(w)',0) / (1-coef_a3A5));

%3 - Elimination of E3
a4A4 = (subs(a3A4,'A3(w+(B3-B4))',subs(a3A3,w,w+(B3-B4))));
a4A5 = (subs(a3A5,'A3(w+(B3-B5))',subs(a3A3,w,w+(B3-B5))));

coef_a4A4 = simplify(subs((a4A4-subs(a4A4,'A4(w)',0)),'A4(w)',1));
coef_a4A5 = simplify(subs((a4A5-subs(a4A5,'A5(w)',0)),'A5(w)',1));

a4A4 = simplify(subs(a4A4,'A4(w)',0) / (1-coef_a4A4));
a4A5 = simplify(subs(a4A5,'A5(w)',0) / (1-coef_a4A5));

%4
a5A4 = (subs(a4A4,'A5(w-(B4-B5))',subs(a4A5,w,w-(B4-B5))));
a5A5 = (subs(a4A5,'A4(w+(B4-B5))',subs(a4A4,w,w+(B4-B5))));

eq4 = simplify(1-subs(a5A4,'A4(w)',1),10);
eq5 = simplify(1-subs(a5A5,'A5(w)',1),10);

%% E1 - E2
%1 - Elimination of E3
a2A1 = (subs(aA1,'A3(w-(B1-B3))',subs(aA3,w,w-(B1-B3))));
a2A2 = (subs(aA2,'A3(w-(B2-B3))',subs(aA3,w,w-(B2-B3))));
a2A4 = (subs(aA4,'A3(w+(B3-B4))',subs(aA3,w,w+(B3-B4))));
a2A5 = (subs(aA5,'A3(w+(B3-B5))',subs(aA3,w,w+(B3-B5))));

coef_a2A1 = simplify(subs((a2A1-subs(a2A1,'A1(w)',0)),'A1(w)',1));
coef_a2A2 = simplify(subs((a2A2-subs(a2A2,'A2(w)',0)),'A2(w)',1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,'A4(w)',0)),'A4(w)',1));
coef_a2A5 = simplify(subs((a2A5-subs(a2A5,'A5(w)',0)),'A5(w)',1));

a2A1 = subs(a2A1,'A1(w)',0) / (1-coef_a2A1);
a2A2 = subs(a2A2,'A2(w)',0) / (1-coef_a2A2);
a2A4 = subs(a2A4,'A4(w)',0) / (1-coef_a2A4);
a2A5 = subs(a2A5,'A5(w)',0) / (1-coef_a2A5);

%2 - Elimination of E4
a3A1 = (subs(a2A1,'A4(w-(B1-B4))',subs(a2A4,w,w-(B1-B4))));
a3A2 = (subs(a2A2,'A4(w-(B2-B4))',subs(a2A4,w,w-(B2-B4))));
a3A5 = (subs(a2A5,'A4(w+(B4-B5))',subs(a2A4,w,w+(B4-B5))));

coef_a3A1 = simplify(subs((a3A1-subs(a3A1,'A1(w)',0)),'A1(w)',1));
coef_a3A2 = simplify(subs((a3A2-subs(a3A2,'A2(w)',0)),'A2(w)',1));
coef_a3A5 = simplify(subs((a3A5-subs(a3A5,'A5(w)',0)),'A5(w)',1));

a3A1 = simplify(subs(a3A1,'A1(w)',0) / (1-coef_a3A1));
a3A2 = simplify(subs(a3A2,'A2(w)',0) / (1-coef_a3A2));
a3A5 = simplify(subs(a3A5,'A5(w)',0) / (1-coef_a3A5));

%2 - Elimination of E5
a4A1 = (subs(a3A1,'A5(w-(B1-B5))',subs(a3A5,w,w-(B1-B5))));
a4A2 = (subs(a3A2,'A5(w-(B2-B5))',subs(a3A5,w,w-(B2-B5))));

coef_a4A1 = simplify(subs((a4A1-subs(a4A1,'A1(w)',0)),'A1(w)',1));
coef_a4A2 = simplify(subs((a4A2-subs(a4A2,'A2(w)',0)),'A2(w)',1));

a4A1 = simplify(subs(a4A1,'A1(w)',0) / (1-coef_a4A1));
a4A2 = simplify(subs(a4A2,'A2(w)',0) / (1-coef_a4A2));

%3
a5A1 = (subs(a4A1,'A2(w-(B1-B2))',subs(a4A2,w,w-(B1-B2))));
a5A2 = (subs(a4A2,'A1(w+(B1-B2))',subs(a4A1,w,w+(B1-B2))));

eq1 = simplify(1-subs(a5A1,'A1(w)',1),10);
eq2 = simplify(1-subs(a5A2,'A2(w)',1),10);

%% E3 - E4
%1 - Elimination of E1
a2A2 = (subs(aA2,'A1(w+(B1-B2))',subs(aA1,w,w+(B1-B2))));
a2A3 = (subs(aA3,'A1(w+(B1-B3))',subs(aA1,w,w+(B1-B3))));
a2A4 = (subs(aA4,'A1(w+(B1-B4))',subs(aA1,w,w+(B1-B4))));
a2A5 = (subs(aA5,'A1(w+(B1-B5))',subs(aA1,w,w+(B1-B5))));

coef_a2A2 = simplify(subs((a2A2-subs(a2A2,'A2(w)',0)),'A2(w)',1));
coef_a2A3 = simplify(subs((a2A3-subs(a2A3,'A3(w)',0)),'A3(w)',1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,'A4(w)',0)),'A4(w)',1));
coef_a2A5 = simplify(subs((a2A5-subs(a2A5,'A5(w)',0)),'A5(w)',1));

a2A2 = subs(a2A2,'A2(w)',0) / (1-coef_a2A2);
a2A3 = subs(a2A3,'A3(w)',0) / (1-coef_a2A3);
a2A4 = subs(a2A4,'A4(w)',0) / (1-coef_a2A4);
a2A5 = subs(a2A5,'A5(w)',0) / (1-coef_a2A5);

%2 - Elimination of E2
a3A3 = (subs(a2A3,'A2(w+(B2-B3))',subs(a2A2,w,w+(B2-B3))));
a3A4 = (subs(a2A4,'A2(w+(B2-B4))',subs(a2A2,w,w+(B2-B4))));
a3A5 = (subs(a2A5,'A2(w+(B2-B5))',subs(a2A2,w,w+(B2-B5))));

coef_a3A3 = simplify(subs((a3A3-subs(a3A3,'A3(w)',0)),'A3(w)',1));
coef_a3A4 = simplify(subs((a3A4-subs(a3A4,'A4(w)',0)),'A4(w)',1));
coef_a3A5 = simplify(subs((a3A5-subs(a3A5,'A5(w)',0)),'A5(w)',1));

a3A3 = simplify(subs(a3A3,'A3(w)',0) / (1-coef_a3A3));
a3A4 = simplify(subs(a3A4,'A4(w)',0) / (1-coef_a3A4));
a3A5 = simplify(subs(a3A5,'A5(w)',0) / (1-coef_a3A5));

%3 - Elimination of E5
a4A3 = (subs(a3A3,'A5(w-(B3-B5))',subs(a3A5,w,w-(B3-B5))));
a4A4 = (subs(a3A4,'A5(w-(B4-B5))',subs(a3A5,w,w-(B4-B5))));

coef_a4A3 = simplify(subs((a4A3-subs(a4A3,'A3(w)',0)),'A3(w)',1));
coef_a4A4 = simplify(subs((a4A4-subs(a4A4,'A4(w)',0)),'A4(w)',1));

a4A3 = simplify(subs(a4A3,'A3(w)',0) / (1-coef_a4A3));
a4A4 = simplify(subs(a4A4,'A4(w)',0) / (1-coef_a4A4));

%4
a5A3 = (subs(a4A3,'A4(w-(B3-B4))',subs(a4A4,w,w-(B3-B4))));

eq3 = simplify(1-subs(a5A3,'A3(w)',1),10);

%% Charateristic Polinomial Simplification
[N1,D1] = numden(eq1);
[N2,D2] = numden(eq2);
[N3,D3] = numden(eq3);
[N4,D4] = numden(eq4);
[N5,D5] = numden(eq5);

[C1, T1] = coeffs(N1,w);
[C2, T2] = coeffs(N2,w);
[C3, T3] = coeffs(N3,w);
[C4, T4] = coeffs(N4,w);
[C5, T5] = coeffs(N5,w);

syms dB12 dB13 dB14 dB15 dB23 dB24 dB25 dB34 dB35 dB45
C(1).c = C1;
C(2).c = C2;
C(3).c = C3;
C(4).c = C4;
C(5).c = C5;
for ll = 1:5
    C(ll).c = subs(C(ll).c,B1,dB12+B2);
    C(ll).c = subs(C(ll).c,B2,-dB12+B1);
    C(ll).c = subs(C(ll).c,B1,dB13+B3);
    C(ll).c = subs(C(ll).c,B3,-dB13+B1);
    C(ll).c = subs(C(ll).c,B1,dB14+B4);
    C(ll).c = subs(C(ll).c,B4,-dB14+B1);
    C(ll).c = subs(C(ll).c,B1,dB15+B5);
    C(ll).c = subs(C(ll).c,B5,-dB15+B1);
    C(ll).c = subs(C(ll).c,B2,dB23+B3);
    C(ll).c = subs(C(ll).c,B3,-dB23+B2);
    C(ll).c = subs(C(ll).c,B2,dB24+B4);
    C(ll).c = subs(C(ll).c,B4,-dB24+B2);
    C(ll).c = subs(C(ll).c,B2,dB25+B5);
    C(ll).c = subs(C(ll).c,B5,-dB25+B2);
    C(ll).c = subs(C(ll).c,B3,dB34+B4);
    C(ll).c = subs(C(ll).c,B4,-dB34+B3);
    C(ll).c = subs(C(ll).c,B3,dB35+B5);
    C(ll).c = subs(C(ll).c,B5,-dB35+B3);
    C(ll).c = subs(C(ll).c,B4,dB45+B5);
    C(ll).c = subs(C(ll).c,B5,-dB45+B4);
    
    C(ll).c = subs(C(ll).c,B1,0);
    C(ll).c = subs(C(ll).c,B2,0);
    C(ll).c = subs(C(ll).c,B3,0);
    C(ll).c = subs(C(ll).c,B4,0);
    C(ll).c = subs(C(ll).c,B5,0);
    
    C(ll).c = simplify(C(ll).c);
end
C1 = C(1).c;
C2 = C(2).c;
C3 = C(3).c;
C4 = C(4).c;
C5 = C(5).c;

syms X
CC1 = C1*[X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC2 = C2*[X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC3 = C3*[X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC4 = C4*[X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC5 = C5*[X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';

%% Boundary conditions
syms  z

clear A1 A2 A3 A4 A5
A1 = sym('A1(z)'); A2 = sym('A2(z)'); A3 = sym('A3(z)'); A4 = sym('A4(z)'); A5 = sym('A5(z)');

dA1 = -1i*k12*A2*exp( 1i*(dB12)*z)-1i*k13*A3*exp( 1i*(dB13)*z)-1i*k14*A4*exp( 1i*(dB14)*z)-1i*k15*A5*exp( 1i*(dB15)*z);
dA2 = -1i*k12*A1*exp(-1i*(dB12)*z)-1i*k23*A3*exp( 1i*(dB23)*z)-1i*k24*A4*exp( 1i*(dB24)*z)-1i*k25*A5*exp( 1i*(dB25)*z);
dA3 = -1i*k13*A1*exp(-1i*(dB13)*z)-1i*k23*A2*exp(-1i*(dB23)*z)-1i*k34*A4*exp( 1i*(dB34)*z)-1i*k35*A5*exp( 1i*(dB35)*z);
dA4 = -1i*k14*A1*exp(-1i*(dB14)*z)-1i*k24*A2*exp(-1i*(dB24)*z)-1i*k34*A3*exp(-1i*(dB34)*z)-1i*k45*A5*exp( 1i*(dB45)*z);
dA5 = -1i*k15*A1*exp(-1i*(dB15)*z)-1i*k25*A2*exp(-1i*(dB25)*z)-1i*k35*A3*exp(-1i*(dB35)*z)-1i*k45*A4*exp(-1i*(dB45)*z);

dA(1,1) = dA1;
dA(1,2) = dA2;
dA(1,3) = dA3;
dA(1,4) = dA4;
dA(1,5) = dA5;

disp('Differentiating...')
for ll = 1:6
    dA(ll+1,1) = diff(dA(ll,1),z);
    dA(ll+1,2) = diff(dA(ll,2),z);
    dA(ll+1,3) = diff(dA(ll,3),z);
    dA(ll+1,4) = diff(dA(ll,4),z);
    dA(ll+1,5) = diff(dA(ll,5),z);
end

for ll = 1:6
    %1
    dA(ll+1,1) = diff(dA(ll,1),z);
    dA(ll+1,2) = diff(dA(ll,2),z);
    dA(ll+1,3) = diff(dA(ll,3),z);
    dA(ll+1,4) = diff(dA(ll,4),z);
    dA(ll+1,5) = diff(dA(ll,5),z);
    
    dA(ll+1,1) = (subs(dA(ll+1,1),diff(A1,z),dA1));
    dA(ll+1,1) = (subs(dA(ll+1,1),diff(A2,z),dA2));
    dA(ll+1,1) = (subs(dA(ll+1,1),diff(A3,z),dA3));
    dA(ll+1,1) = (subs(dA(ll+1,1),diff(A4,z),dA4));
    dA(ll+1,1) = (subs(dA(ll+1,1),diff(A5,z),dA5));
    
    dA(ll+1,2) = (subs(dA(ll+1,2),diff(A1,z),dA1));
    dA(ll+1,2) = (subs(dA(ll+1,2),diff(A2,z),dA2));
    dA(ll+1,2) = (subs(dA(ll+1,2),diff(A3,z),dA3));
    dA(ll+1,2) = (subs(dA(ll+1,2),diff(A4,z),dA4));
    dA(ll+1,2) = (subs(dA(ll+1,2),diff(A5,z),dA5));
    
    dA(ll+1,3) = (subs(dA(ll+1,3),diff(A1,z),dA1));
    dA(ll+1,3) = (subs(dA(ll+1,3),diff(A2,z),dA2));
    dA(ll+1,3) = (subs(dA(ll+1,3),diff(A3,z),dA3));
    dA(ll+1,3) = (subs(dA(ll+1,3),diff(A4,z),dA4));
    dA(ll+1,3) = (subs(dA(ll+1,3),diff(A5,z),dA5));
    
    dA(ll+1,4) = (subs(dA(ll+1,4),diff(A1,z),dA1));
    dA(ll+1,4) = (subs(dA(ll+1,4),diff(A2,z),dA2));
    dA(ll+1,4) = (subs(dA(ll+1,4),diff(A3,z),dA3));
    dA(ll+1,4) = (subs(dA(ll+1,4),diff(A4,z),dA4));
    dA(ll+1,4) = (subs(dA(ll+1,4),diff(A5,z),dA5));
    
    dA(ll+1,5) = (subs(dA(ll+1,5),diff(A1,z),dA1));
    dA(ll+1,5) = (subs(dA(ll+1,5),diff(A2,z),dA2));
    dA(ll+1,5) = (subs(dA(ll+1,5),diff(A3,z),dA3));
    dA(ll+1,5) = (subs(dA(ll+1,5),diff(A4,z),dA4));
    dA(ll+1,5) = (subs(dA(ll+1,5),diff(A5,z),dA5));
    ll
end

BB1 = [subs(A1,'z',0)
    subs(dA(1,1),'z',0)
    subs(dA(2,1),'z',0)
    subs(dA(3,1),'z',0)
    subs(dA(4,1),'z',0)
    subs(dA(5,1),'z',0)
    subs(dA(6,1),'z',0)
    subs(dA(7,1),'z',0)];

BB2 = [subs(A1,'z',0)
    subs(dA(1,2),'z',0)
    subs(dA(2,2),'z',0)
    subs(dA(3,2),'z',0)
    subs(dA(4,2),'z',0)
    subs(dA(5,2),'z',0)
    subs(dA(6,2),'z',0)
    subs(dA(7,2),'z',0)];

BB3 = [subs(A1,'z',0)
    subs(dA(1,3),'z',0)
    subs(dA(2,3),'z',0)
    subs(dA(3,3),'z',0)
    subs(dA(4,3),'z',0)
    subs(dA(5,3),'z',0)
    subs(dA(6,3),'z',0)
    subs(dA(7,3),'z',0)];

BB4 = [subs(A1,'z',0)
    subs(dA(1,4),'z',0)
    subs(dA(2,4),'z',0)
    subs(dA(3,4),'z',0)
    subs(dA(4,4),'z',0)
    subs(dA(5,4),'z',0)
    subs(dA(6,4),'z',0)
    subs(dA(7,4),'z',0)];

BB5 = [subs(A1,'z',0)
    subs(dA(1,5),'z',0)
    subs(dA(2,5),'z',0)
    subs(dA(3,5),'z',0)
    subs(dA(4,5),'z',0)
    subs(dA(5,5),'z',0)
    subs(dA(6,5),'z',0)
    subs(dA(7,5),'z',0)];

for ll = 1:7
    for nn = 1:5
        dA(ll,nn) = subs(dA(ll,nn),{'z'},{0});
    end
end

printEquations5modes
