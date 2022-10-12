#include "qsort.h"


void swap(int* a, int* b){
	int p = *a;
	*a = *b;
	*b = p;
	}





int aux_pivote(int* arreglo,int izq, int der, Pivot tipo){
	int pos;
	if(tipo == RAMDON)pos =izq+rand()%(der-izq)+1; 
	else if(tipo == ULTIMO)pos = der;
	else if(tipo == MEDIO) pos = (izq+der)/2;
	else if(tipo == MEDIANA){
		int media =(izq+der)/2;
		if(arreglo[izq] >=arreglo[media]  && arreglo[izq] <= arreglo[der]) return izq;
		if(arreglo[der] >=arreglo[media]  && arreglo[der] <= arreglo[izq]) return der;
		return media;
		
		}
	}


void qsort2(int* arreglo, int lim_izq, int lim_der, Pivot tipo, int* llamadas){
	int izq,der,temp, pivote, posPivote = aux_pivote(arreglo,lim_izq,lim_der,tipo);
	izq = lim_izq;
	der = lim_der;
	pivote = arreglo[posPivote];
	*(llamadas)+=1;
	printf("%d pp \n",*llamadas);
	
	do{
		while(arreglo[izq] < pivote && izq < lim_der)izq++;
		while(arreglo[der] > pivote && der > lim_izq)der--;
		if(izq <= der){
			swap(arreglo+izq,arreglo+der);
			izq++,der--;
			}
		}while(izq <= der);
	if(izq < lim_der)qsort2(arreglo,izq,lim_der, tipo, llamadas);
	if(der > lim_izq)qsort2(arreglo,lim_izq,der, tipo, llamadas);
	}



void imprimir_arreglo(int* arreglo, int tam){
	for(int i = 0; i < tam; i++){
		printf("%d ",arreglo[i]);
		}	
	}
   
