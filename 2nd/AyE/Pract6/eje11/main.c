#include "qsort.h"
#define tam(a) (sizeof(a)/sizeof(int))




int main(){
	srand(time (NULL));
	int arreglo[5];
	/*for(int i = 0; i < 5; i++){
		arreglo[i] = rand()%10+1;
		}*/
	arreglo[0] = 9;
	arreglo[1] = 6;
	arreglo[2] = 5;
	arreglo[3] = 8;
	arreglo[4] = 6;
	
	for(int i = 0; i < 5; i++){
		printf("%d ",arreglo[i]);
		}
	puts("");
	qsort2(arreglo,0,tam(arreglo)-1);
	imprimir_arreglo(arreglo);
	}

