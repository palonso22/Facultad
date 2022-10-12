#include "msort.h"


void swap(int* a,int* b){
	int aux = *a;
	*a = *b;
	*b = aux;
	}
 
void array_mezclar(int* array,int izq, int der){
	int tam = der-izq+1;
	if(tam < 2)return ;
	int k = izq, j, t;
	for(; k < tam ; k++){
		t = k;
		j = t-1;
		while(t > 0 && array[t] < array[j]){
			swap(array + t, array + j);
			t--, j = t-1 ;
			}
		}
	}




void msort(int* array,int izq,int der){
	if(izq >= der)return;
	int media = (izq+der)/2;
	msort(array,izq,media);
	msort(array,media+1,der);
	array_mezclar(array,izq,der);
	return; 
	}



void array_imprimir(int* arreglo,int izq, int tam){
	for(int i = izq;i < izq+tam;i++)
		printf("%d ",arreglo[i]);
	puts("");
	}
