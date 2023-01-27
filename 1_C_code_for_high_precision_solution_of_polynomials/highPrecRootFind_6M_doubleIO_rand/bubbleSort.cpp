//mex -lgsl -lcblas bairstow_cpp.cpp bairstow1_cpp.cpp poly_division_cpp.cpp
#include "mpreal.h"
#include <string>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#define MAX_TERMS 12
#define DIGITS 80

using mpfr::mpreal;   

void bubbleSort(mpreal arr[], int n) 
{
      mpreal::set_default_prec(mpfr::digits2bits(DIGITS));

      bool swapped = true;

      int j = 0;

      mpreal tmp;

      while (swapped) {

            swapped = false;

            j++;

            for (int i = 0; i < n - j; i++) {

                  if (abs(arr[i]) > abs(arr[i + 1])) {

                        tmp = arr[i];

                        arr[i] = arr[i + 1];

                        arr[i + 1] = tmp;

                        swapped = true;

                  }

            }

      }

}