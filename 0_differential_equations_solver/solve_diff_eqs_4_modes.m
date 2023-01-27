clc
clear
close all

%% ODE symbolic math solution
%% Solve coupled differential equation system
syms k12 k13 k14 k23 k24 k34 B1 B2 B3 B4 w

A1 = sym('A1(w)'); A2 = sym('A2(w)'); A3 = sym('A3(w)'); A4 = sym('A4(w)');

%% E3 - E4
%1
aA1 = (-1*k12*subs(A2,w,w-(B1-B2))-1*k13*subs(A3,w,w-(B1-B3))-1*k14*subs(A4,w,w-(B1-B4)))/w;
aA2 = (-1*k12*subs(A1,w,w+(B1-B2))-1*k23*subs(A3,w,w-(B2-B3))-1*k24*subs(A4,w,w-(B2-B4)))/w;
aA3 = (-1*k13*subs(A1,w,w+(B1-B3))-1*k23*subs(A2,w,w+(B2-B3))-1*k34*subs(A4,w,w-(B3-B4)))/w;
aA4 = (-1*k14*subs(A1,w,w+(B1-B4))-1*k24*subs(A2,w,w+(B2-B4))-1*k34*subs(A3,w,w+(B3-B4)))/w;

%2
a2A2 = (subs(aA2,'A1(w+(B1-B2))',subs(aA1,w,w+(B1-B2))));
a2A3 = (subs(aA3,'A1(w+(B1-B3))',subs(aA1,w,w+(B1-B3))));
a2A4 = (subs(aA4,'A1(w+(B1-B4))',subs(aA1,w,w+(B1-B4))));

coef_a2A2 = simplify(subs((a2A2-subs(a2A2,'A2(w)',0)),'A2(w)',1));
coef_a2A3 = simplify(subs((a2A3-subs(a2A3,'A3(w)',0)),'A3(w)',1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,'A4(w)',0)),'A4(w)',1));

a2A2 = subs(a2A2,'A2(w)',0) / (1-coef_a2A2);
a2A3 = subs(a2A3,'A3(w)',0) / (1-coef_a2A3);
a2A4 = subs(a2A4,'A4(w)',0) / (1-coef_a2A4);

%3
a3A3 = (subs(a2A3,'A2(w+(B2-B3))',subs(a2A2,w,w+(B2-B3))));
a3A4 = (subs(a2A4,'A2(w+(B2-B4))',subs(a2A2,w,w+(B2-B4))));

coef_a3A3 = simplify(subs((a3A3-subs(a3A3,'A3(w)',0)),'A3(w)',1));
coef_a3A4 = simplify(subs((a3A4-subs(a3A4,'A4(w)',0)),'A4(w)',1));

a3A3 = simplify(subs(a3A3,'A3(w)',0) / (1-coef_a3A3));
a3A4 = simplify(subs(a3A4,'A4(w)',0) / (1-coef_a3A4));

%4
a4A3 = simplify(subs(a3A3,'A4(w-(B3-B4))',subs(a3A4,w,w-(B3-B4))));
a4A4 = simplify(subs(a3A4,'A3(w+(B3-B4))',subs(a3A3,w,w+(B3-B4))));

%end
[NR3,DR3] = numden(subs(a4A3,'A3(w)',1));
[NR4,DR4] = numden(subs(a4A4,'A4(w)',1));

eq3 = (1-subs(a4A3,'A3(w)',1));
eq4 = (1-subs(a4A4,'A4(w)',1));

%% E1 - E2
%1 - Elimination of E3
a2A1 = (subs(aA1,'A3(w-(B1-B3))',subs(aA3,w,w-(B1-B3))));
a2A2 = (subs(aA2,'A3(w-(B2-B3))',subs(aA3,w,w-(B2-B3))));
a2A4 = (subs(aA4,'A3(w+(B3-B4))',subs(aA3,w,w+(B3-B4))));

coef_a2A1 = simplify(subs((a2A1-subs(a2A1,'A1(w)',0)),'A1(w)',1));
coef_a2A2 = simplify(subs((a2A2-subs(a2A2,'A2(w)',0)),'A2(w)',1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,'A4(w)',0)),'A4(w)',1));

a2A1 = subs(a2A1,'A1(w)',0) / (1-coef_a2A1);
a2A2 = subs(a2A2,'A2(w)',0) / (1-coef_a2A2);
a2A4 = subs(a2A4,'A4(w)',0) / (1-coef_a2A4);

%2 - Elimination of E4
a3A1 = (subs(a2A1,'A4(w-(B1-B4))',subs(a2A4,w,w-(B1-B4))));
a3A2 = (subs(a2A2,'A4(w-(B2-B4))',subs(a2A4,w,w-(B2-B4))));

coef_a3A1 = simplify(subs((a3A1-subs(a3A1,'A1(w)',0)),'A1(w)',1));
coef_a3A2 = simplify(subs((a3A2-subs(a3A2,'A2(w)',0)),'A2(w)',1));

a3A1 = simplify(subs(a3A1,'A1(w)',0) / (1-coef_a3A1));
a3A2 = simplify(subs(a3A2,'A2(w)',0) / (1-coef_a3A2));

%3
a4A1 = simplify(subs(a3A1,'A2(w-(B1-B2))',subs(a3A2,w,w-(B1-B2))));
a4A2 = simplify(subs(a3A2,'A1(w+(B1-B2))',subs(a3A1,w,w+(B1-B2))));

%end
[NR1,DR1] = numden(subs(a4A1,'A1(w)',1));
[NR2,DR2] = numden(subs(a4A2,'A2(w)',1));

eq1 = (1-subs(a4A1,'A1(w)',1));
eq2 = (1-subs(a4A2,'A2(w)',1));

%% Charateristic Polinomial Simplification
[N1,D1] = numden(eq1);
[N2,D2] = numden(eq2);
[N3,D3] = numden(eq3);
[N4,D4] = numden(eq4);

[C1, T1] = coeffs(N1,w);
[C2, T2] = coeffs(N2,w);
[C3, T3] = coeffs(N3,w);
[C4, T4] = coeffs(N4,w);

syms dB12 dB13 dB14 dB23 dB24 dB34
C1 = subs(C1,B1,dB12+B2);
C1 = subs(C1,B2,-dB12+B1);
C1 = subs(C1,B1,dB13+B3);
C1 = subs(C1,B3,-dB13+B1);
C1 = subs(C1,B1,dB14+B4);
C1 = subs(C1,B4,-dB14+B1);
C1 = subs(C1,B2,dB23+B3);
C1 = subs(C1,B3,-dB23+B2);
C1 = subs(C1,B2,dB24+B4);
C1 = subs(C1,B4,-dB24+B2);
C1 = subs(C1,B3,dB34+B4);
C1 = subs(C1,B4,-dB34+B3);
C1 = simplify(C1);

C2 = subs(C2,B1,dB12+B2);
C2 = subs(C2,B2,-dB12+B1);
C2 = subs(C2,B1,dB13+B3);
C2 = subs(C2,B3,-dB13+B1);
C2 = subs(C2,B1,dB14+B4);
C2 = subs(C2,B4,-dB14+B1);
C2 = subs(C2,B2,dB23+B3);
C2 = subs(C2,B3,-dB23+B2);
C2 = subs(C2,B2,dB24+B4);
C2 = subs(C2,B4,-dB24+B2);
C2 = subs(C2,B3,dB34+B4);
C2 = subs(C2,B4,-dB34+B3);
C2 = simplify(C2);

C3 = subs(C3,B1,dB12+B2);
C3 = subs(C3,B2,-dB12+B1);
C3 = subs(C3,B1,dB13+B3);
C3 = subs(C3,B3,-dB13+B1);
C3 = subs(C3,B1,dB14+B4);
C3 = subs(C3,B4,-dB14+B1);
C3 = subs(C3,B2,dB23+B3);
C3 = subs(C3,B3,-dB23+B2);
C3 = subs(C3,B2,dB24+B4);
C3 = subs(C3,B4,-dB24+B2);
C3 = subs(C3,B3,dB34+B4);
C3 = subs(C3,B4,-dB34+B3);
C3 = simplify(C3);

C4 = subs(C4,B1,dB12+B2);
C4 = subs(C4,B2,-dB12+B1);
C4 = subs(C4,B1,dB13+B3);
C4 = subs(C4,B3,-dB13+B1);
C4 = subs(C4,B1,dB14+B4);
C4 = subs(C4,B4,-dB14+B1);
C4 = subs(C4,B2,dB23+B3);
C4 = subs(C4,B3,-dB23+B2);
C4 = subs(C4,B2,dB24+B4);
C4 = subs(C4,B4,-dB24+B2);
C4 = subs(C4,B3,dB34+B4);
C4 = subs(C4,B4,-dB34+B3);
C4 = simplify(C4);
clear B1 B2 B3 B4

syms X
CC1 = C1*[X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC2 = C2*[X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC3 = C3*[X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC4 = C4*[X^6 X^5 X^4 X^3 X^2 X^1 X^0].';

%% Boundary conditions
syms  z

clear A1 A2 A3 A4
A1 = sym('A1(z)'); A2 = sym('A2(z)'); A3 = sym('A3(z)'); A4 = sym('A4(z)');

dA1 = -1i*k12*A2*exp( 1i*(dB12)*z)-1i*k13*A3*exp( 1i*(dB13)*z)-1i*k14*A4*exp( 1i*(dB14)*z);
dA2 = -1i*k12*A1*exp(-1i*(dB12)*z)-1i*k23*A3*exp( 1i*(dB23)*z)-1i*k24*A4*exp( 1i*(dB24)*z);
dA3 = -1i*k13*A1*exp(-1i*(dB13)*z)-1i*k23*A2*exp(-1i*(dB23)*z)-1i*k34*A4*exp( 1i*(dB34)*z);
dA4 = -1i*k14*A1*exp(-1i*(dB14)*z)-1i*k24*A2*exp(-1i*(dB24)*z)-1i*k34*A3*exp(-1i*(dB34)*z);

%1
d2A1 = diff(dA1,z);
d2A2 = diff(dA2,z);
d2A3 = diff(dA3,z);
d2A4 = diff(dA4,z);

d2A1 = (subs(d2A1,diff(A1,z),dA1));
d2A1 = (subs(d2A1,diff(A2,z),dA2));
d2A1 = (subs(d2A1,diff(A3,z),dA3));
d2A1 = (subs(d2A1,diff(A4,z),dA4));

d2A2 = (subs(d2A2,diff(A1,z),dA1));
d2A2 = (subs(d2A2,diff(A2,z),dA2));
d2A2 = (subs(d2A2,diff(A3,z),dA3));
d2A2 = (subs(d2A2,diff(A4,z),dA4));

d2A3 = (subs(d2A3,diff(A1,z),dA1));
d2A3 = (subs(d2A3,diff(A2,z),dA2));
d2A3 = (subs(d2A3,diff(A3,z),dA3));
d2A3 = (subs(d2A3,diff(A4,z),dA4));

d2A4 = (subs(d2A4,diff(A1,z),dA1));
d2A4 = (subs(d2A4,diff(A2,z),dA2));
d2A4 = (subs(d2A4,diff(A3,z),dA3));
d2A4 = (subs(d2A4,diff(A4,z),dA4));

%2
d3A1 = diff(d2A1,z);
d3A2 = diff(d2A2,z);
d3A3 = diff(d2A3,z);
d3A4 = diff(d2A4,z);

d3A1 = (subs(d3A1,diff(A1,z),dA1));
d3A1 = (subs(d3A1,diff(A2,z),dA2));
d3A1 = (subs(d3A1,diff(A3,z),dA3));
d3A1 = (subs(d3A1,diff(A4,z),dA4));

d3A2 = (subs(d3A2,diff(A1,z),dA1));
d3A2 = (subs(d3A2,diff(A2,z),dA2));
d3A2 = (subs(d3A2,diff(A3,z),dA3));
d3A2 = (subs(d3A2,diff(A4,z),dA4));

d3A3 = (subs(d3A3,diff(A1,z),dA1));
d3A3 = (subs(d3A3,diff(A2,z),dA2));
d3A3 = (subs(d3A3,diff(A3,z),dA3));
d3A3 = (subs(d3A3,diff(A4,z),dA4));

d3A4 = (subs(d3A4,diff(A1,z),dA1));
d3A4 = (subs(d3A4,diff(A2,z),dA2));
d3A4 = (subs(d3A4,diff(A3,z),dA3));
d3A4 = (subs(d3A4,diff(A4,z),dA4));

%3
d4A1 = diff(d3A1,z);
d4A2 = diff(d3A2,z);
d4A3 = diff(d3A3,z);
d4A4 = diff(d3A4,z);

d4A1 = (subs(d4A1,diff(A1,z),dA1));
d4A1 = (subs(d4A1,diff(A2,z),dA2));
d4A1 = (subs(d4A1,diff(A3,z),dA3));
d4A1 = (subs(d4A1,diff(A4,z),dA4));

d4A2 = (subs(d4A2,diff(A1,z),dA1));
d4A2 = (subs(d4A2,diff(A2,z),dA2));
d4A2 = (subs(d4A2,diff(A3,z),dA3));
d4A2 = (subs(d4A2,diff(A4,z),dA4));

d4A3 = (subs(d4A3,diff(A1,z),dA1));
d4A3 = (subs(d4A3,diff(A2,z),dA2));
d4A3 = (subs(d4A3,diff(A3,z),dA3));
d4A3 = (subs(d4A3,diff(A4,z),dA4));

d4A4 = (subs(d4A4,diff(A1,z),dA1));
d4A4 = (subs(d4A4,diff(A2,z),dA2));
d4A4 = (subs(d4A4,diff(A3,z),dA3));
d4A4 = (subs(d4A4,diff(A4,z),dA4));

%4
d5A1 = diff(d4A1,z);
d5A2 = diff(d4A2,z);
d5A3 = diff(d4A3,z);
d5A4 = diff(d4A4,z);

d5A1 = (subs(d5A1,diff(A1,z),dA1));
d5A1 = (subs(d5A1,diff(A2,z),dA2));
d5A1 = (subs(d5A1,diff(A3,z),dA3));
d5A1 = (subs(d5A1,diff(A4,z),dA4));

d5A2 = (subs(d5A2,diff(A1,z),dA1));
d5A2 = (subs(d5A2,diff(A2,z),dA2));
d5A2 = (subs(d5A2,diff(A3,z),dA3));
d5A2 = (subs(d5A2,diff(A4,z),dA4));

d5A3 = (subs(d5A3,diff(A1,z),dA1));
d5A3 = (subs(d5A3,diff(A2,z),dA2));
d5A3 = (subs(d5A3,diff(A3,z),dA3));
d5A3 = (subs(d5A3,diff(A4,z),dA4));

d5A4 = (subs(d5A4,diff(A1,z),dA1));
d5A4 = (subs(d5A4,diff(A2,z),dA2));
d5A4 = (subs(d5A4,diff(A3,z),dA3));
d5A4 = (subs(d5A4,diff(A4,z),dA4));

BB1 = [subs(A1,'z',0)
       subs(dA1,'z',0)
       subs(d2A1,'z',0)
       subs(d3A1,'z',0)
       subs(d4A1,'z',0)
       subs(d5A1,'z',0)];

BB2 = [subs(A2,'z',0)
       subs(dA2,'z',0)
       subs(d2A2,'z',0)
       subs(d3A2,'z',0)
       subs(d4A2,'z',0)
       subs(d5A2,'z',0)];

BB3 = [subs(A3,'z',0)
       subs(dA3,'z',0)
       subs(d2A3,'z',0)
       subs(d3A3,'z',0)
       subs(d4A3,'z',0)
       subs(d5A3,'z',0)];
   
BB4 = [subs(A4,'z',0)
       subs(dA4,'z',0)
       subs(d2A4,'z',0)
       subs(d3A4,'z',0)
       subs(d4A4,'z',0)
       subs(d5A4,'z',0)];


printEquations4modes
