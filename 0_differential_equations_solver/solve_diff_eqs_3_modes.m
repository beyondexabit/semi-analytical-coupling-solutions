clc
clear

%% ODE symbolic math solution
%% Solve coupled differential equation system
syms k12 k13 k23 B1 B2 B3 w

A1 = sym('A1(w)'); A2 = sym('A2(w)'); A3 = sym('A3(w)');

%% E2 E3
%1
aA1 = (-1*k12*subs(A2,w,w-(B1-B2))-1*k13*subs(A3,w,w-(B1-B3)))/w;
aA2 = (-1*k12*subs(A1,w,w+(B1-B2))-1*k23*subs(A3,w,w-(B2-B3)))/w;
aA3 = (-1*k13*subs(A1,w,w+(B1-B3))-1*k23*subs(A2,w,w+(B2-B3)))/w;

%% 1 - Elimination of Eq1 of Eq2 and Eq3
a2A2 = (subs(aA2,'A1(w+(B1-B2))',subs(aA1,w,w+(B1-B2))));
a2A3 = (subs(aA3,'A1(w+(B1-B3))',subs(aA1,w,w+(B1-B3))));

coef_a2A2 = simplify(subs((a2A2-subs(a2A2,'A2(w)',0)),'A2(w)',1));
coef_a2A3 = simplify(subs((a2A3-subs(a2A3,'A3(w)',0)),'A3(w)',1));

a2A2 = subs(a2A2,'A2(w)',0) / (1-coef_a2A2);
a2A3 = subs(a2A3,'A3(w)',0) / (1-coef_a2A3);

%3
a3A2 = subs(a2A2,'A3(w-(B2-B3))',subs(a2A3,w,w-(B2-B3)));
a3A3 = subs(a2A3,'A2(w+(B2-B3))',subs(a2A2,w,w+(B2-B3)));

%end
eq2 = (1-subs(a3A2,'A2(w)',1));
eq3 = (1-subs(a3A3,'A3(w)',1));

%% E1
%% 1 - Elimination of Eq2 of Eq1 and Eq3
a2A1 = (subs(aA1,'A2(w-(B1-B2))',subs(aA2,w,w-(B1-B2))));
a2A3 = (subs(aA3,'A2(w+(B2-B3))',subs(aA2,w,w+(B2-B3))));

coef_a2A1 = subs((a2A1-subs(a2A1,'A1(w)',0)),'A1(w)',1);
coef_a2A3 = subs((a2A3-subs(a2A3,'A3(w)',0)),'A3(w)',1);

a2A1 = subs(a2A1,'A1(w)',0) / (1-coef_a2A1);
a2A3 = subs(a2A3,'A3(w)',0) / (1-coef_a2A3);

%2
a3A1 = subs(a2A1,'A3(w-(B1-B3))',subs(a2A3,w,w-(B1-B3)));

%end
eq1 = (1-subs(a3A1,'A1(w)',1));

%% Charateristic Polinomial Simplification
[N1,D1] = numden(eq1);
[N2,D2] = numden(eq2);
[N3,D3] = numden(eq3);

[C1, T1] = coeffs(N1,w);
[C2, T2] = coeffs(N2,w);
[C3, T3] = coeffs(N3,w);

Ivector = [1i^-4 1i^-3 1i^-2 1i^-1 1i^0];

C1 = C1.*Ivector;
C2 = C2.*Ivector;
C3 = C3.*Ivector;

syms dB12 dB13 dB23
C1 = subs(C1,B1,dB12+B2);
C1 = subs(C1,B2,-dB12+B1);
C1 = subs(C1,B1,dB13+B3);
C1 = subs(C1,B3,-dB13+B1);
C1 = subs(C1,B2,dB23+B3);
C1 = subs(C1,B3,-dB23+B2);
C1 = simplify(C1);

C2 = subs(C2,B1,dB12+B2);
C2 = subs(C2,B2,-dB12+B1);
C2 = subs(C2,B1,dB13+B3);
C2 = subs(C2,B3,-dB13+B1);
C2 = subs(C2,B2,dB23+B3);
C2 = subs(C2,B3,-dB23+B2);
C2 = simplify(C2);

C3 = subs(C3,B1,dB12+B2);
C3 = subs(C3,B2,-dB12+B1);
C3 = subs(C3,B1,dB13+B3);
C3 = subs(C3,B3,-dB13+B1);
C3 = subs(C3,B2,dB23+B3);
C3 = subs(C3,B3,-dB23+B2);
C3 = simplify(C3);
clear B1 B2 B3

syms X
CC1 = C1*[X^4 X^3 X^2 X^1 X^0].';
CC2 = C2*[X^4 X^3 X^2 X^1 X^0].';
CC3 = C3*[X^4 X^3 X^2 X^1 X^0].';

  
%% Boundary conditions
syms  z

clear A1 A2 A3 
A1 = sym('A1(z)'); A2 = sym('A2(z)'); A3 = sym('A3(z)');

dA1 = -1i*k12*A2*exp( 1i*(dB12)*z)-1i*k13*A3*exp( 1i*(dB13)*z);
dA2 = -1i*k12*A1*exp(-1i*(dB12)*z)-1i*k23*A3*exp( 1i*(dB23)*z);
dA3 = -1i*k13*A1*exp(-1i*(dB13)*z)-1i*k23*A2*exp(-1i*(dB23)*z);

%1
d2A1 = diff(dA1,z);
d2A2 = diff(dA2,z);
d2A3 = diff(dA3,z);

d2A1 = (subs(d2A1,diff(A1,z),dA1));
d2A1 = (subs(d2A1,diff(A2,z),dA2));
d2A1 = (subs(d2A1,diff(A3,z),dA3));

d2A2 = (subs(d2A2,diff(A1,z),dA1));
d2A2 = (subs(d2A2,diff(A2,z),dA2));
d2A2 = (subs(d2A2,diff(A3,z),dA3));

d2A3 = (subs(d2A3,diff(A1,z),dA1));
d2A3 = (subs(d2A3,diff(A2,z),dA2));
d2A3 = (subs(d2A3,diff(A3,z),dA3));

%2
d3A1 = diff(d2A1,z);
d3A2 = diff(d2A2,z);
d3A3 = diff(d2A3,z);

d3A1 = (subs(d3A1,diff(A1,z),dA1));
d3A1 = (subs(d3A1,diff(A2,z),dA2));
d3A1 = (subs(d3A1,diff(A3,z),dA3));

d3A2 = (subs(d3A2,diff(A1,z),dA1));
d3A2 = (subs(d3A2,diff(A2,z),dA2));
d3A2 = (subs(d3A2,diff(A3,z),dA3));

d3A3 = (subs(d3A3,diff(A1,z),dA1));
d3A3 = (subs(d3A3,diff(A2,z),dA2));
d3A3 = (subs(d3A3,diff(A3,z),dA3));

BB1 = [subs(A1,'z',0)
       subs(dA1,'z',0)
       subs(d2A1,'z',0)
       subs(d3A1,'z',0)];

BB2 = [subs(A2,'z',0)
       subs(dA2,'z',0)
       subs(d2A2,'z',0)
       subs(d3A2,'z',0)];

BB3 = [subs(A3,'z',0)
       subs(dA3,'z',0)
       subs(d2A3,'z',0)
       subs(d3A3,'z',0)];
   
%% Constants calculation

rt1 = solve(CC1,X);
rt2 = solve(CC2,X);
rt3 = solve(CC3,X);

MM1 = [1         1         1         1
      rt1(1)    rt1(2)    rt1(3)    rt1(4)
      rt1(1)^2  rt1(2)^2  rt1(3)^2  rt1(4)^2
      rt1(1)^3  rt1(2)^3  rt1(3)^3  rt1(4)^3];

MM2 = [1         1         1         1
      rt2(1)    rt2(2)    rt2(3)    rt2(4)
      rt2(1)^2  rt2(2)^2  rt2(3)^2  rt2(4)^2
      rt2(1)^3  rt2(2)^3  rt2(3)^3  rt2(4)^3];

MM3 = [1         1         1         1
      rt3(1)    rt3(2)    rt3(3)    rt3(4)
      rt3(1)^2  rt3(2)^2  rt3(3)^2  rt3(4)^2
      rt3(1)^3  rt3(2)^3  rt3(3)^3  rt3(4)^3];
 
13

fid = fopen('semiAnalyticalSolutions3modes.txt', 'w');

%% C's
for zz = 1:3

    fprintf(fid, ['C',num2str(zz),' = [']);

    for kk = 1:5
        str = char(evalin('base',['C',num2str(zz),'(',num2str(kk),')']));

        str = strrep(str, 'A1(0)', 'A1');
        str = strrep(str, 'A2(0)', 'A2');
        str = strrep(str, 'A3(0)', 'A3');
        str = strrep(str, 'A4(0)', 'A4');

        str = strrep(str, 'i', '1i');

        len = length(str);

        parts = floor(len/80);

        if parts == 0
            fprintf(fid, [str '\n\n']);
            disp([str])
            disp([' '])
            continue;
        end
        
        idxl = 1;
        idxr = 80;
        while idxr <= len
            if idxr == len
                fprintf(fid, [str(idxl:idxr)]);
                disp(str(idxl:idxr))
                disp([' '])
            	break;
            end
            
            L = idxl - 1 + strfind(str(idxl:idxr),'+');
            R = idxl - 1 + strfind(str(idxl:idxr),'-');
            idxr = max([L,R])-1;
            
            fprintf(fid, [str(idxl:idxr) '...\n']);
            disp(str(idxl:idxr))
            
            idxl = idxr + 1;
            idxr = idxl + 80;
            
            if idxr > len
                idxr = len;
            end
        end
        if kk ~= 5
            fprintf(fid, ['\n\n']);
        end
    end
    fprintf(fid, ['];\n\n\n']);
end


%% B's
for zz = 1:3

    fprintf(fid, ['B',num2str(zz),' = [']);

    for kk = 1:4
        str = char(evalin('base',['BB',num2str(zz),'(',num2str(kk),')']));

        str = strrep(str, 'A1(0)', 'A1');
        str = strrep(str, 'A2(0)', 'A2');
        str = strrep(str, 'A3(0)', 'A3');

        str = strrep(str, 'i', '1i');

        len = length(str);

        parts = floor(len/80);

        if parts == 0
            fprintf(fid, [str '\n\n']);
            disp([str])
            disp([' '])
            continue;
        end
        
        idxl = 1;
        idxr = 80;
        while idxr <= len
            if idxr == len
                fprintf(fid, [str(idxl:idxr)]);
                disp(str(idxl:idxr))
                disp([' '])
            	break;
            end
            
            L = idxl - 1 + strfind(str(idxl:idxr),'+');
            R = idxl - 1 + strfind(str(idxl:idxr),'-');
            idxr = max([L,R])-1;
            
            fprintf(fid, [str(idxl:idxr) '...\n']);
            disp(str(idxl:idxr))
            
            idxl = idxr + 1;
            idxr = idxl + 80;
            
            if idxr > len
                idxr = len;
            end
        end
        if kk ~= 4
            fprintf(fid, ['\n\n']);
        end
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
    
    