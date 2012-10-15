/*
PS104 - Arnold Christopher Koroa - A0092101Y

This programs saves the first N primes to M[0]-M[N*4]

This solution was worked out first using C which was then translated
into VAL. The original C program is attached as comment below.

This solution checks all odd number X starting from 3 for primality
by checking its divisibility by any other odd number Y where Y^2 <= X.
This method is actually the Sieve of Eratosthenes algorithm.
*/

int eax,ebx,ecx,edx,esi,edi;
unsigned char M[10000]={""}; //initialize M[] to 0 for testing

//the argument N is at ecx
//ecx is used as a counter for number of primes needed
void exec(){
    edi = 0;        //current memory index for store

    //if N==0, exit
    if(ecx<1) goto end_outer_loop;

    //inserts 2 to M[0]
    *(int*)&M[edi] = 2;
    ecx -= 1;

    //checks odd number starting from 3 for primality
    eax = 3;        //outer loop iterator
    outer_loop:
        if(ecx<=0) goto end_outer_loop;

        edx = 1;    //flag for primality test
        ebx = 3;    //inner loop iterator
        inner_loop:
            if(ebx>=eax) goto end_inner_loop;

            //if not prime: set flag, exit inner loop
            esi = eax;
            esi %= ebx;
            if(esi!=0) goto end_if;
                edx = 0;
                goto end_inner_loop;
            end_if:

            ebx += 2;
            goto inner_loop;
        end_inner_loop:

        //if prime: store to memory
        if(edx == 0) goto end_if2;
            //store prime to memory
            edi+=4;
            *(int*)&M[edi] = eax;

            //decrement number of prime needed
            ecx -= 1;
        end_if2:

        eax += 2;
        goto outer_loop;
    end_outer_loop: {}
}

/* The original C program snippet
 * This program prints the prime instead of saving it to M[]

    printf("2 ");
    count = 1;
    for(i=3;count<N;i+=2){
        flag = 1;
        for(j=3;(j*j)<=i;j+=2){
            if(i%j==0){
                flag = 0;
                break;
            }
        }
        if(flag){
            printf ("%d ", i);
			count++;
        }
    }

 * The same program using while and goto to ease translation to VAL

    printf("2 ");
    count = 1;
    i=3;
    while(count<N){
        flag=1;
        j=3;
        while((j*j)<=i){
            if(i%j==0){
                flag = 0;
                break;
            }
            j+=2;
        }
        if(flag){
            printf ("%d ", i);
            count++;
        }

        i+=2;
    }
*/
