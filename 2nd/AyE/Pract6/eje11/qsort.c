#include "qsort.h"

void swap(int* a, int* b){
	int p = *a;
	*a = *b;
	*b = p;
	}



void qsort2(int* arreglo, int start, int end){
	//Caso arreglo de tamano 1
	if(start >= end)return;
	int media =(end-start+1)/2, pivot = arreglo[media], i = start, j = end, ordenado = 0, k;
	printf("%d",pivot);
	printf("\n");
	int* menor,*mayor;
	while(!ordenado){
		menor = NULL, mayor = NULL;
		//Busqueda arreglo izq
		for( k = i; k < media && !(arreglo[k] > pivot) ;k++);
		if(k < media){
			mayor = &arreglo[k];
		   }
		//Busqueda arreglo der
		for(k = j;k > media && !(arreglo[k] < pivot); k--);
	    if(k > media){
			menor = &arreglo[k];
		  }
	    
		//Si el menor es distinto al mayor intercambiar
		if(menor != mayor){
			if(!menor && mayor!= NULL){
				if(mayor != arreglo+media-1)swap(mayor,arreglo+media-1);
				swap(arreglo+media-1,arreglo+media);
				media--;			
				}
			else if(!mayor && menor != NULL){
				if(menor != arreglo+media+1)swap(menor,arreglo+media+1);
				swap(arreglo+media+1,arreglo+media);
				media++;
				}
			else{
				 swap(menor, mayor);
				 i++,j--;
			    }
		   }
		//Si en ambas busquedas se llega al pivote el arreglo está ordenado
		else ordenado = 1;
	}
	//printf("%d %d\n",start,media-1);
	//Ordenar arreglo izq
	//qsort2(arreglo,start,media-1);
	//Ordenar arreglo der
	//qsort2(arreglo,media+1,end);
	
  }
  
  

