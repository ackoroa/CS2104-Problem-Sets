/* PS105 main function - Arnold Christopher Koroa - A0092101Y */

#include <stdio.h>

extern eax,ebx,ecx,edx,esi,edi;
extern unsigned char M[10000];
extern void exec();

int main(){
    esi = 2*4;

    int *a = (int*)&M[0];
    a[2] = 1; a[3] = 4*4;
    a[4] = 2; a[5] = 22*4;
    a[22] = 3; a[23] = 10*4;
    a[10] = 4; a[11] = 26*4;
    a[26] = 5; a[27] = 30*4;
    a[30] = 6; a[31] = 7*4;
    a[7] = 7; a[8] = 131*4;
    a[131] = 8; a[132] = 98*4;
    a[98] = 9; a[99] = 225*4;
    a[225] = 10; a[226] = 0*4;

    exec();

    printf("%d",eax);

    return 0;
}
