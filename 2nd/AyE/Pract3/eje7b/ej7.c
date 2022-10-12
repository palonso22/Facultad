#include "ej7.h"
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <assert.h>

int comparar(int a,int b){
	return a>=b;
	}



int aux_retornar_pos(int arreglo[], int dato,int p){
	//inicializar el i en la pos
	// del primer padre
	int i = (p - 1) / 2;
	//iterar hasta llegar a la raiz o hasta encontrar un padre
	//mayor al dato
	for ( ; i != 0 && comparar(arreglo[i],dato); p = i, i = (i - 1) / 2)
		;
	//Si llega a la raiz y es la raiz es mayor
	//que el dato pasar la pos de la raiz
	if (!i && comparar(arreglo[i], dato))
		return 0;
	//Sino pasar la pos actual
	return p;
	}
	
void aux_mover_arreglo(int arreglo[],int pos,int nelemts){
	for(int i=pos,k=0;i<nelemts;i++,k++){
		arreglo[nelemts-k]=arreglo[nelemts-(1+k)];
		}
	}


BHeap bheap_crear(){
	BHeap h=malloc(sizeof(struct _BHeap));
	h->nelemts=0;
	return h;
	}
	
int bheap_es_vacio(BHeap h){
	return h->nelemts==0;
	}
	
void bheap_insertar(BHeap h, int dato){
	//Si el heap es vacio
	if(!h->nelemts){
		h->datos[0]=dato;
		++h->nelemts;
		return;
	}
	//Comprobar que ahi lugar para un nuevo dato
	//Agregamos el dato al final del heap
	h->datos[h->nelemts]=dato;
	h->nelemts++;
	//Buscar que posicion le corresponde en el heap
	//De no tener que moverlo se quedaria en el lugar que ya le dimos
	int pos=aux_retornar_pos(h->datos,dato,h->nelemts);
	//Sino reacomodar el heap, ingresar el dato en el lugar que 
	//le corresponde 
	aux_mover_arreglo(h->datos,pos,h->nelemts);
	h->datos[pos]=dato;
	}

void bheap_imprimir(BHeap h){
	if(!h->nelemts){printf("vacio\n");return;}
	for(int i=0,k=1;i<h->nelemts;i++){
		printf("%d ",h->datos[i]);
		if(i+2==pow(2,k)){printf("\n");++k;}
		}
	printf("\n");
	}
	

/*void bheap_eliminar_minimo(BHeap h){
	if(!h->nelemts){printf("esta vacio");return;}
	
	
	}*/

void bheap_destruir(BHeap h){
	free(h);
	}

void aux_mover_arreglo_adelante(int arreglo[],int nelemts){
	for(int i=0;i<nelemts;i++){
		arreglo[i]=arreglo[i+1];
		}
	}


void bheap_eliminar_minimo(BHeap h){
	if(!h->nelemts)return;
	h->nelemts--;
	aux_mover_arreglo_adelante(h->datos,h->nelemts);
	}


