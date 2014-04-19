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
    double num;
    int i;
    double sum;
    FILE *InFile, *OutFile;
    char str[100];
    double backup;
    double result;

    if ((OutFile = fopen("num.dat","w")) == 0) {
        printf("num.dat not found\n");
        return (1);
    }
 
    for (i=0; i<=10000; i++) {
        num = 0.0001L * (double)(i);
        num = num * num * num;
        fprintf(OutFile, "%1.15e\n", num);
    }
 
    fclose(OutFile);
 
    if ((InFile = fopen("num.dat","r")) == 0) {
        printf("num.dat not found\n");
        return (1);
    }
 
    sum = 0;
    num = 0;
 
    for (i=0; i<=10000; i++) {
        backup = sum;
        fgets (str, 80, InFile);
        sscanf (str,"%le",&num); 
        result = sum + num;

        if (sum != backup) {
            printf("*** SUM CHANGED: %1.15e => %1.15e ***\n", backup, sum);
        }
        sum = result;
    }
 
    printf("Sum test result = %1.15e\n", sum);
    printf("Shall be result = 2.500500025000002e+03\n");
    printf("Sum test result (HEX) = ");
    print64x( sum );
    printf("\n");
    printf("Shall be result (HEX) = 40A389000346DC62\n");

    fclose(InFile);
    return 0;
}
