// Pito 12/2013

#include <stdio.h>
#include <math.h>
 
// print out double (IEEE 64bit) variable in HEX
// ie. 9.0 is 4022000000000000
// more on http://babbage.cs.qc.cuny.edu/IEEE-754/
 
void print64x( double x ) {
    const unsigned char* p;
    int j;
    p = (unsigned char *) &x; 
    printf("%02X", p[7]);
    printf("%02X", p[6]);
    printf("%02X", p[5]);
    printf("%02X", p[4]);
    printf("%02X", p[3]);
    printf("%02X", p[2]);
    printf("%02X", p[1]);
    printf("%02X", p[0]);
}
 
void print32x( float x ) {
    const char* p;
    int j;
    p = (char *) &x; 
    for( j=0; j< sizeof(x); j++) {
        printf("%02X", p[(sizeof(x)-1)-j]&0xFF);
    }
}
 
int main() {
    volatile double num1 = 1.2499999999999998193580478994e-10;
    volatile double num2 = 2.16000000000000081281633984229e-10;
    volatile double res = 0;

    res = num1 + num2;

//    print64x(num1);
//    printf(" + ");
//    print64x(num2);
//    printf(" = ");
//    print64x(res);
//    printf("\n");

    printf("%1.15e + %1.15e = %1.15e\n", num1, num2, res);
    return 0;
}
