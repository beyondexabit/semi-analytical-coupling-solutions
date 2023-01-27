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

#define MAX_TERMS 12
#define DIGITS 80
// mpfr::mpreal::set_default_prec(mpfr::digits2bits(DIGITS));

using mpfr::mpreal;    

void GSolve(mpreal a[MAX_TERMS][MAX_TERMS],int n,mpreal *x)
{
   mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
   int i,j,k,maxrow;
   mpreal tmp;


   for (i=0;i<n;i++) {

      /* Find the row with the largest first value */
      maxrow = i;
      for (j=i+1;j<n;j++) {
         if (abs(a[j][i]) > abs(a[maxrow][i]))
            maxrow = j;
      }

      /* Swap the maxrow and ith row */
      for (k=i;k<n+1;k++) {
         tmp = a[i][k];
         a[i][k] = a[maxrow][k];
         a[maxrow][k] = tmp;
      }

      /* Singular matrix? */
//       if (abs(a[i][i]) < EPS)
//          return(FALSE);

      /* Eliminate the ith element of the jth row */
      for (j=i+1;j<n;j++) {
         for (k=n;k>=i;k--) {
            a[j][k] -= a[i][k] * a[j][i] / a[i][i];
         }
      }
   }

   /* Do the back substitution */
   for (j=n-1;j>=0;j--) {
      tmp = "0.00000000000000000000000000000";
      for (k=j+1;k<n;k++)
         tmp += a[j][k] * x[k];
      x[j] = (a[j][n] - tmp) / a[j][j];
   }

   return;
}