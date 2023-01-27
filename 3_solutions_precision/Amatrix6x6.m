function dA = Amatrix6x6(z,A,k,deltaB)
% function to be integrated
% dA = zeros(4,1);
% 
% 
% dA(1) = A(2);
% dA(2) = -3*A(1) -exp(z)*A(4) + exp(2*z);
% dA(3) = A(4);
% dA(4) = -A(1) -cos(z)*A(2) + sin(z);


dA = zeros(6,1);

dA(1,1) = -1i*k(1,2) *A(2)*exp( 1i*deltaB(1,2)*z) - 1i*k(1,3) *A(3)*exp( 1i*deltaB(1,3)*z) - 1i*k(1,4) *A(4)*exp( 1i*deltaB(1,4)*z) -1i*k(1,5) *A(5)*exp( 1i*deltaB(1,5)*z) - 1i*k(1,6) *A(6)*exp( 1i*deltaB(1,6)*z);
dA(2,1) = -1i*k(2,1) *A(1)*exp( 1i*deltaB(2,1)*z) - 1i*k(2,3) *A(3)*exp( 1i*deltaB(2,3)*z) - 1i*k(2,4) *A(4)*exp( 1i*deltaB(2,4)*z) -1i*k(2,5) *A(5)*exp( 1i*deltaB(2,5)*z) - 1i*k(2,6) *A(6)*exp( 1i*deltaB(2,6)*z);
dA(3,1) = -1i*k(3,1) *A(1)*exp( 1i*deltaB(3,1)*z) - 1i*k(3,2) *A(2)*exp( 1i*deltaB(3,2)*z) - 1i*k(3,4) *A(4)*exp( 1i*deltaB(3,4)*z) -1i*k(3,5) *A(5)*exp( 1i*deltaB(3,5)*z) - 1i*k(3,6) *A(6)*exp( 1i*deltaB(3,6)*z);
dA(4,1) = -1i*k(4,1) *A(1)*exp( 1i*deltaB(4,1)*z) - 1i*k(4,2) *A(2)*exp( 1i*deltaB(4,2)*z) - 1i*k(4,3) *A(3)*exp( 1i*deltaB(4,3)*z) -1i*k(4,5) *A(5)*exp( 1i*deltaB(4,5)*z) - 1i*k(4,6) *A(6)*exp( 1i*deltaB(4,6)*z);
dA(5,1) = -1i*k(5,1) *A(1)*exp( 1i*deltaB(5,1)*z) - 1i*k(5,2) *A(2)*exp( 1i*deltaB(5,2)*z) - 1i*k(5,3) *A(3)*exp( 1i*deltaB(5,3)*z) -1i*k(5,4) *A(4)*exp( 1i*deltaB(5,4)*z) - 1i*k(5,6) *A(6)*exp( 1i*deltaB(5,6)*z);
dA(6,1) = -1i*k(6,1) *A(1)*exp( 1i*deltaB(6,1)*z) - 1i*k(6,2) *A(2)*exp( 1i*deltaB(6,2)*z) - 1i*k(6,3) *A(3)*exp( 1i*deltaB(6,3)*z) -1i*k(6,4) *A(4)*exp( 1i*deltaB(6,4)*z) - 1i*k(6,5) *A(5)*exp( 1i*deltaB(6,5)*z);


% dA(1,1) = -1i*k(1,1) *A(1)*exp( 1i*deltaB(1,1)*z) - 1i*k(1,2) *A(2)*exp( 1i*deltaB(1,2)*z) - 1i*k(1,3) *A(3)*exp( 1i*deltaB(1,3)*z) - 1i*k(1,4) *A(4)*exp( 1i*deltaB(1,4)*z) -1i*k(1,5) *A(5)*exp( 1i*deltaB(1,5)*z) - 1i*k(1,6) *A(6)*exp( 1i*deltaB(1,6)*z);
% dA(2,1) = -1i*k(2,1) *A(1)*exp( 1i*deltaB(2,1)*z) - 1i*k(2,2) *A(2)*exp( 1i*deltaB(2,2)*z) - 1i*k(2,3) *A(3)*exp( 1i*deltaB(2,3)*z) - 1i*k(2,4) *A(4)*exp( 1i*deltaB(2,4)*z) -1i*k(2,5) *A(5)*exp( 1i*deltaB(2,5)*z) - 1i*k(2,6) *A(6)*exp( 1i*deltaB(2,6)*z);
% dA(3,1) = -1i*k(3,1) *A(1)*exp( 1i*deltaB(3,1)*z) - 1i*k(3,2) *A(2)*exp( 1i*deltaB(3,2)*z) - 1i*k(3,3) *A(3)*exp( 1i*deltaB(3,3)*z) - 1i*k(3,4) *A(4)*exp( 1i*deltaB(3,4)*z) -1i*k(3,5) *A(5)*exp( 1i*deltaB(3,5)*z) - 1i*k(3,6) *A(6)*exp( 1i*deltaB(3,6)*z);
% dA(4,1) = -1i*k(4,1) *A(1)*exp( 1i*deltaB(4,1)*z) - 1i*k(4,2) *A(2)*exp( 1i*deltaB(4,2)*z) - 1i*k(4,3) *A(3)*exp( 1i*deltaB(4,3)*z) - 1i*k(4,4) *A(4)*exp( 1i*deltaB(4,4)*z)  -1i*k(4,5) *A(5)*exp( 1i*deltaB(4,5)*z) - 1i*k(4,6) *A(6)*exp( 1i*deltaB(4,6)*z);
% dA(5,1) = -1i*k(5,1) *A(1)*exp( 1i*deltaB(5,1)*z) - 1i*k(5,2) *A(2)*exp( 1i*deltaB(5,2)*z) - 1i*k(5,3) *A(3)*exp( 1i*deltaB(5,3)*z) -1i*k(5,4) *A(4)*exp( 1i*deltaB(5,4)*z)  - 1i*k(5,5) *A(5)*exp( 1i*deltaB(5,5)*z)  - 1i*k(5,6) *A(6)*exp( 1i*deltaB(5,6)*z);
% dA(6,1) = -1i*k(6,1) *A(1)*exp( 1i*deltaB(6,1)*z) - 1i*k(6,2) *A(2)*exp( 1i*deltaB(6,2)*z) - 1i*k(6,3) *A(3)*exp( 1i*deltaB(6,3)*z) -1i*k(6,4) *A(4)*exp( 1i*deltaB(6,4)*z) - 1i*k(6,5) *A(5)*exp( 1i*deltaB(6,5)*z) - 1i*k(6,6) *A(6)*exp( 1i*deltaB(6,6)*z);

% dA(1,1) = -1i*k(1,2) *A(2)*exp( 1i*deltaB(1,2)*z) - 1i*k(1,3) *A(3)*exp( 1i*deltaB(1,3)*z) - 1i*k(1,4) *A(4)*exp( 1i*deltaB(1,4)*z) -1i*k(1,5) *A(5)*exp( 1i*deltaB(1,5)*z) - 1i*k(1,6) *A(6)*exp( 1i*deltaB(1,6)*z);
% dA(2,1) = -1i*k(2,1) *A(1)*exp( 1i*deltaB(2,1)*z) - 1i*k(2,3) *A(3)*exp( 1i*deltaB(2,3)*z) - 1i*k(2,4) *A(4)*exp( 1i*deltaB(2,4)*z) -1i*k(2,5) *A(5)*exp( 1i*deltaB(2,5)*z) - 1i*k(2,6) *A(6)*exp( 1i*deltaB(2,6)*z);
% dA(3,1) = -1i*k(3,1) *A(1)*exp( 1i*deltaB(3,1)*z) - 1i*k(3,2) *A(2)*exp( 1i*deltaB(3,2)*z) - 1i*k(3,4) *A(4)*exp( 1i*deltaB(3,4)*z) -1i*k(3,5) *A(5)*exp( 1i*deltaB(3,5)*z) - 1i*k(3,6) *A(6)*exp( 1i*deltaB(3,6)*z);
% dA(4,1) = -1i*k(4,1) *A(1)*exp( 1i*deltaB(4,1)*z) - 1i*k(4,2) *A(2)*exp( 1i*deltaB(4,2)*z) - 1i*k(4,3) *A(3)*exp( 1i*deltaB(4,3)*z) -1i*k(4,5) *A(5)*exp( 1i*deltaB(4,5)*z) - 1i*k(4,6) *A(6)*exp( 1i*deltaB(4,6)*z);
% dA(5,1) = -1i*k(5,1) *A(1)*exp( 1i*deltaB(5,1)*z) - 1i*k(5,2) *A(2)*exp( 1i*deltaB(5,2)*z) - 1i*k(5,3) *A(3)*exp( 1i*deltaB(5,3)*z) -1i*k(5,4) *A(4)*exp( 1i*deltaB(5,4)*z) - 1i*k(5,6) *A(6)*exp( 1i*deltaB(5,6)*z);
% dA(6,1) = -1i*k(6,1) *A(1)*exp( 1i*deltaB(6,1)*z) - 1i*k(6,2) *A(2)*exp( 1i*deltaB(6,2)*z) - 1i*k(6,3) *A(3)*exp( 1i*deltaB(6,3)*z) -1i*k(6,4) *A(4)*exp( 1i*deltaB(6,4)*z) - 1i*k(6,5) *A(5)*exp( 1i*deltaB(6,5)*z);


% dB(1,1) = -1i*k(1,2) *A(2)*exp( 1i*deltaB(1,2)*z) - 1i*k(1,3) *A(3)*exp( 1i*deltaB(1,3)*z) - 1i*k(1,4) *A(4)*exp( 1i*deltaB(1,4)*z) -1i*k(1,5) *A(5)*exp( 1i*deltaB(1,5)*z) - 1i*k(1,6) *A(6)*exp( 1i*deltaB(1,6)*z);
% dB(2,1) = -1i*k(2,1) *A(1)*exp(-1i*deltaB(2,1)*z) - 1i*k(2,3) *A(3)*exp( 1i*deltaB(2,3)*z) - 1i*k(2,4) *A(4)*exp( 1i*deltaB(2,4)*z) -1i*k(2,5) *A(5)*exp( 1i*deltaB(2,5)*z) - 1i*k(2,6) *A(6)*exp( 1i*deltaB(2,6)*z);
% dB(3,1) = -1i*k(3,1) *A(1)*exp(-1i*deltaB(3,1)*z) - 1i*k(3,2) *A(2)*exp(-1i*deltaB(2,3)*z) - 1i*k(3,4) *A(4)*exp( 1i*deltaB(3,4)*z) -1i*k(3,5) *A(5)*exp( 1i*deltaB(3,5)*z) - 1i*k(3,6) *A(6)*exp( 1i*deltaB(3,6)*z);
% dB(4,1) = -1i*k(4,1) *A(1)*exp(-1i*deltaB(1,4)*z) - 1i*k(4,2) *A(2)*exp(-1i*deltaB(2,4)*z) - 1i*k(3,4)'*A(3)*exp(-1i*deltaB(3,4)*z) -1i*k(4,5) *A(5)*exp( 1i*deltaB(4,5)*z) - 1i*k(4,6) *A(6)*exp( 1i*deltaB(4,6)*z);
% dB(5,1) = -1i*k(5,1) *A(1)*exp(-1i*deltaB(1,5)*z) - 1i*k(5,2) *A(2)*exp(-1i*deltaB(2,5)*z) - 1i*k(3,5)'*A(3)*exp(-1i*deltaB(3,5)*z) -1i*k(4,5)'*A(4)*exp(-1i*deltaB(4,5)*z) - 1i*k(5,6) *A(6)*exp( 1i*deltaB(5,6)*z);
% dB(6,1) = -1i*k(6,1) *A(1)*exp(-1i*deltaB(1,6)*z) - 1i*k(6,2) *A(2)*exp(-1i*deltaB(2,6)*z) - 1i*k(3,6)'*A(3)*exp(-1i*deltaB(3,6)*z) -1i*k(4,6)'*A(4)*exp(-1i*deltaB(4,6)*z) - 1i*k(5,6)'*A(5)*exp(-1i*deltaB(5,6)*z);
% 
% dA=dB;
% 
% 123
% 
% dA(1) = -1i*k(1,2) *A(2)*exp( 1i*deltaB(1,2)*z);
% dA(2) = -1i*k(1,2)'*A(1)*exp(-1i*deltaB(1,2)*z);