/*
PS101 - Arnold Christopher Koroa - A0092101Y
This program adds all the registers and checks
if it is even or odd by doing a bitwise AND
operation between the sum and 1. This works
because if the sum is odd its least significant
bit is always 1 and if it is even its least
significant bit is always 0.
*/

int eax,ebx,ecx,edx,esi,edi;
unsigned char M[10000];

void exec(){
    eax += ebx;
    eax += ecx;
    eax += edx;
    eax += esi;
    eax += edi;

    eax &= 1;
}
