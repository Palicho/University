#include<stdlib.h>
#include<stdio.h>
#include<time.h>

typedef struct node node;
typedef struct list list;

struct node{
    int key;
    node * next;
};

struct list{
    node * head;
};

list lista;
list lista1;



void insertToList(list * list ,int x){
    
    node * tmp = (node *)malloc(sizeof(node*));
    tmp->key=x;
    
    
    tmp->next=list->head; 
    
    list->head= tmp;
}

void mergeLists(list * list1, list * list2){
    node * tmp;
    tmp=list1->head;
    while(tmp->next!=NULL){
        tmp=tmp->next;
    }
    tmp->next=list2->head;

}

void printList(list list){

    node * tmp=list.head;
    while(tmp!=NULL){
        printf("%d\n", tmp->key);
        tmp= tmp->next;    
    }
    printf("\n");

}

void fillList(list * list, int n){

    for(int i =0; i<n;i++){
        insertToList(list,rand()%1000);
    }
}

node * searchList(list * list, int x){
    node * tmp = list->head;
    while(tmp != NULL && tmp->key != x){
        tmp=tmp->next;
    }

    return tmp;
}


float find(list list, int x, int n){
    clock_t t;
    double result;

    
    t = clock(); 
    for(int i=0;i<n;i++){
        searchList(&list,x);
    }
    t= clock()-t;
    return ((double)(t)/n)/CLOCKS_PER_SEC;
}



int main(){
    insertToList(&lista,10);
    insertToList(&lista,12);
    insertToList(&lista,13);
    fillList(&lista,10);

    fillList(&lista1,10);

    printList(lista);
    printList(lista1);
    
    mergeLists(&lista,&lista1);
    printList(lista);
    return 0;
}