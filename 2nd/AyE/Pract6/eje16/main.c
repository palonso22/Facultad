#include "msort.h"
#define tam(a)(sizeof(a)/sizeof(int))

int main(){
	srand(time(NULL));
	int array[9];
	for(int i = 0;i < tam(array);++i){
		array[i] = rand()%15+1;
		}
	array_imprimir(array,0,tam(array));
	msort(array,0,tam(array)-1);
	array_imprimir(array,0,tam(array));
	
	}
