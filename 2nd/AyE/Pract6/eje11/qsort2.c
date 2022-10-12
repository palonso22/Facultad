#include "qsort.h"

void swap(int* a, int* b){
	int p = *a;
	*a = *b;
	*b = p;
	}




void qsort3(int* arreglo, int lim_izq, int lim_der){
	int izq,der,temp, pivote;
	izq = lim_izq;
	der = lim_der;
	pivote = arreglo[(izq+der)/2];
	
	do{
		while(arreglo[izq] < pivote && izq < lim_der)izq++;
		while(arreglo[der] > pivote && der > lim_izq)der--;
		if(izq <= der){
			swap(arreglo+izq,arreglo+der);
			izq++,der--;
			}
		}while(izq <= der);
	if(izq < lim_der)qsort3(arreglo,izq,lim_der);
	if(der > lim_izq)qsort3(arreglo,lim_izq,der);
	}



void imprimir_arreglo(int* arreglo){
	for(int i = 0; i < 5; i++){
		printf("%d ",arreglo[i]);
		}	
	}
   
