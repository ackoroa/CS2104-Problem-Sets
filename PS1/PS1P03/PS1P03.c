/* PS103 - Arnold Christopher Koroa - A0092101Y */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#define MAX_N_VARS 1000             //maximum number of variables
#define MAX_VAR_IDENT_LENGTH 100    //maximum length of variable name
#define MAX_INST_LENGTH 100000      //maximum total length of all instructions

void readVariable(char curr_var[]);
int isOperator(char c);
void readOperator(char* curr_operator);
void readOperand(char curr_operand[]);
void compute(char curr_var[], char curr_operator, char curr_operand[]);
int findVarIdx(char curr_var[]);
int findValue(char curr_operand[]);
void printVars();
int nVar();

/*global variables declaration*/
char inst[MAX_INST_LENGTH];                         //input instructions string
char vars_ident[MAX_N_VARS][MAX_VAR_IDENT_LENGTH];  //variable name array
int vars_value[MAX_N_VARS]={0};                     //variable value array
int instIndex;                                      //index for reading the instruction string

//all input instructions are assumed to be valid.
//i.e. sytactically correct and no illegal operations
//(e.g. division by zero)
//variables may not start with digits
//variables are assumed to be integers
int main(){
    char curr_var[MAX_VAR_IDENT_LENGTH];
    char curr_operator;
    char curr_operand[MAX_VAR_IDENT_LENGTH];

    /*Input from file for testing purposes
    FILE *fin;
    if( (fin = fopen("in.txt","r")) == NULL){
        printf("file not found\n");
        exit(1);
    }
    fscanf(fin,"%s",inst);
    */

    /*input from keyboard*/
    scanf("%s",inst);
    /**/

    instIndex = 0;
    int instLen = strlen(inst)-1;

    while(instIndex<instLen){
        readVariable(curr_var);
        readOperator(&curr_operator);
        readOperand(curr_operand);
        compute(curr_var, curr_operator, curr_operand);
    }

    printVars();

    return 0;
}

//reads variable name from instruction and store in curr_var
//instruction Index is placed at the start of operator
void readVariable(char curr_var[]){
    int i=0;
    while(!isOperator(inst[instIndex])){
        curr_var[i] = inst[instIndex];
        i++; instIndex++;
    }
    curr_var[i] = '\0';
}

//checks if a character is a valid operator (+-*/)
int isOperator(char c){
    if(c == '+' || c == '-' || c == '*' || c == '/')
        return 1;
    return 0;
}

//reads operator from instruction and store in curr_operator
//instruction Index is placed at the start of operand
void readOperator(char* curr_operator){
    *curr_operator = inst[instIndex];
    instIndex++;
    instIndex++;
}

//reads operand from instruction and store in curr_operand
//instruction Index is placed at the start of next instruction
void readOperand(char curr_operand[]){
    int i=0;
    while(inst[instIndex] != ';'){
        curr_operand[i] = inst[instIndex];
        i++; instIndex++;
    }
    instIndex++;
    curr_operand[i] = '\0';
}

//computes operation specified by curr_var, curr_operator and curr_operand
//and stres the result accordingly
void compute(char curr_var[], char curr_operator, char curr_operand[]){
    int varIdx;
    int operandValue;

    varIdx = findVarIdx(curr_var);
    operandValue = findValue(curr_operand);

    switch(curr_operator){
        case '+':
            vars_value[varIdx] += operandValue;
            break;
        case '-':
            vars_value[varIdx] -= operandValue;
            break;
        case '*':
            vars_value[varIdx] *= operandValue;
            break;
        case '/':
            vars_value[varIdx] /= operandValue;
            break;
    }
}

//search for curr_var in the variable array and returns its index
//if curr_var is not in the array yet, insert curr_var to the array
int findVarIdx(char curr_var[]){
    int i,idx=-1;
    for(i=0;i<nVar();i++){
        if(strcmp(curr_var,vars_ident[i])==0){
            idx = i;
            break;
        }
    }
    //if curr_var not in array, add
    if(idx==-1){
        idx = nVar();
        strcpy(vars_ident[idx],curr_var);
    }

    return idx;
}

//parses and returns the integer value of the operand
int findValue(char curr_operand[]){
    int val,idx;

    //if operand is a constant
    if(isdigit(curr_operand[0])){
        val = atoi(curr_operand);
    }
    //if operand is a variable
    else{
        idx = findVarIdx(curr_operand);
        val = vars_value[idx];
    }

    return val;
}

//prints all variables and their values
void printVars(){
    int i=0;
    while(i < nVar()){
        printf("%s = %d\n", vars_ident[i],vars_value[i]);
        i++;
    }
}

//counts the number of variables in the variables array
int nVar(){
    int n=0;
    while(vars_ident[n][0] != '\0') n++;

    return n;
}
