// Konrad Oleksy
#include "stdio.h"
#include <set>
#include <map>


using namespace std;
int n, m, t;

#define MAX_N 500001

int row[MAX_N];
int col[MAX_N];
int paths[MAX_N];

int binary_search(int b, int e, int r , int c);

struct node
{
    int x;
    int y;
};

class edge
{
public:
    node b;
    node e;
    edge(int bx, int by, int ex, int ey );
    friend bool operator<(const edge &left, const edge &right);
};

edge::edge(int bx, int by, int ex, int ey ){
    b={bx,by};
    e={ex,ey};
}

bool operator<(const edge &left, const edge &right){
    if(left.e.x == right.e.x){
        if(left.e.y == right.e.y){
            if(left.b.x == right.b.x){
                return left.b.y < right.b.y;
            }
            return left.b.x < right.b.x;
        }
        else{
            return left.e.y < right.e.y;
        }
    }
    else{
        return left.e.x < right.e.x;
    }
}

map<node,int> mapa;

int main()
{
    scanf("%d %d %d", &n, &m, &t);
    set<edge> edges;
    int bx, by, ex, ey;
    for (int i = 0; i < t; i++)
    {
        scanf("%d %d %d %d", &bx, &by, &ex, &ey);
        edge tmp=edge(bx,by,ex,ey);
        edges.insert(tmp);
    }

    row[0]=0;
    col[0]=0;
    paths[0]=1;
    int end=0;
    int sid;
    for (const edge &e: edges ){
        if(row[end]!=e.e.x || col[end]!=e.e.y){

            end+=1;
            row[end]=e.e.x;
            col[end]=e.e.y;
            paths[end]=0;
        }

        sid=binary_search(0,end,e.b.x,e.b.y);
        if(sid!=-1){
            paths[end]= (paths[end]+paths[sid])%999979;
        }
    }
    if(row[end]==n && col[end]==m){
        printf("%d",paths[end]);
    }else{
        printf("%d",0);
    }

    return 0;
}

int binary_search(int b, int e, int r , int c){
    if( b > e ){
        return -1;
    }

    int mid= (b+e)/2;
    
    if(row[mid]> r){
        return binary_search(b, mid-1, r,c);
    }
    if(row[mid]< r){
        return binary_search(mid+1, e, r, c);
    }
    
    if(col[mid]> c){
        return binary_search(b, mid-1, r, c);
    }
    if(col[mid]< c){
        return binary_search(mid+1,e, r,c);
    }

    return mid;
}

