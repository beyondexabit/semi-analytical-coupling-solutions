//mex -lgsl -lcblas bairstow_cpp.cpp bairstow1_cpp.cpp poly_division_cpp.cpp
#include <iostream>
#include <matrix.h>
#include <mex.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <time.h>
#include "mpreal.h"

#define MAX_TERMS 12
#define DIGITS 80
// mpfr::mpreal::set_default_prec(mpfr::digits2bits(DIGITS));

using mpfr::mpreal;    
void bairstow1_cpp(mpreal *p, int n_p, mpreal eps, int N, mpreal *q, int &n_q, mpreal *f);
void poly_division_cpp(mpreal *N,mpreal *D, int dN, int dD, mpreal *q, mpreal *r, int &n_q, int &n_r);

void polyroots_cpp(mpreal *p,int p_order,int max_iter, mpreal eps,mpreal *r) /* Input variables */
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal q[MAX_TERMS],f[MAX_TERMS]; 
    mpreal tmp,disc;
    int    i,i1, n_p, n_q, n_f, q_order;
    

    n_p = p_order;
    // copy polynomial
    for(i=0; i<n_p+1; i++)
        q[i] = p[i];
    q_order = p_order;
    n_q = n_p;
        
    n_f = 2;
    for(i=0; i<(int)floor(((double)p_order+1.0)/2.0); i++){//
       if((n_q+1) <= 3){
          for(i1=0; i1<n_q+1; i1++)
               f[i1] = q[i1];
          n_f = n_q;
          n_q = 0;
          
       }else{
          bairstow1_cpp(q,n_q,eps,max_iter,q,n_q,f);
       }

       if(n_f == 1){
          r[2*i] = -f[2-1]/f[1-1];
       }else{
          disc = abs(pow(f[2-1],2) - 4*f[1-1]*f[3-1]);
          
          r[2*i  ] = (-f[2-1] - sqrt(disc))/(2*f[1-1]);
          r[2*i+1] = (-f[2-1] + sqrt(disc))/(2*f[1-1]);
       };
    };
    
    return;
}
    
    
    

