# semi-analytical-coupling-solutions

Ferreira, Filipe et al. (2017) Semi-Analytical Modelling of Linear Mode Coupling in Few-Mode Fibers.
[Dataset] Available from: https://doi.org/10.17036/researchdata.aston.ac.uk.00000206

## Summary
A MEX (Matlab executable) file is a function, created in MATLAB, that calls a C/C++ program or a Fortran subroutine. MEX files are used here to speed up the computation. A MEX function behaves just like a MATLAB script or function. However, their compilation is OS dependent. The extensions are also different among the different OS.

For this project, the dynamically linked library MPFR++ is exploited, which is a C++ library for multiple-precision floating-point computations with correct rounding. MPFR++ is built on top of MPFR, which is the original C library for multiple-precision floating-point computations with correct rounding, but which has unfriendly assembly-like function calls even for summation. MPFR C++ subtitutes them with more compact and intuitive expressions.

GMP is another math library, on top of which MPFR has been designed.

## Dependencies
For this project, the package libgmp, libgmp-dev, libmpfr, libmpfr-dev and mpfrc++-dev are necessary. The first three might be autmatically installed in a Linux system, thus only the last two should need to be added. The dev packages provide additional files needed
for compilation and linking.

The code was tested with Kubuntu 22.04, Matlab R2022b, libgmp 6.2.1, libgmp-dev 6.2.1, libmpfr6 4.1.0, libmpfr-dev 4.1.0, mpfrc++-dev 3.6.9. The installation might require also the package m4.

## Changelog
* Removed the option -lmpfr from the compilation instructions since not necessary.
* Corrected the typo Gsolve to GSolve in some compiling commands.
* Changed the declaration of polyroots_crbond_cpp to polyroots_alternative_cpp in polyroots_alternative_cpp.cpp, because otherwise the function call polyroots_alternative_cpp (in equations6x6_doubleIOrand_cpp) would throw an error.
* Removed the headers gmp.h, mpreal.h, mpfr.h. They are already in the search path for the compiler, if the dependencies mentioned above are met. Removed mpir.h, which, at least for Linux and for the present application, is not necessary. No shared libraries need to be included since, again, they are installed in the search path for both the linker (ld) and the loader (ld.so), if the dependencies are met (see above). There's no need to set the env variable LD_LIBRARY_PATH, conversely to what it seems indicated in the Matlab help (https://www.mathworks.com/help/matlab/matlab_external/building-on-unix-operating-systems.html#f28833).
* Corrected the scripts in 0_differential_equations_solver since Matlab symbolic computation function has changed syntax.


