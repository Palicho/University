#include <stdio.h>

int main(){
    for(int i =0; i<256; i++)
    {
        printf("\33[38;5;%dmHello World \n", i );
    }
    printf("\33[0m");
};
