#include <stdio.h>
#include <stdint.h>

const char* binary_representation(uint32_t){
    char * binary = (char *)malloc(32 * sizeof(char));
    for(int i=0;i<32;i++){

    }

}

uint32_t zero_in_postion_k(uint32_t x,int k){
    uint32_t mask=1;
    mask=mask<<k;
    mask=~mask;
    return (mask & x);
}

uint32_t one_in_postion_k(uint32_t x,int k){
    uint32_t mask=1;
    mask=mask<<k;
    mask=~mask;
    return (mask | x);
}

uint32_t negate_k(uint32_t x, int k){
    uint32_t mask=1;
    mask=mask<<k;
    return(x ^ mask);
}


int main(){
    uint32_t x,k;
    printf("Podaj x: ");
    scanf("%d", &x);
    printf("Podaj k:");
    scanf("%d",&k);

    printf("%d",zero_k(x,1));
    
    return 0;
}