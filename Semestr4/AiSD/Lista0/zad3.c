#include<stdlib.h>
#include<stdio.h>
#include<time.h>

typedef struct node node;
typedef struct list list;

struct node{
    int key;
    node * prev;
    node * next;
};

struct list{
    node * null;
};

list lista;
list lista1;

void insertToList(list * list ,int x){
    
    node * tmp = (node *)malloc(sizeof(node*));
    tmp->key=x;
    tmp->next=list->null->next;
    tmp->prev= list->null;
    list->null->next->prev=tmp; 
    list->null->next= tmp;
}

list createList(){
    list list;
    list.null= (node *)malloc(sizeof(node*));
    list.null->next=list.null;
    list.null->prev= list.null;
    return list;
}


void mergeLists(list * list1, list * list2){
    list1->null->prev->next=list2->null->next;
    list2->null->next->prev=list1->null->prev->next;

    list1->null->prev=list2->null->prev;
    list2->null->prev->next=list1->null;
    free(list2->null);
}

void printList(list list){

    node * tmp=list.null->next;
    while(tmp!=list.null){
        printf("%d\n", tmp->key);
        tmp= tmp->next;    
    }
    printf("\n");

}


void printListPrev(list list){

    node * tmp=list.null->prev;
    while(tmp!=list.null){
        printf("%d\n", tmp->key);
        tmp= tmp->prev;    
    }
    printf("\n");

}

void fillList(list * list, int n){

    for(int i =0; i<n;i++){
        insertToList(list,rand()%1000);
    }
}

node * searchList(list * list, int x){
    node * tmp = list->null->next;
    while(tmp != list->null && tmp->key != x){
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


void freeList(list * list){
    node * tmp = list->null->next;
    while(tmp != list->null){
        tmp=tmp->next;
        free(tmp->prev);
    }
    free(tmp);
    free(list);
}



int main(){
    lista= createList();
    lista1= createList();

    //insterting and merging
    insertToList(&lista,3);
    insertToList(&lista,2);
    insertToList(&lista,1);

    insertToList(&lista1,6);
    insertToList(&lista1,5);
    insertToList(&lista1,4);

    
    printList(lista);;
    printList(lista1);

    mergeLists(&lista, &lista1);
    printList(lista);
    freeList(&lista);
    
    freeList(&lista);
    
    /* 
    fillList(&lista,1000);
    printList(lista);


    printf("%f \n", find(lista,6,1000));
    printf("%f \n", find(lista,45,1000));
    */

    return 0;
}