/* PS101 main function - Arnold Christopher Koroa - A0092101Y */

#include <stdio.h>

extern int eax,ebx,ecx,edx,esi,edi;
extern unsigned char M[10000];
extern void exec();

int main(){
    esi = 40;
    char s[] = "12098";
    char *sp = (char*)&M[esi];
    strcpy(sp,s);
    exec();
    printf("%d",eax);

    return 0;
}
