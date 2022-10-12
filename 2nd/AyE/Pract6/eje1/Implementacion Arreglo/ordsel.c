#include "ordsel.h"


void swap(int* a, int* b){
	int aux = *a;
	*a = *b;
	*b = aux;
	}


void select_sort(int arreglo[], int tam){
	if(tam == 0)return;
	int k = tam;
	while(k > 1){
		int i = 0;//arreglo[i] es el mayor por ahora
		for(int j = 1; j < k-1; j++){
			if(arreglo[j] > arreglo[i]) i = j;//Guardar la posicion
			}
		swap(arreglo + i, arreglo + (k-1));
		k--;
		}
	  }
