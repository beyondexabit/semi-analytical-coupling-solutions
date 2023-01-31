clc
% clear
close all

syms B1 B2 B3 B4 B5 B6
%% ODE symbolic math solution
%% Solve coupled differential equation system
syms k12 k13 k14 k15 k16 k23 k24 k25 k26 k34 k35 k36 k45 k46 k56  w

syms A1(w) A2(w) A3(w) A4(w) A5(w) A6(w)

% system
aA1 = (-1*k12*subs(A2,w,w-(B1-B2))-1*k13*subs(A3,w,w-(B1-B3))-1*k14*subs(A4,w,w-(B1-B4))-1*k15*subs(A5,w,w-(B1-B5))-1*k16*subs(A6,w,w-(B1-B6)))/w;
aA2 = (-1*k12*subs(A1,w,w+(B1-B2))-1*k23*subs(A3,w,w-(B2-B3))-1*k24*subs(A4,w,w-(B2-B4))-1*k25*subs(A5,w,w-(B2-B5))-1*k26*subs(A6,w,w-(B2-B6)))/w;
aA3 = (-1*k13*subs(A1,w,w+(B1-B3))-1*k23*subs(A2,w,w+(B2-B3))-1*k34*subs(A4,w,w-(B3-B4))-1*k35*subs(A5,w,w-(B3-B5))-1*k36*subs(A6,w,w-(B3-B6)))/w;
aA4 = (-1*k14*subs(A1,w,w+(B1-B4))-1*k24*subs(A2,w,w+(B2-B4))-1*k34*subs(A3,w,w+(B3-B4))-1*k45*subs(A5,w,w-(B4-B5))-1*k46*subs(A6,w,w-(B4-B6)))/w;
aA5 = (-1*k15*subs(A1,w,w+(B1-B5))-1*k25*subs(A2,w,w+(B2-B5))-1*k35*subs(A3,w,w+(B3-B5))-1*k45*subs(A4,w,w+(B4-B5))-1*k56*subs(A6,w,w-(B5-B6)))/w;
aA6 = (-1*k16*subs(A1,w,w+(B1-B6))-1*k26*subs(A2,w,w+(B2-B6))-1*k36*subs(A3,w,w+(B3-B6))-1*k46*subs(A4,w,w+(B4-B6))-1*k56*subs(A5,w,w+(B5-B6)))/w;

disp('Eliminating...')
%% E5 - E6
%1 - Elimination of E1
a2A2 = (subs(aA2,A1(w+(B1-B2)),subs(aA1,w,w+(B1-B2))));
a2A3 = (subs(aA3,A1(w+(B1-B3)),subs(aA1,w,w+(B1-B3))));
a2A4 = (subs(aA4,A1(w+(B1-B4)),subs(aA1,w,w+(B1-B4))));
a2A5 = (subs(aA5,A1(w+(B1-B5)),subs(aA1,w,w+(B1-B5))));
a2A6 = (subs(aA6,A1(w+(B1-B6)),subs(aA1,w,w+(B1-B6))));

coef_a2A2 = simplify(subs((a2A2-subs(a2A2,A2(w),0)),A2(w),1));
coef_a2A3 = simplify(subs((a2A3-subs(a2A3,A3(w),0)),A3(w),1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,A4(w),0)),A4(w),1));
coef_a2A5 = simplify(subs((a2A5-subs(a2A5,A5(w),0)),A5(w),1));
coef_a2A6 = simplify(subs((a2A6-subs(a2A6,A6(w),0)),A6(w),1));

a2A2 = subs(a2A2,A2(w),0) / (1-coef_a2A2);
a2A3 = subs(a2A3,A3(w),0) / (1-coef_a2A3);
a2A4 = subs(a2A4,A4(w),0) / (1-coef_a2A4);
a2A5 = subs(a2A5,A5(w),0) / (1-coef_a2A5);
a2A6 = subs(a2A6,A6(w),0) / (1-coef_a2A6);

%2 - Elimination of E2
a3A3 = (subs(a2A3,A2(w+(B2-B3)),subs(a2A2,w,w+(B2-B3))));
a3A4 = (subs(a2A4,A2(w+(B2-B4)),subs(a2A2,w,w+(B2-B4))));
a3A5 = (subs(a2A5,A2(w+(B2-B5)),subs(a2A2,w,w+(B2-B5))));
a3A6 = (subs(a2A6,A2(w+(B2-B6)),subs(a2A2,w,w+(B2-B6))));

coef_a3A3 = simplify(subs((a3A3-subs(a3A3,A3(w),0)),A3(w),1));
coef_a3A4 = simplify(subs((a3A4-subs(a3A4,A4(w),0)),A4(w),1));
coef_a3A5 = simplify(subs((a3A5-subs(a3A5,A5(w),0)),A5(w),1));
coef_a3A6 = simplify(subs((a3A6-subs(a3A6,A6(w),0)),A6(w),1));

a3A3 = simplify(subs(a3A3,A3(w),0) / (1-coef_a3A3));
a3A4 = simplify(subs(a3A4,A4(w),0) / (1-coef_a3A4));
a3A5 = simplify(subs(a3A5,A5(w),0) / (1-coef_a3A5));
a3A6 = simplify(subs(a3A6,A6(w),0) / (1-coef_a3A6));

%3 - Elimination of E3
a4A4 = (subs(a3A4,A3(w+(B3-B4)),subs(a3A3,w,w+(B3-B4))));
a4A5 = (subs(a3A5,A3(w+(B3-B5)),subs(a3A3,w,w+(B3-B5))));
a4A6 = (subs(a3A6,A3(w+(B3-B6)),subs(a3A3,w,w+(B3-B6))));

coef_a4A4 = simplify(subs((a4A4-subs(a4A4,A4(w),0)),A4(w),1));
coef_a4A5 = simplify(subs((a4A5-subs(a4A5,A5(w),0)),A5(w),1));
coef_a4A6 = simplify(subs((a4A6-subs(a4A6,A6(w),0)),A6(w),1));

a4A4 = simplify(subs(a4A4,A4(w),0) / (1-coef_a4A4));
a4A5 = simplify(subs(a4A5,A5(w),0) / (1-coef_a4A5));
a4A6 = simplify(subs(a4A6,A6(w),0) / (1-coef_a4A6));

%4 - Elimination of E4
a5A5 = (subs(collect(a4A5,A4(w+(B4-B5))),A4(w+(B4-B5)),subs(a4A4,w,w+(B4-B5))));
a5A6 = (subs(collect(a4A6,A4(w+(B4-B6))),A4(w+(B4-B6)),subs(a4A4,w,w+(B4-B6))));

coef_a5A5 = simplify(subs((a5A5-subs(a5A5,A5(w),0)),A5(w),1));
coef_a5A6 = simplify(subs((a5A6-subs(a5A6,A6(w),0)),A6(w),1));

a5A5 = simplify(subs(collect(a5A5,A5(w)),A5(w),0) / (1-coef_a5A5));
a5A6 = simplify(subs(collect(a5A6,A6(w)),A6(w),0) / (1-coef_a5A6));

%5
a6A5 = (subs(collect(a5A5,A6(w-(B5-B6))),A6(w-(B5-B6)),subs(a5A6,w,w-(B5-B6))));
a6A6 = (subs(collect(a5A6,A5(w+(B5-B6))),A5(w+(B5-B6)),subs(a5A5,w,w+(B5-B6))));

%end
[a,b] = numden(simplify(subs(a6A5,A5(w),1)));
[c,d] = numden(simplify(subs(a6A6,A6(w),1)));

eq5 = b - a;
eq6 = d - c;

[XC5,T5] = coeffs(b-a,w);
[XC6,T6] = coeffs(d-c,w);

disp('E5 and E6 calculated')
%% E1 - E2
%1 - Elimination of E3
a2A1 = (subs(aA1,A3(w-(B1-B3)),subs(aA3,w,w-(B1-B3))));
a2A2 = (subs(aA2,A3(w-(B2-B3)),subs(aA3,w,w-(B2-B3))));
a2A4 = (subs(aA4,A3(w+(B3-B4)),subs(aA3,w,w+(B3-B4))));
a2A5 = (subs(aA5,A3(w+(B3-B5)),subs(aA3,w,w+(B3-B5))));
a2A6 = (subs(aA6,A3(w+(B3-B6)),subs(aA3,w,w+(B3-B6))));

coef_a2A1 = simplify(subs((a2A1-subs(a2A1,A1(w),0)),A1(w),1));
coef_a2A2 = simplify(subs((a2A2-subs(a2A2,A2(w),0)),A2(w),1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,A4(w),0)),A4(w),1));
coef_a2A5 = simplify(subs((a2A5-subs(a2A5,A5(w),0)),A5(w),1));
coef_a2A6 = simplify(subs((a2A6-subs(a2A6,A6(w),0)),A6(w),1));

a2A1 = subs(a2A1,A1(w),0) / (1-coef_a2A1);
a2A2 = subs(a2A2,A2(w),0) / (1-coef_a2A2);
a2A4 = subs(a2A4,A4(w),0) / (1-coef_a2A4);
a2A5 = subs(a2A5,A5(w),0) / (1-coef_a2A5);
a2A6 = subs(a2A6,A6(w),0) / (1-coef_a2A6);

%2 - Elimination of E4
a3A1 = (subs(a2A1,A4(w-(B1-B4)),subs(a2A4,w,w-(B1-B4))));
a3A2 = (subs(a2A2,A4(w-(B2-B4)),subs(a2A4,w,w-(B2-B4))));
a3A5 = (subs(a2A5,A4(w+(B4-B5)),subs(a2A4,w,w+(B4-B5))));
a3A6 = (subs(a2A6,A4(w+(B4-B6)),subs(a2A4,w,w+(B4-B6))));

coef_a3A1 = simplify(subs((a3A1-subs(a3A1,A1(w),0)),A1(w),1));
coef_a3A2 = simplify(subs((a3A2-subs(a3A2,A2(w),0)),A2(w),1));
coef_a3A5 = simplify(subs((a3A5-subs(a3A5,A5(w),0)),A5(w),1));
coef_a3A6 = simplify(subs((a3A6-subs(a3A6,A6(w),0)),A6(w),1));

a3A1 = simplify(subs(a3A1,A1(w),0) / (1-coef_a3A1));
a3A2 = simplify(subs(a3A2,A2(w),0) / (1-coef_a3A2));
a3A5 = simplify(subs(a3A5,A5(w),0) / (1-coef_a3A5));
a3A6 = simplify(subs(a3A6,A6(w),0) / (1-coef_a3A6));

%3 - Elimination of E5
a4A1 = (subs(a3A1,A5(w-(B1-B5)),subs(a3A5,w,w-(B1-B5))));
a4A2 = (subs(a3A2,A5(w-(B2-B5)),subs(a3A5,w,w-(B2-B5))));
a4A6 = (subs(a3A6,A5(w+(B5-B6)),subs(a3A5,w,w+(B5-B6))));

coef_a4A1 = simplify(subs((a4A1-subs(a4A1,A1(w),0)),A1(w),1));
coef_a4A2 = simplify(subs((a4A2-subs(a4A2,A2(w),0)),A2(w),1));
coef_a4A6 = simplify(subs((a4A6-subs(a4A6,A6(w),0)),A6(w),1));

a4A1 = simplify(subs(a4A1,A1(w),0) / (1-coef_a4A1));
a4A2 = simplify(subs(a4A2,A2(w),0) / (1-coef_a4A2));
a4A6 = simplify(subs(a4A6,A6(w),0) / (1-coef_a4A6));

%4 - Elimination of E6
a5A1 = (subs(collect(a4A1,A6(w-(B1-B6))),A6(w-(B1-B6)),subs(a4A6,w,w-(B1-B6))));
a5A2 = (subs(collect(a4A2,A6(w-(B2-B6))),A6(w-(B2-B6)),subs(a4A6,w,w-(B2-B6))));

coef_a5A1 = simplify(subs((a5A1-subs(a5A1,A1(w),0)),A1(w),1));
coef_a5A2 = simplify(subs((a5A2-subs(a5A2,A2(w),0)),A2(w),1));

a5A1 = simplify(subs(a5A1,A1(w),0) / (1-coef_a5A1));
a5A2 = simplify(subs(a5A2,A2(w),0) / (1-coef_a5A2));

%5
a6A1 = (subs(collect(a5A1,A2(w-(B1-B2))),A2(w-(B1-B2)),subs(a5A2,w,w-(B1-B2))));
a6A2 = (subs(collect(a5A2,A1(w+(B1-B2))),A1(w+(B1-B2)),subs(a5A1,w,w+(B1-B2))));

%end
[a,b] = numden(simplify(subs(a6A1,A1(w),1)));
[c,d] = numden(simplify(subs(a6A2,A2(w),1)));

eq1 = b - a;
eq2 = d - c;

[XC1,T1] = coeffs(b-a,w);
[XC2,T2] = coeffs(d-c,w);

disp('E1 and E2 calculated')
%% E3 - E4
%1 - Elimination of E1
a2A2 = (subs(aA2,A1(w+(B1-B2)),subs(aA1,w,w+(B1-B2))));
a2A3 = (subs(aA3,A1(w+(B1-B3)),subs(aA1,w,w+(B1-B3))));
a2A4 = (subs(aA4,A1(w+(B1-B4)),subs(aA1,w,w+(B1-B4))));
a2A5 = (subs(aA5,A1(w+(B1-B5)),subs(aA1,w,w+(B1-B5))));
a2A6 = (subs(aA6,A1(w+(B1-B6)),subs(aA1,w,w+(B1-B6))));

coef_a2A2 = simplify(subs((a2A2-subs(a2A2,A2(w),0)),A2(w),1));
coef_a2A3 = simplify(subs((a2A3-subs(a2A3,A3(w),0)),A3(w),1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,A4(w),0)),A4(w),1));
coef_a2A5 = simplify(subs((a2A5-subs(a2A5,A5(w),0)),A5(w),1));
coef_a2A6 = simplify(subs((a2A6-subs(a2A6,A6(w),0)),A6(w),1));

a2A2 = subs(a2A2,A2(w),0) / (1-coef_a2A2);
a2A3 = subs(a2A3,A3(w),0) / (1-coef_a2A3);
a2A4 = subs(a2A4,A4(w),0) / (1-coef_a2A4);
a2A5 = subs(a2A5,A5(w),0) / (1-coef_a2A5);
a2A6 = subs(a2A6,A6(w),0) / (1-coef_a2A6);

%2 - Elimination of E2
a3A3 = (subs(a2A3,A2(w+(B2-B3)),subs(a2A2,w,w+(B2-B3))));
a3A4 = (subs(a2A4,A2(w+(B2-B4)),subs(a2A2,w,w+(B2-B4))));
a3A5 = (subs(a2A5,A2(w+(B2-B5)),subs(a2A2,w,w+(B2-B5))));
a3A6 = (subs(a2A6,A2(w+(B2-B6)),subs(a2A2,w,w+(B2-B6))));

coef_a3A3 = simplify(subs((a3A3-subs(a3A3,A3(w),0)),A3(w),1));
coef_a3A4 = simplify(subs((a3A4-subs(a3A4,A4(w),0)),A4(w),1));
coef_a3A5 = simplify(subs((a3A5-subs(a3A5,A5(w),0)),A5(w),1));
coef_a3A6 = simplify(subs((a3A6-subs(a3A6,A6(w),0)),A6(w),1));

a3A3 = simplify(subs(a3A3,A3(w),0) / (1-coef_a3A3));
a3A4 = simplify(subs(a3A4,A4(w),0) / (1-coef_a3A4));
a3A5 = simplify(subs(a3A5,A5(w),0) / (1-coef_a3A5));
a3A6 = simplify(subs(a3A6,A6(w),0) / (1-coef_a3A6));

%3 - Elimination of E5
a4A3 = (subs(a3A3,A5(w-(B3-B5)),subs(a3A5,w,w-(B3-B5))));
a4A4 = (subs(a3A4,A5(w-(B4-B5)),subs(a3A5,w,w-(B4-B5))));
a4A6 = (subs(a3A6,A5(w+(B5-B6)),subs(a3A5,w,w+(B5-B6))));

coef_a4A3 = simplify(subs((a4A3-subs(a4A3,A3(w),0)),A3(w),1));
coef_a4A4 = simplify(subs((a4A4-subs(a4A4,A4(w),0)),A4(w),1));
coef_a4A6 = simplify(subs((a4A6-subs(a4A6,A6(w),0)),A6(w),1));

a4A3 = simplify(subs(a4A3,A3(w),0) / (1-coef_a4A3));
a4A4 = simplify(subs(a4A4,A4(w),0) / (1-coef_a4A4));
a4A6 = simplify(subs(a4A6,A6(w),0) / (1-coef_a4A6));

%4 - Elimination of E6
a5A3 = (subs(collect(a4A3,A6(w-(B3-B6))),A6(w-(B3-B6)),subs(a4A6,w,w-(B3-B6))));
a5A4 = (subs(collect(a4A4,A6(w-(B4-B6))),A6(w-(B4-B6)),subs(a4A6,w,w-(B4-B6))));

coef_a5A3 = simplify(subs((a5A3-subs(a5A3,A3(w),0)),A3(w),1));
coef_a5A4 = simplify(subs((a5A4-subs(a5A4,A4(w),0)),A4(w),1));

a5A3 = simplify(subs(a5A3,A3(w),0) / (1-coef_a5A3));
a5A4 = simplify(subs(a5A4,A4(w),0) / (1-coef_a5A4));

%5
a6A3 = (subs(collect(a5A3,A4(w-(B3-B4))),A4(w-(B3-B4)),subs(a5A4,w,w-(B3-B4))));
a6A4 = (subs(collect(a5A4,A3(w+(B3-B4))),A3(w+(B3-B4)),subs(a5A3,w,w+(B3-B4))));

%end
[a,b] = numden(simplify(subs(a6A3,A3(w),1)));
[c,d] = numden(simplify(subs(a6A4,A4(w),1)));

eq3 = b - a;
eq4 = d - c;

[XC3,T3] = coeffs(b-a,w);
[XC4,T4] = coeffs(d-c,w);
%     eq3 = (1-subs(a6A3,A3(w),1));
%     eq4 = (1-subs(a6A4,A4(w),1));
disp('E3 and E4 calculated')
% save eqs

%% E1 - E6
%1 - Elimination of E3
a2A1 = (subs(aA1,A3(w-(B1-B3)),subs(aA3,w,w-(B1-B3))));
a2A2 = (subs(aA2,A3(w-(B2-B3)),subs(aA3,w,w-(B2-B3))));
a2A4 = (subs(aA4,A3(w+(B3-B4)),subs(aA3,w,w+(B3-B4))));
a2A5 = (subs(aA5,A3(w+(B3-B5)),subs(aA3,w,w+(B3-B5))));
a2A6 = (subs(aA6,A3(w+(B3-B6)),subs(aA3,w,w+(B3-B6))));

coef_a2A1 = simplify(subs((a2A1-subs(a2A1,A1(w),0)),A1(w),1));
coef_a2A2 = simplify(subs((a2A2-subs(a2A2,A2(w),0)),A2(w),1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,A4(w),0)),A4(w),1));
coef_a2A5 = simplify(subs((a2A5-subs(a2A5,A5(w),0)),A5(w),1));
coef_a2A6 = simplify(subs((a2A6-subs(a2A6,A6(w),0)),A6(w),1));

a2A1 = subs(a2A1,A1(w),0) / (1-coef_a2A1);
a2A2 = subs(a2A2,A2(w),0) / (1-coef_a2A2);
a2A4 = subs(a2A4,A4(w),0) / (1-coef_a2A4);
a2A5 = subs(a2A5,A5(w),0) / (1-coef_a2A5);
a2A6 = subs(a2A6,A6(w),0) / (1-coef_a2A6);

%2 - Elimination of E4
a3A1 = (subs(a2A1,A4(w-(B1-B4)),subs(a2A4,w,w-(B1-B4))));
a3A2 = (subs(a2A2,A4(w-(B2-B4)),subs(a2A4,w,w-(B2-B4))));
a3A5 = (subs(a2A5,A4(w+(B4-B5)),subs(a2A4,w,w+(B4-B5))));
a3A6 = (subs(a2A6,A4(w+(B4-B6)),subs(a2A4,w,w+(B4-B6))));

coef_a3A1 = simplify(subs((a3A1-subs(a3A1,A1(w),0)),A1(w),1));
coef_a3A2 = simplify(subs((a3A2-subs(a3A2,A2(w),0)),A2(w),1));
coef_a3A5 = simplify(subs((a3A5-subs(a3A5,A5(w),0)),A5(w),1));
coef_a3A6 = simplify(subs((a3A6-subs(a3A6,A6(w),0)),A6(w),1));

a3A1 = simplify(subs(a3A1,A1(w),0) / (1-coef_a3A1));
a3A2 = simplify(subs(a3A2,A2(w),0) / (1-coef_a3A2));
a3A5 = simplify(subs(a3A5,A5(w),0) / (1-coef_a3A5));
a3A6 = simplify(subs(a3A6,A6(w),0) / (1-coef_a3A6));

%3 - Elimination of E2
a4A1 = (subs(a3A1,A2(w-(B1-B2)),subs(a3A2,w,w-(B1-B2))));
a4A5 = (subs(a3A5,A2(w+(B2-B5)),subs(a3A2,w,w+(B2-B5))));
a4A6 = (subs(a3A6,A2(w+(B2-B6)),subs(a3A2,w,w+(B2-B6))));

coef_a4A1 = simplify(subs((a4A1-subs(a4A1,A1(w),0)),A1(w),1));
coef_a4A5 = simplify(subs((a4A5-subs(a4A5,A5(w),0)),A5(w),1));
coef_a4A6 = simplify(subs((a4A6-subs(a4A6,A6(w),0)),A6(w),1));

a4A1 = simplify(subs(a4A1,A1(w),0) / (1-coef_a4A1));
a4A5 = simplify(subs(a4A5,A5(w),0) / (1-coef_a4A5));
a4A6 = simplify(subs(a4A6,A6(w),0) / (1-coef_a4A6));

%4 - Elimination of E5
a5A1 = (subs(collect(a4A1,A5(w-(B1-B5))),A5(w-(B1-B5)),subs(a4A5,w,w-(B1-B5))));
a5A6 = (subs(collect(a4A6,A5(w+(B5-B6))),A5(w+(B5-B6)),subs(a4A5,w,w+(B5-B6))));

coef_a5A1 = simplify(subs((a5A1-subs(a5A1,A1(w),0)),A1(w),1));
coef_a5A6 = simplify(subs((a5A6-subs(a5A6,A6(w),0)),A6(w),1));

a5A1 = simplify(subs(a5A1,A1(w),0) / (1-coef_a5A1));
a5A6 = simplify(subs(a5A6,A6(w),0) / (1-coef_a5A6));

%5
a6A1 = (subs(collect(a5A1,A6(w-(B1-B6))),A6(w-(B1-B6)),subs(a5A6,w,w-(B1-B6))));
a6A6 = (subs(collect(a5A6,A1(w+(B1-B6))),A1(w+(B1-B6)),subs(a5A1,w,w+(B1-B6))));

%end
[a,b] = numden(simplify(subs(a6A1,A1(w),1)));
[c,d] = numden(simplify(subs(a6A6,A6(w),1)));

auxeq1 = b - a;
auxeq6 = d - c;

[XauxC1,auxT1] = coeffs(b-a,w);
[XauxC6,auxT6] = coeffs(d-c,w);

disp('E1 and E6 calculated - auxiliary')

%% E2 - E5
%1 - Elimination of E3
a2A1 = (subs(aA1,A3(w-(B1-B3)),subs(aA3,w,w-(B1-B3))));
a2A2 = (subs(aA2,A3(w-(B2-B3)),subs(aA3,w,w-(B2-B3))));
a2A4 = (subs(aA4,A3(w+(B3-B4)),subs(aA3,w,w+(B3-B4))));
a2A5 = (subs(aA5,A3(w+(B3-B5)),subs(aA3,w,w+(B3-B5))));
a2A6 = (subs(aA6,A3(w+(B3-B6)),subs(aA3,w,w+(B3-B6))));

coef_a2A1 = simplify(subs((a2A1-subs(a2A1,A1(w),0)),A1(w),1));
coef_a2A2 = simplify(subs((a2A2-subs(a2A2,A2(w),0)),A2(w),1));
coef_a2A4 = simplify(subs((a2A4-subs(a2A4,A4(w),0)),A4(w),1));
coef_a2A5 = simplify(subs((a2A5-subs(a2A5,A5(w),0)),A5(w),1));
coef_a2A6 = simplify(subs((a2A6-subs(a2A6,A6(w),0)),A6(w),1));

a2A1 = subs(a2A1,A1(w),0) / (1-coef_a2A1);
a2A2 = subs(a2A2,A2(w),0) / (1-coef_a2A2);
a2A4 = subs(a2A4,A4(w),0) / (1-coef_a2A4);
a2A5 = subs(a2A5,A5(w),0) / (1-coef_a2A5);
a2A6 = subs(a2A6,A6(w),0) / (1-coef_a2A6);

%2 - Elimination of E4
a3A1 = (subs(a2A1,A4(w-(B1-B4)),subs(a2A4,w,w-(B1-B4))));
a3A2 = (subs(a2A2,A4(w-(B2-B4)),subs(a2A4,w,w-(B2-B4))));
a3A5 = (subs(a2A5,A4(w+(B4-B5)),subs(a2A4,w,w+(B4-B5))));
a3A6 = (subs(a2A6,A4(w+(B4-B6)),subs(a2A4,w,w+(B4-B6))));

coef_a3A1 = simplify(subs((a3A1-subs(a3A1,A1(w),0)),A1(w),1));
coef_a3A2 = simplify(subs((a3A2-subs(a3A2,A2(w),0)),A2(w),1));
coef_a3A5 = simplify(subs((a3A5-subs(a3A5,A5(w),0)),A5(w),1));
coef_a3A6 = simplify(subs((a3A6-subs(a3A6,A6(w),0)),A6(w),1));

a3A1 = simplify(subs(a3A1,A1(w),0) / (1-coef_a3A1));
a3A2 = simplify(subs(a3A2,A2(w),0) / (1-coef_a3A2));
a3A5 = simplify(subs(a3A5,A5(w),0) / (1-coef_a3A5));
a3A6 = simplify(subs(a3A6,A6(w),0) / (1-coef_a3A6));

%3 - Elimination of E1
a4A2 = (subs(a3A2,A1(w+(B1-B2)),subs(a3A1,w,w+(B1-B2))));
a4A5 = (subs(a3A5,A1(w+(B1-B5)),subs(a3A1,w,w+(B1-B5))));
a4A6 = (subs(a3A6,A1(w+(B1-B6)),subs(a3A1,w,w+(B1-B6))));

coef_a4A2 = simplify(subs((a4A2-subs(a4A2,A2(w),0)),A2(w),1));
coef_a4A5 = simplify(subs((a4A5-subs(a4A5,A5(w),0)),A5(w),1));
coef_a4A6 = simplify(subs((a4A6-subs(a4A6,A6(w),0)),A6(w),1));

a4A2 = simplify(subs(a4A2,A2(w),0) / (1-coef_a4A2));
a4A5 = simplify(subs(a4A5,A5(w),0) / (1-coef_a4A5));
a4A6 = simplify(subs(a4A6,A6(w),0) / (1-coef_a4A6));

%4 - Elimination of E6
a5A2 = (subs(collect(a4A2,A6(w-(B2-B6))),A6(w-(B2-B6)),subs(a4A6,w,w-(B2-B6))));
a5A5 = (subs(collect(a4A5,A6(w-(B5-B6))),A6(w-(B5-B6)),subs(a4A6,w,w-(B5-B6))));

coef_a5A2 = simplify(subs((a5A2-subs(a5A2,A2(w),0)),A2(w),1));
coef_a5A5 = simplify(subs((a5A5-subs(a5A5,A5(w),0)),A5(w),1));

a5A2 = simplify(subs(a5A2,A2(w),0) / (1-coef_a5A2));
a5A5 = simplify(subs(a5A5,A5(w),0) / (1-coef_a5A5));

%5
a6A2 = (subs(collect(a5A2,A5(w-(B2-B5))),A5(w-(B2-B5)),subs(a5A5,w,w-(B2-B5))));
a6A5 = (subs(collect(a5A5,A2(w+(B2-B5))),A2(w+(B2-B5)),subs(a5A2,w,w+(B2-B5))));

%end
[a,b] = numden(simplify(subs(a6A2,A2(w),1)));
[c,d] = numden(simplify(subs(a6A5,A5(w),1)));

auxeq2 = b - a;
auxeq5 = d - c;

[XauxC2,auxT2] = coeffs(b-a,w);
[XauxC5,auxT5] = coeffs(d-c,w);

disp('E2 and E5 calculated - auxiliary')

C1 = XauxC1;
C2 = XauxC2;
C3 = XC3;
C4 = XC4;
C5 = XauxC5;
C6 = XauxC6;

%% Charateristic Polinomial Simplification
disp('Charateristic Polinomial Simplification...')
syms dB12 dB13 dB14 dB15 dB16 dB23 dB24 dB25 dB26 dB34 dB35 dB36 dB45 dB46 dB56
C(1).c = C1;
C(2).c = C2;
C(3).c = C3;
C(4).c = C4;
C(5).c = C5;
C(6).c = C6;
for ll = 1:6
    C(ll).c = subs(C(ll).c,B1,dB12+B2);
    C(ll).c = subs(C(ll).c,B2,-dB12+B1);
    
    C(ll).c = subs(C(ll).c,B1,dB13+B3);
    C(ll).c = subs(C(ll).c,B3,-dB13+B1);
    
    C(ll).c = subs(C(ll).c,B1,dB14+B4);
    C(ll).c = subs(C(ll).c,B4,-dB14+B1);
    
    C(ll).c = subs(C(ll).c,B1,dB15+B5);
    C(ll).c = subs(C(ll).c,B5,-dB15+B1);
    
    C(ll).c = subs(C(ll).c,B1,dB16+B6);
    C(ll).c = subs(C(ll).c,B6,-dB16+B1);
    
    C(ll).c = subs(C(ll).c,B2,dB23+B3);
    C(ll).c = subs(C(ll).c,B3,-dB23+B2);
    
    C(ll).c = subs(C(ll).c,B2,dB24+B4);
    C(ll).c = subs(C(ll).c,B4,-dB24+B2);
    
    C(ll).c = subs(C(ll).c,B2,dB25+B5);
    C(ll).c = subs(C(ll).c,B5,-dB25+B2);
    
    C(ll).c = subs(C(ll).c,B2,dB26+B6);
    C(ll).c = subs(C(ll).c,B6,-dB26+B2);
    
    C(ll).c = subs(C(ll).c,B3,dB34+B4);
    C(ll).c = subs(C(ll).c,B4,-dB34+B3);
    
    C(ll).c = subs(C(ll).c,B3,dB35+B5);
    C(ll).c = subs(C(ll).c,B5,-dB35+B3);
    
    C(ll).c = subs(C(ll).c,B3,dB36+B6);
    C(ll).c = subs(C(ll).c,B6,-dB36+B3);
    
    C(ll).c = subs(C(ll).c,B4,dB45+B5);
    C(ll).c = subs(C(ll).c,B5,-dB45+B4);
    
    C(ll).c = subs(C(ll).c,B4,dB46+B6);
    C(ll).c = subs(C(ll).c,B6,-dB46+B4);
    
    C(ll).c = subs(C(ll).c,B5,dB56+B6);
    C(ll).c = subs(C(ll).c,B6,-dB56+B5);
    
    C(ll).c = subs(C(ll).c,B1,0);
    C(ll).c = subs(C(ll).c,B2,0);
    C(ll).c = subs(C(ll).c,B3,0);
    C(ll).c = subs(C(ll).c,B4,0);
    C(ll).c = subs(C(ll).c,B5,0);
    C(ll).c = subs(C(ll).c,B6,0);
    
    % C(ll).c = simplify(C(ll).c);
end
C1 = C(1).c;
C2 = C(2).c;
C3 = C(3).c;
C4 = C(4).c;
C5 = C(5).c;
C6 = C(6).c;

clear B1 B2 B3 B4 B5 B6

Ivector = [1i^-10 1i^-9 1i^-8 1i^-7 1i^-6 1i^-5 1i^-4 1i^-3 1i^-2 1i^-1 1i^0];
C1 = C1.*Ivector;
C2 = C2.*Ivector;
C3 = C3.*Ivector;
C4 = C4.*Ivector;
C5 = C5.*Ivector;
C6 = C6.*Ivector;

syms X real
CC1 = C1*[X^10 X^9 X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC2 = C2*[X^10 X^9 X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC3 = C3*[X^10 X^9 X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC4 = C4*[X^10 X^9 X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC5 = C5*[X^10 X^9 X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';
CC6 = C6*[X^10 X^9 X^8 X^7 X^6 X^5 X^4 X^3 X^2 X^1 X^0].';


%% Boundary conditions
disp('Initial value condition...')
syms  z

clear A1 A2 A3 A4 A5 A6
syms A1(w) A2(w) A3(w) A4(w) A5(w) A6(w)

dA1 = -1i*k12*A2*exp( 1i*(dB12)*z)-1i*k13*A3*exp( 1i*(dB13)*z)-1i*k14*A4*exp( 1i*(dB14)*z)-1i*k15*A5*exp( 1i*(dB15)*z)-1i*k16*A6*exp( 1i*(dB16)*z);
dA2 = -1i*k12*A1*exp(-1i*(dB12)*z)-1i*k23*A3*exp( 1i*(dB23)*z)-1i*k24*A4*exp( 1i*(dB24)*z)-1i*k25*A5*exp( 1i*(dB25)*z)-1i*k26*A6*exp( 1i*(dB26)*z);
dA3 = -1i*k13*A1*exp(-1i*(dB13)*z)-1i*k23*A2*exp(-1i*(dB23)*z)-1i*k34*A4*exp( 1i*(dB34)*z)-1i*k35*A5*exp( 1i*(dB35)*z)-1i*k36*A6*exp( 1i*(dB36)*z);
dA4 = -1i*k14*A1*exp(-1i*(dB14)*z)-1i*k24*A2*exp(-1i*(dB24)*z)-1i*k34*A3*exp(-1i*(dB34)*z)-1i*k45*A5*exp( 1i*(dB45)*z)-1i*k46*A6*exp( 1i*(dB46)*z);
dA5 = -1i*k15*A1*exp(-1i*(dB15)*z)-1i*k25*A2*exp(-1i*(dB25)*z)-1i*k35*A3*exp(-1i*(dB35)*z)-1i*k45*A4*exp(-1i*(dB45)*z)-1i*k56*A6*exp( 1i*(dB56)*z);
dA6 = -1i*k16*A1*exp(-1i*(dB16)*z)-1i*k26*A2*exp(-1i*(dB26)*z)-1i*k36*A3*exp(-1i*(dB36)*z)-1i*k46*A4*exp(-1i*(dB46)*z)-1i*k56*A5*exp(-1i*(dB56)*z);

dA(1,1) = dA1;
dA(1,2) = dA2;
dA(1,3) = dA3;
dA(1,4) = dA4;
dA(1,5) = dA5;
dA(1,6) = dA6;

disp('Differentiating...')
for ll = 1:8
    dA(ll+1,1) = diff(dA(ll,1),z);
    dA(ll+1,2) = diff(dA(ll,2),z);
    dA(ll+1,3) = diff(dA(ll,3),z);
    dA(ll+1,4) = diff(dA(ll,4),z);
    dA(ll+1,5) = diff(dA(ll,5),z);
    dA(ll+1,6) = diff(dA(ll,6),z);
end

for ll = 1:9
    for nn = 1:6
        try
            dA(ll,nn) = subs(dA(ll,nn),{'z'},{0}); 
        catch
            disp('runs better in matlab R2010 64-bit')
        end
    end
end

for ll = 1:9
    XdA(ll,1) = dA(ll,1);
    XdA(ll,2) = dA(ll,2);
    XdA(ll,3) = dA(ll,3);
    XdA(ll,4) = dA(ll,4);
    XdA(ll,5) = dA(ll,5);
    XdA(ll,6) = dA(ll,6);
    
    WdA(ll,1) = dA(ll,1);
    WdA(ll,2) = dA(ll,2);
    WdA(ll,3) = dA(ll,3);
    WdA(ll,4) = dA(ll,4);
    WdA(ll,5) = dA(ll,5);
    WdA(ll,6) = dA(ll,6);
end

for ll = 1:5
    for nn = 1:6
        for dd = 1:9
            disp(['z - ',num2str(ll),' # ',num2str(nn),' # ',num2str(dd)])
            if dd < ll
                try
                    WdA(ll,nn) = subs(WdA(ll,nn),subs(diff(A1,z,dd),z,0),WdA(dd,1));
                    WdA(ll,nn) = subs(WdA(ll,nn),subs(diff(A2,z,dd),z,0),WdA(dd,2));
                    WdA(ll,nn) = subs(WdA(ll,nn),subs(diff(A3,z,dd),z,0),WdA(dd,3));
                    WdA(ll,nn) = subs(WdA(ll,nn),subs(diff(A4,z,dd),z,0),WdA(dd,4));
                    WdA(ll,nn) = subs(WdA(ll,nn),subs(diff(A5,z,dd),z,0),WdA(dd,5));
                    WdA(ll,nn) = subs(WdA(ll,nn),subs(diff(A6,z,dd),z,0),WdA(dd,6));
                catch
                    disp('runs better in matlab R2010 64-bit')
                end
                WdA(ll,nn) = simplify(WdA(ll,nn));
            end
        end
    end
end


fid = fopen(['semiAnalyticalSolutions6modes','.txt'], 'w');

%% C's
for zz = 1:6

    fprintf(fid, ['C',num2str(zz),' = [']);

    for kk = 1:11
        str = char(evalin('base',['C',num2str(zz),'(',num2str(kk),')']));
        disp(['C',num2str(zz),'(',num2str(kk),')'])

        str = strrep(str, 'A1(0)', 'A1');
        str = strrep(str, 'A2(0)', 'A2');
        str = strrep(str, 'A3(0)', 'A3');
        str = strrep(str, 'A4(0)', 'A4');
        str = strrep(str, 'A5(0)', 'A5');
        str = strrep(str, 'A6(0)', 'A6');

        str = strrep(str, 'i', '1i');
        str = strrep(str, 'I', '1i');

        len = length(str);

        parts = floor(len/80);

        if parts == 0
            fprintf(fid, [str '\n\n']);
%             disp([str])
%             disp([' '])
            continue;
        end
        
        idxl = 1;
        idxr = 80;
        while idxr <= len
            if idxr == len
                fprintf(fid, [str(idxl:idxr)]);
%                 disp(str(idxl:idxr))
%                 disp([' '])
            	break;
            end
            
            L = idxl - 1 + strfind(str(idxl:idxr),'+');
            R = idxl - 1 + strfind(str(idxl:idxr),'-');
            idxr = max([L,R])-1;
            
            fprintf(fid, [str(idxl:idxr) '...\n']);
%             disp(str(idxl:idxr))
            
            idxl = idxr + 1;
            idxr = idxl + 80;
            
            if idxr > len
                idxr = len;
            end
        end
        if kk ~= 11
            fprintf(fid, ['\n\n']);
        end
    end
    fprintf(fid, ['];\n\n\n']);
end

%% D's
for kk = 1:9
    for zz = 1:6
        fprintf(fid, ['d',num2str(kk),'A',num2str(zz),' = ']);
        
        str = char(evalin('base',['WdA(',num2str(kk),',',num2str(zz),')']));
        disp([['d',num2str(kk),'A',num2str(zz)]])
        
        str = strrep(str, 'diff(A1(0), 0)', 'd1A1');
        str = strrep(str, 'diff(A2(0), 0)', 'd1A2');
        str = strrep(str, 'diff(A3(0), 0)', 'd1A3');
        str = strrep(str, 'diff(A4(0), 0)', 'd1A4');
        str = strrep(str, 'diff(A5(0), 0)', 'd1A5');
        str = strrep(str, 'diff(A6(0), 0)', 'd1A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0)', 'd2A1');
        str = strrep(str, 'diff(A2(0), 0, 0)', 'd2A2');
        str = strrep(str, 'diff(A3(0), 0, 0)', 'd2A3');
        str = strrep(str, 'diff(A4(0), 0, 0)', 'd2A4');
        str = strrep(str, 'diff(A5(0), 0, 0)', 'd2A5');
        str = strrep(str, 'diff(A6(0), 0, 0)', 'd2A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0)', 'd3A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0)', 'd3A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0)', 'd3A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0)', 'd3A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0)', 'd3A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0)', 'd3A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0)', 'd4A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0)', 'd4A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0)', 'd4A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0)', 'd4A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0)', 'd4A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0)', 'd4A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0)', 'd5A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0)', 'd5A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0)', 'd5A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0)', 'd5A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0)', 'd5A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0)', 'd5A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0, 0)', 'd6A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0, 0)', 'd6A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0, 0)', 'd6A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0, 0)', 'd6A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0, 0)', 'd6A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0, 0)', 'd6A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0, 0, 0)', 'd7A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd8A6');
        
        str = strrep(str, 'diff(A1(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A1');
        str = strrep(str, 'diff(A2(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A2');
        str = strrep(str, 'diff(A3(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A3');
        str = strrep(str, 'diff(A4(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A4');
        str = strrep(str, 'diff(A5(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A5');
        str = strrep(str, 'diff(A6(0), 0, 0, 0, 0, 0, 0, 0, 0)', 'd9A6');
        
        str = strrep(str, 'A1(0)', 'A1');
        str = strrep(str, 'A2(0)', 'A2');
        str = strrep(str, 'A3(0)', 'A3');
        str = strrep(str, 'A4(0)', 'A4');
        str = strrep(str, 'A5(0)', 'A5');
        str = strrep(str, 'A6(0)', 'A6');
        
        str = strrep(str, 'i', '1i');
        str = strrep(str, 'I', '1i');
        
        len = length(str);
        
        parts = floor(len/80);
        
        if parts == 0
            fprintf(fid, [str '; \n\n']);
%             disp([str])
%             disp([' '])
            continue;
        end
        
        idxl = 1;
        idxr = 80;
        while idxr <= len
            if idxr == len
                fprintf(fid, [str(idxl:idxr)]);
%                 disp(str(idxl:idxr))
%                 disp([' '])
                break;
            end
            
            L = idxl - 1 + strfind(str(idxl:idxr),'+');
            R = idxl - 1 + strfind(str(idxl:idxr),'-');
            idxr = max([L,R])-1;
            
            fprintf(fid, [str(idxl:idxr) '...\n']);
%             disp(str(idxl:idxr))
            
            idxl = idxr + 1;
            idxr = idxl + 80;
            
            if idxr > len
                idxr = len;
            end
        end
        fprintf(fid, [';\n\n\n']);
    end
end

%% B's
for zz = 1:6
    
    fprintf(fid, ['B',num2str(zz),' = [A',num2str(zz),'\n\n']);
    
    for kk = 1:9
        fprintf(fid, ['d',num2str(kk),'A',num2str(zz),'\n\n']);
    end
    fprintf(fid, ['];\n\n\n']);
end

fclose(fid); 



%         for ll = 1:parts
%             idx=[(ll-1)*80+1:(ll-1)*80+80];
%             fprintf(fid, [str(idx) '...\n']);
%         end
        
%         if kk ~= 6
%             fprintf(fid, [str(idx(end)+1:len) '\n\n']);
%         else
%             fprintf(fid, [str(idx(end)+1:len)]);
%         end
    
   