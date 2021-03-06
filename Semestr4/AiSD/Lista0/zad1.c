#include<stdlib.h>
#include<stdio.h>
#define MAX 100

typedef struct queue queue;

struct queue{
    int head;
    int tail;
    int * array;
    int lenght;
};

queue createQueue(int n){
    queue tmp;
    tmp.array= (int *)malloc(sizeof(int *)*n);
    tmp.head=0;
    tmp.tail=0;
    tmp.lenght=n;
}

void enqueue(queue queue, int x){
    queue.array=x;
    if( queue.tail == queue.lenght){
        queue.tail=0;
    }
    else{
        queue.tail+=1;
    }
}


int dequeue(queue queue){
    int x= queue.array[queue.head];
    if(queue.head == queue.lenght){
        queue.head = 0;
    }
    else{
        queue.head += 1;
    }

    return x;
}

void print(queue queue){
    for(int i =0; i<queue.lenght;i++){
        printf("%d ", queue.array[i]);
    }
    printf("\n ");
    
}

int main(){
    queue queue = createQueue(5);
    enqueue(queue,3);
    print(queue);
    return 0;
}



