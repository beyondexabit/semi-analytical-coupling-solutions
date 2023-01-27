#include "mex.h"
#include "matrix.h"
#include <iostream>
#include <math.h>
#include "mpreal.h"

#define MAX_TERMS 12
#define DIGITS 80
// mpfr::mpreal::set_default_prec(mpfr::digits2bits(DIGITS));

using mpfr::mpreal;    

void poly_division_cpp(mpreal *Nin,mpreal *Din, int dN, int dD, mpreal *q, mpreal *r, int &n_q, int &n_r) 
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
	mpreal N[MAX_TERMS],D[MAX_TERMS],d[MAX_TERMS],Naux[MAX_TERMS],Daux[MAX_TERMS];	// vectors - N / D = q       N % D = r
	int dd, dq, dr;	        // degrees of vectors
	int i,i1;					// iterators
    
    
    // Reversing polys
    for( i = 0 ; i < dN+1; i++ )
        N[i] = Nin[dN-i];
    
    for( i = 0 ; i < 2+1; i++ )
        D[i] = Din[2-i];
     
    // setting the degrees of vectors
	dq = dN-dD;  
	dr = dN-dD;
    
    // zero padding
	for( i = dD+1 ; i < dN+1; i++ )
		d[i] = "0.0";
 
	for( i = 0 ; i < dq + 1 ; i++ )
		q[i] = "0.0";
 
	for( i = 0 ; i < dr + 1 ; i++ )
		r[i] = "0.0";
 
// // 	printf("-- Procedure --\n\n"); 
	if( dN >= dD ) {
		while(dN >= dD) {
            // d equals D shifted right
			for( i = 0 ; i < dN + 1 ; i++ ) {
				d[i] = "0.0";
			}
			for( i = 0 ; i < dD + 1 ; i++ ) {
				d[i+dN-dD] = D[i];
			}
			dd = dN;


            // calculating one element of q
			q[dN-dD] = N[dN]/d[dd];
 
            // d equals d * q[dN-dD]
			for( i = 0 ; i < dq + 1 ; i++ ) {
				d[i] = d[i] * q[dN-dD];
			}

            // N equals N - d
			for( i = 0 ; i < dN + 1 ; i++ ) {
				N[i] = N[i] - d[i];
			}
			dN--;
 
		}
	}
 
    // r equals N 
	for( i = 0 ; i < dN + 1 ; i++ ) {
		r[i] = N[i];
	}
	dr = dN;
 
    
    // Reversing polys
    for(i=0 ; i<dq+1; i++)
		Naux[i] = q[dq-i];
    for(i=0 ; i<dq+1; i++)
		q[i] = Naux[i];
    
    for(i=0; i<dr+1; i++ )
		Daux[i] = r[dr-i];
    for(i=0; i<dr+1; i++ )
		r[i] = Daux[i];

    n_q = dq;
    n_r = dr;
 

}