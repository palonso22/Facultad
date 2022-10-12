#include "isort.h"
#define tam(a) (sizeof(a)/sizeof(int))








int main(){
	srand(time(NULL));
	int arr[2000];
	for(int i = 0; i < 2000; i++){
		arr[i] =rand()%50+1;
		}
	isort(arr, tam(arr));
	printf("\n");
	imprimir_arreglo(arr,tam(arr));
	
	
	}
