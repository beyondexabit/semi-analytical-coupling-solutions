// mex -c bairstow1_cpp.cpp -lmpfr
// mex -c bubbleSort.cpp -lmpfr
// mex -c Gsolve.cpp -lmpfr
// mex -c gelimd2_cpp.cpp -lmpfr
// mex -c polyroots_cpp.cpp -lmpfr
// mex -c poly_division_cpp.cpp -lmpfr
// mex -c polyroots_alternative_cpp.cpp -lmpfr
// mex -c equations6x6_C1_cpp.cpp -lmpfr
// mex -c equations6x6_C2_cpp.cpp -lmpfr
// mex -c equations6x6_C3_cpp.cpp -lmpfr
// mex -c equations6x6_C4_cpp.cpp -lmpfr
// mex -c equations6x6_C5_cpp.cpp -lmpfr
// mex -c equations6x6_C6_cpp.cpp -lmpfr
// mex -c equations6x6_B_cpp.cpp  -lmpfr
// mex equations6x6_doubleIOrand_cpp.cpp gelimd2_cpp.obj polyroots_alternative_cpp.obj polyroots_cpp.obj bairstow1_cpp.obj poly_division_cpp.obj Gsolve.obj bubbleSort.obj equations6x6_B_cpp.obj equations6x6_C1_cpp.obj equations6x6_C2_cpp.obj equations6x6_C3_cpp.obj equations6x6_C4_cpp.obj equations6x6_C5_cpp.obj equations6x6_C6_cpp.obj -lmpfr
#include <iostream>
#include <matrix.h>
#include <mex.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <time.h>
#include <string>
#include "mpreal.h"
#include <ctime>

using namespace std;

#define MAX_TERMS 12
#define DIGITS 80

using mpfr::mpreal;   
void gelimd2_cpp(mpreal a[12][12],mpreal b[12],mpreal x[12], int n);
void polyroots_alternative_cpp(mpreal *a,int n      ,int max_iter , mpreal eps,mpreal *wr);
void bubbleSort(mpreal arr[], int n);
void bairstow1_cpp(mpreal *p, int n_p, mpreal eps, int N, mpreal *q, int &n_q, mpreal *f);
void poly_division_cpp(mpreal *N,mpreal *D, int dN, int dD, mpreal *q, mpreal *r, int &n_q, int &n_r);
void polyroots_cpp(mpreal *p,int p_order,int max_iter, mpreal eps,mpreal *r);
void equations6x6_C1_cpp(mpreal *C1,mpreal dB12, mpreal dB13, mpreal dB14, mpreal dB15, mpreal dB16, mpreal k12, mpreal k13, mpreal k14, mpreal k15, mpreal k16, mpreal k23, mpreal k24, mpreal k25, mpreal k26, mpreal k34, mpreal k35, mpreal k36, mpreal k45, mpreal k46, mpreal k56);
void equations6x6_C2_cpp(mpreal *C2,mpreal dB12, mpreal dB13, mpreal dB14, mpreal dB15, mpreal dB16, mpreal k12, mpreal k13, mpreal k14, mpreal k15, mpreal k16, mpreal k23, mpreal k24, mpreal k25, mpreal k26, mpreal k34, mpreal k35, mpreal k36, mpreal k45, mpreal k46, mpreal k56);
void equations6x6_C3_cpp(mpreal *C3,mpreal dB12, mpreal dB13, mpreal dB14, mpreal dB15, mpreal dB16, mpreal k12, mpreal k13, mpreal k14, mpreal k15, mpreal k16, mpreal k23, mpreal k24, mpreal k25, mpreal k26, mpreal k34, mpreal k35, mpreal k36, mpreal k45, mpreal k46, mpreal k56);
void equations6x6_C4_cpp(mpreal *C4,mpreal dB12, mpreal dB13, mpreal dB14, mpreal dB15, mpreal dB16, mpreal k12, mpreal k13, mpreal k14, mpreal k15, mpreal k16, mpreal k23, mpreal k24, mpreal k25, mpreal k26, mpreal k34, mpreal k35, mpreal k36, mpreal k45, mpreal k46, mpreal k56); 
void equations6x6_C5_cpp(mpreal *C5,mpreal dB12, mpreal dB13, mpreal dB14, mpreal dB15, mpreal dB16, mpreal k12, mpreal k13, mpreal k14, mpreal k15, mpreal k16, mpreal k23, mpreal k24, mpreal k25, mpreal k26, mpreal k34, mpreal k35, mpreal k36, mpreal k45, mpreal k46, mpreal k56); 
void equations6x6_C6_cpp(mpreal *C6,mpreal dB12, mpreal dB13, mpreal dB14, mpreal dB15, mpreal dB16, mpreal k12, mpreal k13, mpreal k14, mpreal k15, mpreal k16, mpreal k23, mpreal k24, mpreal k25, mpreal k26, mpreal k34, mpreal k35, mpreal k36, mpreal k45, mpreal k46, mpreal k56); 
void equations6x6_B_cpp(mpreal *B1,mpreal *B2, mpreal *B3, mpreal *B4, mpreal *B5, mpreal *B6, mpreal A1,mpreal A2, mpreal A3, mpreal A4, mpreal A5, mpreal A6, mpreal dB12, mpreal dB13, mpreal dB14, mpreal dB15, mpreal dB16, mpreal dB23, mpreal dB24, mpreal dB25, mpreal dB26, mpreal dB34, mpreal dB35, mpreal dB36, mpreal dB45, mpreal dB46, mpreal dB56, mpreal k12, mpreal k13, mpreal k14, mpreal k15, mpreal k16, mpreal k23, mpreal k24, mpreal k25, mpreal k26, mpreal k34, mpreal k35, mpreal k36, mpreal k45, mpreal k46, mpreal k56); 
void GSolve(mpreal a[MAX_TERMS][MAX_TERMS],int n,mpreal *x);

void mexFunction(int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[]) /* Input variables */
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal A1, A2, A3, A4, A5, A6;
    mpreal C1[MAX_TERMS],C2[MAX_TERMS],C3[MAX_TERMS],C4[MAX_TERMS],C5[MAX_TERMS],C6[MAX_TERMS];
    mpreal B1[MAX_TERMS],B2[MAX_TERMS],B3[MAX_TERMS],B4[MAX_TERMS],B5[MAX_TERMS],B6[MAX_TERMS];
    mpreal B1d[MAX_TERMS][MAX_TERMS],B2d[MAX_TERMS][MAX_TERMS],B3d[MAX_TERMS][MAX_TERMS],B4d[MAX_TERMS][MAX_TERMS],B5d[MAX_TERMS][MAX_TERMS],B6d[MAX_TERMS][MAX_TERMS];
    mpreal r1[MAX_TERMS],r2[MAX_TERMS],r3[MAX_TERMS],r4[MAX_TERMS],r5[MAX_TERMS],r6[MAX_TERMS]; 
    mpreal cte1[MAX_TERMS][MAX_TERMS],cte2[MAX_TERMS][MAX_TERMS],cte3[MAX_TERMS][MAX_TERMS],cte4[MAX_TERMS][MAX_TERMS],cte5[MAX_TERMS][MAX_TERMS],cte6[MAX_TERMS][MAX_TERMS]; 
    mpreal cte1C[MAX_TERMS],cte2C[MAX_TERMS],cte3C[MAX_TERMS],cte4C[MAX_TERMS],cte5C[MAX_TERMS],cte6C[MAX_TERMS];
    mpreal MM1[MAX_TERMS][MAX_TERMS],MM2[MAX_TERMS][MAX_TERMS],MM3[MAX_TERMS][MAX_TERMS],MM4[MAX_TERMS][MAX_TERMS],MM5[MAX_TERMS][MAX_TERMS],MM6[MAX_TERMS][MAX_TERMS];
    mpreal MM1cp[MAX_TERMS][MAX_TERMS],MM2cp[MAX_TERMS][MAX_TERMS],MM3cp[MAX_TERMS][MAX_TERMS],MM4cp[MAX_TERMS][MAX_TERMS],MM5cp[MAX_TERMS][MAX_TERMS],MM6cp[MAX_TERMS][MAX_TERMS];
    mpreal p[MAX_TERMS]; 
    mpreal tmp,eps,disc,auxX;
    mpreal maxCol1[MAX_TERMS],maxCol2[MAX_TERMS],maxCol3[MAX_TERMS],maxCol4[MAX_TERMS],maxCol5[MAX_TERMS],maxCol6[MAX_TERMS];
    mpreal a[MAX_TERMS][MAX_TERMS],A[MAX_TERMS];
    mpreal auxR1[MAX_TERMS], auxR2[MAX_TERMS], auxR3[MAX_TERMS], auxR4[MAX_TERMS], auxR5[MAX_TERMS], auxR6[MAX_TERMS];
    int    ii,i,j,i1, max_iter, n_p, n_f, p_order;
    int start_s, stop_s,start_s1, stop_s1;
    
    // Input Parameters
    mpreal dB12, dB13, dB14, dB15, dB16, dB23, dB24, dB25, dB26, dB34, dB35, dB36, dB45, dB46, dB56;
    mpreal k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56;
    dB12 = mxGetScalar(prhs[0]);  dB13 = mxGetScalar(prhs[1]);  dB14 = mxGetScalar(prhs[2]); dB15 = mxGetScalar(prhs[3]);  dB16 = mxGetScalar(prhs[4]);
    dB23 = mxGetScalar(prhs[5]);  dB24 = mxGetScalar(prhs[6]);  dB25 = mxGetScalar(prhs[7]); dB26 = mxGetScalar(prhs[8]);
    dB34 = mxGetScalar(prhs[9]);  dB35 = mxGetScalar(prhs[10]); dB36 = mxGetScalar(prhs[11]);
    dB45 = mxGetScalar(prhs[12]); dB46 = mxGetScalar(prhs[13]);
    dB56 = mxGetScalar(prhs[14]);
    k12  = mxGetScalar(prhs[15]); k13 = mxGetScalar(prhs[16]);  k14 = mxGetScalar(prhs[17]);  k15 = mxGetScalar(prhs[18]);  k16 = mxGetScalar(prhs[19]);
    k23  = mxGetScalar(prhs[20]); k24 = mxGetScalar(prhs[21]);  k25 = mxGetScalar(prhs[22]);  k26 = mxGetScalar(prhs[23]); 
    k34  = mxGetScalar(prhs[24]); k35 = mxGetScalar(prhs[25]);  k36 = mxGetScalar(prhs[26]);
    k45  = mxGetScalar(prhs[27]); k46 = mxGetScalar(prhs[28]);
    k56  = mxGetScalar(prhs[29]);
    
    
    // max_iter
    max_iter = 100;
        
    // eps
    eps = 1E-20;
    
    //order
    p_order = 10;
    
    // C-COEFFiCIENTS
    equations6x6_C1_cpp(C1,dB12, dB13, dB14, dB15, dB16, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);
    equations6x6_C2_cpp(C2,dB12, dB13, dB14, dB15, dB16, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);
    equations6x6_C3_cpp(C3,dB12, dB13, dB14, dB15, dB16, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);
    equations6x6_C4_cpp(C4,dB12, dB13, dB14, dB15, dB16, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);
    equations6x6_C5_cpp(C5,dB12, dB13, dB14, dB15, dB16, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);
    equations6x6_C6_cpp(C6,dB12, dB13, dB14, dB15, dB16, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);

    // Roots
    polyroots_alternative_cpp(C1,p_order,max_iter,eps,r1);
    polyroots_alternative_cpp(C2,p_order,max_iter,eps,r2);
    polyroots_alternative_cpp(C3,p_order,max_iter,eps,r3);
    polyroots_alternative_cpp(C4,p_order,max_iter,eps,r4);
    polyroots_alternative_cpp(C5,p_order,max_iter,eps,r5);
    polyroots_alternative_cpp(C6,p_order,max_iter,eps,r6);  
    
    // M-matrices
    for(i = 0;i<p_order;i++){
        ii = i;
        while(ii > 0){ii = ii-4;}
        ii = ii + 4;
        
        auxX =  1;
        if(ii == 0){auxX =  1;}
        if(ii == 1){auxX =  1;}
        if(ii == 2){auxX = -1;}
        if(ii == 3){auxX = -1;}
        if(ii == 4){auxX =  1;}
        
        for(j = 0;j<p_order;j++){
            MM1[i][j] = auxX*mpfr::pow(r1[j],i);
            MM2[i][j] = auxX*mpfr::pow(r2[j],i);
            MM3[i][j] = auxX*mpfr::pow(r3[j],i);
            MM4[i][j] = auxX*mpfr::pow(r4[j],i);
            MM5[i][j] = auxX*mpfr::pow(r5[j],i);
            MM6[i][j] = auxX*mpfr::pow(r6[j],i);
        }
    }

    for(i1 = 0;i1 < 6;i1++){
        A[0] = 0; A[1] = 0; A[2] = 0; A[3] = 0; A[4] = 0; A[5] = 0;
        A[i1] = 1;
        
        for(i = 0;i<p_order;i++){
            for(j = 0;j<p_order;j++){
                MM1cp[i][j] = MM1[i][j];
                MM2cp[i][j] = MM2[i][j];
                MM3cp[i][j] = MM3[i][j];
                MM4cp[i][j] = MM4[i][j];
                MM5cp[i][j] = MM5[i][j];
                MM6cp[i][j] = MM6[i][j];
            }
        }
        
        equations6x6_B_cpp(B1,B2,B3,B4,B5,B6,A[0],A[1],A[2],A[3],A[4],A[5],dB12, dB13, dB14, dB15, dB16, dB23, dB24, dB25, dB26, dB34, dB35, dB36, dB45, dB46, dB56, k12, k13, k14, k15, k16, k23, k24, k25, k26, k34, k35, k36, k45, k46, k56);

        for(i=0; i<p_order; i++){
            MM1cp[i][p_order] = B1[i];
            MM2cp[i][p_order] = B2[i];
            MM3cp[i][p_order] = B3[i];
            MM4cp[i][p_order] = B4[i];
            MM5cp[i][p_order] = B5[i];
            MM6cp[i][p_order] = B6[i];
        }
    
        GSolve(MM1cp,p_order,cte1C);
        GSolve(MM2cp,p_order,cte2C);
        GSolve(MM3cp,p_order,cte3C);
        GSolve(MM4cp,p_order,cte4C);
        GSolve(MM5cp,p_order,cte5C);
        GSolve(MM6cp,p_order,cte6C);

        for(i = 0;i<p_order;i++){
            cte1[i][i1] = cte1C[i];
            cte2[i][i1] = cte2C[i];
            cte3[i][i1] = cte3C[i];
            cte4[i][i1] = cte4C[i];
            cte5[i][i1] = cte5C[i];
            cte6[i][i1] = cte6C[i];
        }
     
    }
  
    // Output
    const int n = p_order;
    plhs[0] = mxCreateNumericMatrix(10, 1, mxDOUBLE_CLASS, mxREAL);
    plhs[1] = mxCreateNumericMatrix(10, 1, mxDOUBLE_CLASS, mxREAL);
    plhs[2] = mxCreateNumericMatrix(10, 1, mxDOUBLE_CLASS, mxREAL);
    plhs[3] = mxCreateNumericMatrix(10, 1, mxDOUBLE_CLASS, mxREAL);
    plhs[4] = mxCreateNumericMatrix(10, 1, mxDOUBLE_CLASS, mxREAL);
    plhs[5] = mxCreateNumericMatrix(10, 1, mxDOUBLE_CLASS, mxREAL);
    plhs[6] = mxCreateNumericMatrix(10, 1, mxDOUBLE_CLASS, mxREAL);
    
//     printf("Reserving space\n");
    plhs[6]  = mxCreateNumericMatrix(10, 6, mxDOUBLE_CLASS, mxREAL);
    plhs[7]  = mxCreateNumericMatrix(10, 6, mxDOUBLE_CLASS, mxREAL);
    plhs[8]  = mxCreateNumericMatrix(10, 6, mxDOUBLE_CLASS, mxREAL);
    plhs[9]  = mxCreateNumericMatrix(10, 6, mxDOUBLE_CLASS, mxREAL);
    plhs[10] = mxCreateNumericMatrix(10, 6, mxDOUBLE_CLASS, mxREAL);
    plhs[11] = mxCreateNumericMatrix(10, 6, mxDOUBLE_CLASS, mxREAL);   
//     printf("Reservation done\n");
    
    double *r1R,*r2R,*r3R,*r4R,*r5R,*r6R;
    double *cte1R,*cte2R,*cte3R,*cte4R,*cte5R,*cte6R;
    
    r1R = mxGetPr(plhs[0]);
    r2R = mxGetPr(plhs[1]);
    r3R = mxGetPr(plhs[2]);
    r4R = mxGetPr(plhs[3]);
    r5R = mxGetPr(plhs[4]);
    r6R = mxGetPr(plhs[5]);
    cte1R = mxGetPr(plhs[6]);
    cte2R = mxGetPr(plhs[7]);
    cte3R = mxGetPr(plhs[8]);
    cte4R = mxGetPr(plhs[9]);
    cte5R = mxGetPr(plhs[10]);
    cte6R = mxGetPr(plhs[11]);
 
    for (int i=0;i<n;i++){
        r1R[i] =  r1[i].toDouble();
        r2R[i] =  r2[i].toDouble();
        r3R[i] =  r3[i].toDouble();
        r4R[i] =  r4[i].toDouble();
        r5R[i] =  r5[i].toDouble();
        r6R[i] =  r6[i].toDouble();
        
    }
    
    for (int i1=0;i1<6;i1++){
        for (int i=0;i<n;i++){
            cte1R[i+i1*10] = cte1[i][i1].toDouble();
            cte2R[i+i1*10] = cte2[i][i1].toDouble();
            cte3R[i+i1*10] = cte3[i][i1].toDouble();
            cte4R[i+i1*10] = cte4[i][i1].toDouble();
            cte5R[i+i1*10] = cte5[i][i1].toDouble();
            cte6R[i+i1*10] = cte6[i][i1].toDouble();
        }
    }
    
    return;
}

