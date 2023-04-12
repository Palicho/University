//rozkład liczb na czynniki pierwsze

#include<iostream>
#include<vector>
#include<math.h>

using namespace std;


vector<int64_t> rozklad(int64_t number){
    
    vector<int64_t> vect;
    
    if ( number == -1 || number == 1 || number == 0){
        vect.push_back(number);
        return vect;
    }

    if(number ==INT64_MIN){
        vect.push_back(-1);
        vect.push_back(2);
        number /= 2;
        number *=-1;

    }

    if( number<0){
        vect.push_back(-1);
        number *=-1;
    }
    int64_t i = 2;
    while(i*i<= number){
        while(number % i == 0){
            vect.push_back(i);
            number /= i;
        }
        i++;
    }

    if(number != 1){
        vect.push_back(number);

    }
    return vect;
}

void display_factors(int64_t number,vector<int64_t> v){

    int size = v.size();
    cout<<number<<" = ";
    for ( int i=0;i<size-1;i++){
        cout<<v[i]<<'*';
    }

    cout<<v[size-1]<<endl;;
}



int main(int argc, char const *argv[])
{

    if(argc == 1){
        cerr<<"brak argumentów"<<endl;
        return -1;
        
    } else{
        for(int i=1;i<argc;i++){
            try
            {
                int64_t tmp_number= stoll(argv[i]);
                display_factors(tmp_number,rozklad(tmp_number));            
            }
            catch(const std::invalid_argument& e)
            {
                std::cerr <<"zły argument: "<< e.what() << '\n';
            }
            
        }
    }


    return 0;
}