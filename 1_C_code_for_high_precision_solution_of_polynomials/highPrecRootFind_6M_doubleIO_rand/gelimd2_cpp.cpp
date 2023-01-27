//mex -lgsl -lcblas bairstow_cpp.cpp bairstow1_cpp.cpp poly_division_cpp.cpp
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

#define EPS 1e-20

#define MAX_TERMS 12
#define DIGITS 80
// mpfr::mpreal::set_default_prec(mpfr::digits2bits(DIGITS));

using mpfr::mpreal;    


/* This version preserves the matrix 'a' and the vector 'b'. */
void gelimd2_cpp(mpreal a[12][12],mpreal b[12],mpreal x[12], int n)
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal tmp,pvt,*t,**aa,*bb;
    int i,j,k,itmp,retval;

    retval = 0;
    aa = new mpreal *[n];
    bb = new mpreal [n];
    for (i=0;i<n;i++) {
        aa[i] = new mpreal [n];
        bb[i] = b[i];
        for (j=0;j<n;j++) {
            aa[i][j] = a[i][j];
        }
    }
    for (i=0;i<n;i++) {             // outer loop on rows
        pvt = aa[i][i];              // get pivot value
        if (mpfr::fabs(pvt) < EPS) {
            for (j=i+1;j<n;j++) {
                if(mpfr::fabs(pvt = aa[j][i]) >= EPS) break;
            }
            if (mpfr::fabs(pvt) < EPS) {
                retval = 1;
                goto _100;     // pull the plug!
            }
            t=aa[j];                 // swap matrix rows...
            aa[j]=aa[i];
            aa[i]=t;
            tmp=bb[j];               // ...and result vector
            bb[j]=bb[i];
            bb[i]=tmp;        
        }
// (virtual) Gaussian elimination of column
        for (k=i+1;k<n;k++) {       // alt: for (k=n-1;k>i;k--)
            tmp = aa[k][i]/pvt;
            for (j=i+1;j<n;j++) {   // alt: for (j=n-1;j>i;j--)
                aa[k][j] -= tmp*aa[i][j];
            }
            bb[k] -= tmp*bb[i];
        }
	}
// Do back substitution
	for (i=n-1;i>=0;i--) {
        x[i]=bb[i];
		for (j=n-1;j>i;j--) {
            x[i] -= aa[i][j]*x[j];
		}
        x[i] /= aa[i][i];
	}
// Deallocate memory
_100:
    for (i=0;i<n;i++) {
        delete [] aa[i];
    }
    delete [] aa;
    delete [] bb;
    return;
}
