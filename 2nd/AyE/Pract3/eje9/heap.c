#include "heap.h"
void aux_hundir(Heap, int );

void swap(int* a,int* b){
	int p = *a;
	*a = *b;
	*b = p;
	}



Heap heap_crear(){
	Heap h = malloc(sizeof(struct _Heap));
	h->nelemts = 0;
	return h;
	}


int heap_vacio(Heap h){
	return h->nelemts == 0;
	}


void aux_flotar(int* arreglo, int pos){
	if(pos == 0)return;
	//Pos del padre
	int i = (pos-1)/2;
	if(arreglo[pos] < arreglo[i]){
		swap(arreglo+pos,arreglo+i);
		aux_flotar(arreglo, i);
		}
	}



void heap_agregar(Heap h, int dato){
	if(heap_vacio(h)){
		h->nelemts++;
		h->datos[0] = dato;
		return;
		}
	h->nelemts++;
	assert(h->nelemts < MAX);
	h->datos[h->nelemts-1] = dato;
	aux_flotar(h->datos,h->nelemts-1);
	}


void hundir_rutina(Heap h,int posA,int posB ){
	int* arreglo = h->datos;
	swap(arreglo+posA,arreglo+posB);
		//Comparar el nuevo padre con el otro hijo
		aux_hundir(h,posA);
		//Comparar el nuevo hijo con el resto de descendientes
		aux_hundir(h,posB);
	}


void aux_hundir(Heap h, int pos){
	//Calcular la pos de sus hijos
	int childLeft = 2*pos+1,childRight = 2*pos+2, *arreglo = h->datos;;
	//Comprobar si tienes hijos y hacer el intercambio
	if(childLeft < h->nelemts && arreglo[pos] > arreglo[childLeft])
		hundir_rutina(h,pos,childLeft);
	else if(childLeft < h->nelemts && arreglo[pos] > arreglo[childRight])
		hundir_rutina(h,pos,childRight);
	}



void heap_eliminar_minimo(Heap h){
	assert(!heap_vacio(h));
	h->nelemts--;
	h->datos[0] = h->datos[h->nelemts];
	aux_hundir(h,0);
	
	}

Heap heapify(int* arreglo,size_t tamanio){
	Heap h = heap_crear();
	int i = 0;
	while(tamanio > 0){
		heap_agregar(h,arreglo[i]);
		tamanio--, i++;
		}
	}



void heap_imprimir(Heap h){
	for(int i = 0, k = 1;i < h->nelemts;i++){
		printf("%d ",h->datos[i]);
		if(i+2 == pow(2,k))puts(""),k++;
		}
	}

void heap_destruir(Heap h){
	free(h);
	}


Heap bheap_merge(Heap heap1, Heap heap2){
	assert(heap1->nelemts+heap2->nelemts < MAX);
	while(!heap_vacio(heap2)){
		heap_agregar(heap1,heap_minimo(heap2));
		heap_eliminar_minimo(heap2);
		}
	}


