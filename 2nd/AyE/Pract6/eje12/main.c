#include "qsort.h"
#define tam(a) (sizeof(a)/sizeof(int))




int main(){
	srand(time (NULL));
	int arreglo[10000], llamadas = 0;
	for(int i = 0; i < tam(arreglo); i++){
		arreglo[i] = rand()%10+1;
		}
	
	for(int i = 0; i < tam(arreglo); i++){
		printf("%d ",arreglo[i]);
		}
	puts("");
	qsort2(arreglo,0,tam(arreglo)-1, ULTIMO, &llamadas);
	imprimir_arreglo(arreglo, tam(arreglo));
	}

