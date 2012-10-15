/** PS5P02 Arnold Christopher Koroa A0092101Y **/

#include <stdio.h>

int eax, ebx, ecx, edx, esi, edi, esp, ebp;
char M[10000];

// unused variables aren't saved during function calls
// for conciseness reasons
void exec(){
    /** main function **/
    // set up main's Activation Record
    esp -= 4; *(int*)&M[esp] = ebp; //push ebp
    ebp = esp;

    // allocate space for p
    esp -= 4;

    // p = a = 0;
    *(int*)&M[ebp-4] = 0; //push p

    // call hanoi(&p,4,1,2,3);
    esp -= 4; *(int*)&M[esp] = 3; // push 3
    esp -= 4; *(int*)&M[esp] = 2; // push 2
    esp -= 4; *(int*)&M[esp] = 1; // push 1
    esp -= 4; *(int*)&M[esp] = 4; // push 4
    eax = ebp-4;
    esp -= 4; *(int*)&M[esp] = eax; // push &p
    eax = (int) && return_to_main;
    esp -= 4; *(int*)&M[esp] = eax; // push return addr
    goto hanoi;

// return from hanoi
return_to_main:
    esp += 20; // clear arguments

    eax = *(int*)&M[ebp-4]; // eax = p
    *(char*)&M[eax] = '\0'; // *p = '\0'

    goto quit; // exit exec()
    /** end of main function **/

    /** hanoi(char ** p, int n, int a, int b, int c) **/
hanoi:
    // Create hanoi's Activation Record
    esp -= 4; *(int*)&M[esp] = ebp; // push ebp
    ebp = esp;

    // if ( n == 0 ) return;
    if (*(int*)&M[ebp+12] != 0) goto skip;
    goto hanoi_end;
    // end if

skip:
    // hanoi(p,n-1,a,c,b);
    eax = *(int*)&M[ebp+20];
    esp -= 4; *(int*)&M[esp] = eax; // push b
    eax = *(int*)&M[ebp+24];
    esp -= 4; *(int*)&M[esp] = eax; // push c
    eax = *(int*)&M[ebp+16];
    esp -= 4; *(int*)&M[esp] = eax; // push a
    eax = *(int*)&M[ebp+12];
    eax--;
    esp -= 4; *(int*)&M[esp] = eax; // push n-1
    eax = *(int*)&M[ebp+8];
    esp -= 4; *(int*)&M[esp] = eax; // push p
    eax = (int) && return_to_hanoi1;
    esp -= 4; *(int*)&M[esp] = eax; // push return addr
    goto hanoi;

return_to_hanoi1:
    esp += 20; //clear arguments

    //**p = '0'+(char)a ;
    eax = *(int*)&M[ebp+8]; // eax = p
    eax = *(int*)&M[eax]; // eax = *p
    ecx = '0';
    ecx += (char) *(int*)&M[ebp+16]; // ecx = 0'+(char)a
    *(char*)&M[eax] = ecx; // **p = ecx

    //(*p) ++ ;
    eax = *(int*)&M[ebp+8]; // eax = p
    *(int*)&M[eax] += 1;

    //**p = ' ' ;
    eax = *(int*)&M[ebp+8]; // eax = p
    eax = *(int*)&M[eax]; // eax = *p
    *(char*)&M[eax] = ' '; // **p = ' '

    //(*p) ++ ;
    eax = *(int*)&M[ebp+8]; // eax = p
    *(int*)&M[eax] += 1;

    //**p = 't' ;
    eax = *(int*)&M[ebp+8]; // eax = p
    eax = *(int*)&M[eax]; // eax = *p
    *(char*)&M[eax] = 't'; // **p = 't'

    //(*p) ++ ;
    eax = *(int*)&M[ebp+8]; // eax = p
    *(int*)&M[eax] += 1;

    //**p = 'o' ;
    eax = *(int*)&M[ebp+8]; // eax = p
    eax = *(int*)&M[eax]; // eax = *p
    *(char*)&M[eax] = 'o'; // **p = 'o'

    //(*p) ++ ;
    eax = *(int*)&M[ebp+8]; // eax = p
    *(int*)&M[eax] += 1;

    //**p = ' ' ;
    eax = *(int*)&M[ebp+8]; // eax = p
    eax = *(int*)&M[eax]; // eax = *p
    *(char*)&M[eax] = ' '; // **p = ' '

    //(*p) ++ ;
    eax = *(int*)&M[ebp+8]; // eax = p
    *(int*)&M[eax] += 1;

    //**p = '0'+(char)b ;
    eax = *(int*)&M[ebp+8]; // eax = p
    eax = *(int*)&M[eax]; // eax = *p
    ecx = '0';
    ecx += (char) *(int*)&M[ebp+20]; // ecx = 0'+(char)b
    *(char*)&M[eax] = ecx; // **p = ecx

    //(*p) ++ ;
    eax = *(int*)&M[ebp+8]; // eax = p
    *(int*)&M[eax] += 1;

    //**p = '\n' ;
    eax = *(int*)&M[ebp+8]; // eax = p
    eax = *(int*)&M[eax]; // eax = *p
    *(char*)&M[eax] = '\n'; // **p = '\n'

    //(*p) ++ ;
    eax = *(int*)&M[ebp+8]; // eax = p
    *(int*)&M[eax] += 1;

    //hanoi(p,n-1,c,b,a) ;
    eax = *(int*)&M[ebp+16];
    esp -= 4; *(int*)&M[esp] = eax; // push a
    eax = *(int*)&M[ebp+20];
    esp -= 4; *(int*)&M[esp] = eax; // push b
    eax = *(int*)&M[ebp+24];
    esp -= 4; *(int*)&M[esp] = eax; // push c
    eax = *(int*)&M[ebp+12];
    eax--;
    esp -= 4; *(int*)&M[esp] = eax; // push n-1
    eax = *(int*)&M[ebp+8];
    esp -= 4; *(int*)&M[esp] = eax; // push p
    eax = (int) && return_to_hanoi2;
    esp -= 4; *(int*)&M[esp] = eax; // push return addr
    goto hanoi;

return_to_hanoi2:
    esp += 20; //clear arguments

hanoi_end:
    ebp = *(int*)&M[esp]; esp += 4 ;
    esp += 4 ; goto **(void**)&M[esp-4] ; // return

quit: {}
}

int main(){
    // initialize
    esp = 10000;
    ebp = 10000;

    // a is a global variable stored in M[0-999]
    char *a = (char*)&M[0];
    exec();
    printf("%s", a);

    return 0;
}
