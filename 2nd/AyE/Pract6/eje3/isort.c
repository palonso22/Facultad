#include "isort.h"


void swap(int* a,int* b){
	int aux = *a;
	*a = *b;
	*b = aux;
	}


void imprimir_arreglo(int arreglo[],int tam){
	for(int i = 0; i < tam;i++){
		printf(" %d",arreglo[i]);
		}
	printf("\n");
	}

void isort(int arreglo[], int tam){
	if(tam < 2)return ;
	int k = 1, j, t;
	for(; k < tam ; k++){
		t = k;
		j = t-1;
		while(t > 0 && arreglo[t] < arreglo[j]){
			swap(arreglo + t, arreglo + j);
			t--, j = t-1 ;
			}
		}
	}
