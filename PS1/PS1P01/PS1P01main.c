/* PS101 main function - Arnold Christopher Koroa - A0092101Y */

#include <stdio.h>

extern int eax,ebx,ecx,edx,esi,edi;
extern unsigned char M[10000];
extern void exec();

int main(){
    int sum;

    eax = 1; ebx = 4; ecx = 27;
    edx = 1; esi = 12; edi = 9;
    sum = eax+ebx+ecx+edx+esi+edi;
    exec();
    printf("%d is odd? %d\n",sum,eax);

    eax = 1; ebx = 4; ecx = 27;
    edx = 2; esi = 12; edi = 9;
    sum = eax+ebx+ecx+edx+esi+edi;
    exec();
    printf("%d is odd? %d\n",sum,eax);

    return 0;
}
