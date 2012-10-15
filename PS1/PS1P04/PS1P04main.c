/* PS104 main function - Arnold Christopher Koroa - A0092101Y */

#include <stdio.h>

extern eax,ebx,ecx,edx,esi,edi;
extern unsigned char M[10000];
extern void exec();

int main(){
    int i,n;

    printf("N = ");
    scanf("%d",&n);

    ecx = n;
    exec();

    //prints more than reqired to check for over-generation
    //elements of M[] are initialized to 0 during declaration
    int* a = (int*)&M[0];
    for(i=0;i<n;i++){
        printf("%d ",a[i]);
    }
    printf("\n");

    char s[10];
    scanf("%s",s);

    return 0;
}
