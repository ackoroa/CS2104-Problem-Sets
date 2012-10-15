/*
PS102 - Arnold Christopher Koroa - A0092101Y
This programs takes a string fof digits and converts it into an integer.
It is done by converting each character from left to right from char to int
by treating it as integer and subtracting the ASCII code of '0' from it.
The current sum is multiplied by ten and then the next digit added in every
time the next character is read.
*/

int eax,ebx,ecx,edx,esi,edi;
unsigned char M[10000];

//address of the array is stored at esi
void exec(){
    eax = 0;

    loop:
        ebx = *(char*)&M[esi];
        if(ebx==0) goto end; // ebx==0 -> end of string null character is read
        ebx -= 0x30; // ASCII for '0' == 0x30
        eax *= 10;
        eax += ebx;
        esi += 1;
        goto loop;
    end:{}
}
