#include "ordsel.h"
#define NELEMENS(a) (sizeof(a)/sizeof(int))




int main(){
	int arreglo[] = { 2, 4, 1, 3, 7, 8, 6 }, i;
	select_sort(arreglo, NELEMENS(arreglo));
	for(i = 0; i < NELEMENS(arreglo); i++){
		printf("%d ",arreglo[i]);
		}
	
	
	}
