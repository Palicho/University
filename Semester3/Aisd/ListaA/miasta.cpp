#include <stdio.h>
#include <cstring>
#include <queue>

#define N_MAX 2002
#define M_MAX 2002

using namespace std;



char tab[N_MAX][M_MAX];

void fill_tab(){
    for(int i= 0;i<N_MAX;i++)
    {
        for(int j= 0; j<M_MAX;j++){
            tab[i][j]='A';
        }
    }
}

void bfs(int i, int j){
    queue<int> qi;
    queue<int> qj;

    qi.push(i);
    qj.push(j);

    char sign;

    while(!qi.empty()){
        int i = qi.front();
        int j = qj.front();

        qi.pop();
        qj.pop();
        char s = tab[i][j]; 
        tab[i][j]='A';

        switch (s)
        {
        case 'B':
            //down
            sign=tab[i+1][j];
            if(sign =='C' || sign =='D' || sign =='F'){
                qi.push(i+1);
                qj.push(j);
            }

            //left
            sign=tab[i][j-1];
            if(sign=='D' || sign=='E' || sign=='F'){
                qi.push(i);
                qj.push(j-1);
            }

            break;
        

        case 'C':

            //up
            sign=tab[i-1][j];
            if(sign =='B' || sign =='E' || sign =='F'){
                qi.push(i-1);
                qj.push(j);
            }

            //left
            sign=tab[i][j-1];
            if(sign=='D' || sign=='E' || sign=='F'){
                qi.push(i);
                qj.push(j-1);
            }

            break;
        

        case 'D':
            //up
            sign=tab[i-1][j];
            if(sign =='B' || sign =='E' || sign =='F'){
                qi.push(i-1);
                qj.push(j);
            }

            //right
            sign=tab[i][j+1];
            if(sign=='B' || sign=='C' || sign=='F'){
                qi.push(i);
                qj.push(j+1);
            }        
            break;
        

        case 'E':
            
            //down
            sign=tab[i+1][j];
            if(sign =='C' || sign =='D' || sign =='F'){
                qi.push(i+1);
                qj.push(j);
            }

            //right
            sign=tab[i][j+1];
            if(sign=='B' || sign=='C' || sign=='F'){
                qi.push(i);
                qj.push(j+1);
            }        
        
            break;
        

        case 'F':

            //up
            sign=tab[i-1][j];
            if(sign =='B' || sign =='E' || sign =='F'){
                qi.push(i-1);
                qj.push(j);
            }

            //down
            sign=tab[i+1][j];
            if(sign =='C' || sign =='D'|| sign =='F' ){
                qi.push(i+1);
                qj.push(j);
            }

            //left
            sign=tab[i][j-1];
            if(sign=='D' || sign=='E' || sign =='F'){
                qi.push(i);
                qj.push(j-1);            }

            //right
            sign=tab[i][j+1];
            if(sign=='B' || sign=='C' || sign =='F' ){
                qi.push(i);
                qj.push(j+1);            }       
            break;
        
        default:
            break;
        }

    }
}

void dfs(int i, int j, char s){
    char sign;

    tab[i][j]='A';
    switch (s)
    {
    case 'B':
        //down
        sign=tab[i+1][j];
        if(sign =='C' || sign =='D' || sign =='F'){
            dfs(i+1,j,sign);
        }

        //left
        sign=tab[i][j-1];
        if(sign=='D' || sign=='E' || sign=='F'){
            dfs(i,j-1,sign);
        }

        break;
    

    case 'C':

        //up
        sign=tab[i-1][j];
        if(sign =='B' || sign =='E' || sign =='F'){
            dfs(i-1,j,sign);
        }

        //left
        sign=tab[i][j-1];
        if(sign=='D' || sign=='E' || sign=='F'){
            dfs(i,j-1,sign);
        }

        break;
    

    case 'D':
        //up
        sign=tab[i-1][j];
        if(sign =='B' || sign =='E' || sign =='F'){
            dfs(i-1,j,sign);
        }

        //right
        sign=tab[i][j+1];
        if(sign=='B' || sign=='C' || sign=='F'){
            dfs(i,j+1,sign);
        }        
        break;
    

    case 'E':
        
        //down
        sign=tab[i+1][j];
        if(sign =='C' || sign =='D' || sign =='F'){
            dfs(i+1,j,sign);
        }

        //right
        sign=tab[i][j+1];
        if(sign=='B' || sign=='C' || sign=='F'){
            dfs(i,j+1,sign);
        }        break;
    
        break;
    

    case 'F':

        //up
        sign=tab[i-1][j];
        if(sign =='B' || sign =='E' || sign =='F'){
            dfs(i-1,j,sign);
        }

        //down
        sign=tab[i+1][j];
        if(sign =='C' || sign =='D'|| sign =='F' ){
            dfs(i+1,j,sign);
        }

        //left
        sign=tab[i][j-1];
        if(sign=='D' || sign=='E' || sign =='F'){
            dfs(i,j-1,sign);
        }

        //right
        sign=tab[i][j+1];
        if(sign=='B' || sign=='C' || sign =='F' ){
            dfs(i,j+1,sign);
        }       
        break;
    
    default:
        break;
    }

}

int count_towns(){
    int towns = 0;
    for(int i = 1; i<N_MAX-1;i++)
    {
        for(int j = 1; j<M_MAX-1; j++){
            char s = tab[i][j];
            if(s != 'A'){
                towns++;
                bfs(i,j);
            }
        }

    }

    return towns;
}

int main(){
    int n,m;
    scanf("%d %d",&n,&m);
    fill_tab();
    for(int i= 1;i<n+1;i++)
    {
        scanf("%*d");
        fgets(tab[i]+1,m+1,stdin);
        tab[i][m+1]='A';
    }
    printf("%d", count_towns());
}