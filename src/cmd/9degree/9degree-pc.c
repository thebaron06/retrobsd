#include <stdio.h>
#include <math.h>
#include <sys/time.h>

void print64x( double x ) {
    char* p;
    int j;
    p = (char *) &x; 
    for( j=0; j< sizeof(x); j++) {
        printf("%02X", p[(sizeof(x)-1)-j]&0xFF);
    }
}

void print32x( float x ) {
    char* p;
    int j;
    p = (char *) &x; 
    for( j=0; j< sizeof(x); j++) {
        printf("%02X", p[(sizeof(x)-1)-j]&0xFF);
    }
}
 
int main() {
    struct timeval start, stop;
    volatile double _p64, q64, r64, e64;
    long i;
    unsigned long elapsed;
   
    _p64 = 3.1415926535897932384626433832795;

    for(i=0;i<100;i++) {
        // 64bit test
        // 9 degree test input
        q64 = i;
        // Convert to radians
        q64 = q64 * _p64 / 180.0;
        // Make the test
       
        gettimeofday(&start, NULL);
       
        r64 = (asin(acos(atan(tan(cos(sin(q64)))))));
       
        gettimeofday(&stop, NULL);
       
        // Convert to degree
        r64 = r64 * 180.0 / _p64;

        elapsed = stop.tv_usec - start.tv_usec;
       
        printf("%ld degree 64bit test result= %1.15e  time= %lu\n" , i, r64, elapsed );
        //printf("= 0x");
        //print64x( r64 );
        //printf("\n");
    }

    return 0;
}
