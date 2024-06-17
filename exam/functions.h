#ifndef FUNCTIONS_H
#define FUNCTIONS_H

#include <math.h>

double f0(double a, double b, double c, double d) {
    return fmax(fmax(a, b), fmax(c, d));
}

double f1(double x) {
    return 5*pow(x, 3) + 2*pow(x, 2) - 7*x + 5;
}

double f2(double x) {
    return sin(5*x) * 3 + 7;
}

double f3(double x) {
    return 9*x + 7;
}

double f4(double x) {
    return 1 / (1 + exp(5*x));
}

#endif



