  
#include <matrix.h>
#include <mex.h>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <time.h>
#include "mpreal.h"

#define MAX_TERMS 12
#define DIGITS 80

using mpfr::mpreal;    
void poly_division_cpp(mpreal *Nin,mpreal *Din, int dN, int dD, mpreal *q, mpreal *r, int &n_q, int &n_r);

void bairstow1_cpp(mpreal *p, int n_p, mpreal eps, int N, mpreal *q, int &n_q, mpreal *f)
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal r, s, d[MAX_TERMS], q1[MAX_TERMS], q2[MAX_TERMS], r1[MAX_TERMS], r2[MAX_TERMS], p2[MAX_TERMS], a[4], b[2], drs[2], Naux[MAX_TERMS], Daux[MAX_TERMS];
    mpreal tmp,disc;
    int    i,i1,n;
    int    n_p2,n_q1,n_q2,n_r1,n_r2;
    mpreal b0,b1,c1,c2,c3,aux,aux1;
        
    n = n_p;
    r = ((double)rand() / (double)RAND_MAX); //error
    s = ((double)rand() / (double)RAND_MAX); //error
//     r = "0.12700000000000000000000000000000000000000000000000000000000000000";
//     s = "0.91340000000000000000000000000000000000000000000000000000000000000";
       
    for(i=0; i<N; i++){
       d[0] = "1.0"; d[1] = -r; d[2] = -s;  

       poly_division_cpp(p, d, n_p, 2, q1, r1, n_q1, n_r1);  //[q1,r1] = deconv(p,d);
       d[0] = "1.0"; d[1] = -r; d[2] = -s;

       b0 = r1[n_r1] + r*r1[n_r1-1];
       b1 = r1[n_r1-1];
       
       for(i1=0; i1<n_q1+1; i1++)
            p2[i1] = q1[i1];
       p2[n_q1+1] = b1;
       p2[n_q1+2] = b0;
       n_p2 = n_q1 + 2;
       
       
       poly_division_cpp(p2, d, n_p2, 2, q2, r2, n_q2, n_r2); //[q2,r2] = deconv(p2,d);
       c1 = r2[n_r2-1];                 // define linear system
       c2 = q2[n_q2  ];
       c3 = q2[n_q2-1];
       
       a[0] = c2;  a[2] = c3;
       a[1] = c1;  a[3] = c2;
       b[0] = -b1; b[1] = -b0; 

       aux = "1.0" / (a[0]*a[3] - a[2]*a[1]);
       drs[0] = aux * ( a[3]*b[0] - a[2]*b[1]);
       drs[1] = aux * (-a[1]*b[0] + a[0]*b[1]);
 
       r = r + drs[0];
       s = s + drs[1];
       
       aux1 = sqrt( mpfr::pow(drs[0],2) + mpfr::pow(drs[1],2) );
       if (sqrt( mpfr::pow(drs[0],2) + mpfr::pow(drs[1],2) )  < eps){
          break;
       };
    };
    
    for(i=0; i<n_q1+1; i++)
    	q[i] = q1[i];
    n_q = n_q1;
    
    for(i=0; i<3; i++)
    	f[i] = d[i];
    
    return;
}