/*
PS105 - Arnold Christopher Koroa - A0092101Y
*/

int eax,ebx,ecx,edx,esi,edi;
unsigned char M[10000];

//the address of head of list initially in esi
void exec(){
    eax = 0;
    loop:
        if(esi==0) goto end;    //end of list
        eax += *(int*)&M[esi];
        esi += 4;               //esi points to the next pointer
        esi = *(int*)&M[esi];   //esi points to next element
        goto loop;
    end:{}
}
