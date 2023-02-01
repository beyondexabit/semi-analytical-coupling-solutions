#include <iostream>
#include <iomanip>
#include <math.h>
#include <stdlib.h>
#include <matrix.h>
#include <mex.h>
#include "mpreal.h"

#define MAX_TERMS 12
#define DIGITS 80

using mpfr::mpreal; 

#define maxiter 500

int roots(mpreal *a,int n,mpreal *wr,mpreal *wi)
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal sq,b2,c,disc;
    int i,m,numroots;

    m = n;
    numroots = 0;
    while (m > 1) {
        b2 = "-0.5000"*a[m-2];
        c = a[m-1];
        disc = b2*b2-c;
        if (disc < "0.0") {                   //  roots complex
            sq = mpfr::sqrt(-disc);
            wr[m-2] = b2;
            wi[m-2] = sq;
            wr[m-1] = b2;
            wi[m-1] = -sq;
            numroots+=2;
        }
        else {                              //  roots real
            sq = mpfr::sqrt(disc);
            wr[m-2] = mpfr::fabs(b2)+sq;
            if (b2 < "0.0") wr[m-2] = -wr[m-2];
            if (wr[m-2] == 0)
                wr[m-1] = 0;
            else {
                wr[m-1] = c/wr[m-2];
                numroots+=2;
            }
            wi[m-2] = "0.0";
            wi[m-1] = "0.0";
        }
        m -= 2;
    }
    if (m == 1) {
       wr[0] = -a[0];
       wi[0] = "0.0";
       numroots++;
    }
    return numroots;
}

void deflate(mpreal *a,int n,mpreal *b,mpreal *quad,mpreal *err)
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal r,s;
    int i;

    r = quad[1];
    s = quad[0];

    b[1] = a[1] - r;

    for (i=2;i<=n;i++){
        b[i] = a[i] - r * b[i-1] - s * b[i-2];
    }
    *err = mpfr::fabs(b[n])+mpfr::fabs(b[n-1]);
}

void find_quad(mpreal *a,int n,mpreal *b,mpreal *quad,mpreal *err, int *iter)
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal *c,dn,dr,ds,drn,dsn,eps,r,s;
    int i;

    c = new mpreal [n+1];
    c[0] = "1.0";
    r = quad[1];
    s = quad[0];
    eps = "1e-20";
    *iter = 1;

    do {
        if (*iter > maxiter) break;
        if (((*iter) % 200) == 0) {
            eps = eps * "10.0";
		}
		b[1] = a[1] - r;
		c[1] = b[1] - r;

		for (i=2;i<=n;i++){
			b[i] = a[i] - r * b[i-1] - s * b[i-2];
			c[i] = b[i] - r * c[i-1] - s * c[i-2];
		}
		dn=c[n-1] * c[n-3] - c[n-2] * c[n-2];
		drn=b[n] * c[n-3] - b[n-1] * c[n-2];
		dsn=b[n-1] * c[n-1] - b[n] * c[n-2];

        if (mpfr::fabs(dn) < "1e-15") {
            if (dn < "0.0") dn = "-1e-12";
            else dn = "1e-12";
        }
        dr = drn / dn;
        ds = dsn / dn;
		r += dr;
		s += ds;
        (*iter)++;
    } while ((mpfr::fabs(dr)+mpfr::fabs(ds)) > eps);
    quad[0] = s;
    quad[1] = r;
    *err = mpfr::fabs(ds)+mpfr::fabs(dr);
    delete [] c;
}

void diff_poly(mpreal *a,int n,mpreal *b)
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal coef;
    int i;

    coef = (mpreal)n;
    b[0] = "1.0";
    for (i=1;i<n;i++) {
        b[i] = a[i]*((mpreal)(n-i))/coef;            
    }
}

void recurse(mpreal *a,int n,mpreal *b,int m,mpreal *quad, mpreal *err,int *iter)
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal *c,*x,rs[2],tst,e1,e2;

    if (mpfr::fabs(b[m]) < "1e-21") m--;   
    if (m == 2) {
        quad[0] = b[2];
        quad[1] = b[1];
        *err = "0.0";
        *iter = 0;
        return;
    }
    c = new mpreal [m+1];
    x = new mpreal [n+1];
    c[0] = x[0] = "1.0";
    rs[0] = quad[0];
    rs[1] = quad[1];
    *iter = 0;
    find_quad(b,m,c,rs,err,iter);
    tst = mpfr::fabs(rs[0]-quad[0])+mpfr::fabs(rs[1]-quad[1]);
    if (*err < "1e-17") {
        quad[0] = rs[0];
        quad[1] = rs[1];
    }
    if (((*iter > 5) && (tst < "1e-4")) || ((*iter > 20) && (tst < "1e-1"))) {
        diff_poly(b,m,c);
        recurse(a,n,c,m-1,rs,err,iter);
        quad[0] = rs[0];
        quad[1] = rs[1];
    }
    delete [] x;
    delete [] c;
}

void get_quads(mpreal *a,int n,mpreal *quad,mpreal *x)
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal *b,*z,err,tmp;
    mpreal xr,xs;
    int iter,i,m;

    if ((tmp = a[0]) != "1.0") {
        a[0] = "1.0";
        for (i=1;i<=n;i++) {
            a[i] /= tmp;
        }
    }
    if (n == 2) {
        x[0] = a[1];
        x[1] = a[2];
        return;
    }
    else if (n == 1) {
        x[0] = a[1];
        return;
    }
    m = n;
    b = new mpreal [n+1];
    z = new mpreal [n+1];
    b[0] = "1.0";
    
    for (i=0;i<=n;i++) {
        z[i] = a[i];
        x[i] = "0.0";
    }
    do {            
        if (n > m) {
            quad[0] = "3.14159e-1";
            quad[1] = "2.78127e-1";
        }
        do {                   
            for (i=0;i<5;i++) { 
                find_quad(z,m,b,quad,&err,&iter);

                deflate(z,m,b,quad,&err);
                if (err < "0.00001") break;

                quad[0] = ((double)rand() / (double)RAND_MAX)*4; //error
                quad[1] = ((double)rand() / (double)RAND_MAX)*4; //error
            }
        } while (err > "0.0001");

        x[m-2] = quad[1];
        x[m-1] = quad[0];
        m -= 2;
        
        for (i=0;i<=m;i++) {
            z[i] = b[i];
        }
    } while (m > 2);
    
    if (m == 2) {
        x[0] = b[1];
        x[1] = b[2];
    }
    else x[0] = b[1];
    delete [] z;
    delete [] b;
}
// This was called polyroots_crbond_cpp. I changed it to polyroots_alternative_cpp cause it seems it has the same inputs as the polyroots_alternative_cpp and otherwise there's no such declaration in the library.
void   polyroots_alternative_cpp(mpreal *a,int n      ,int max_iter , mpreal eps,mpreal *wr) /* Input variables */
{
    mpreal::set_default_prec(mpfr::digits2bits(DIGITS));
    mpreal x[21],wi[21],quad[2],err,t;
    int iter,i,numr;

    quad[0] = "0.2718280000000000000000";
    quad[1] = "0.3141590000000000000000";

    get_quads(a,n,quad,x);
    numr = roots(x,n,wr,wi);
    return;
}
