#include "hsort.h"


//Rutina para intercambiar dos eltos del arreglo
void swap(int* a, int* b){
	int c = *a;
	*a = *b;
	*b = c;
	}


/**Funciones basicas para heap**/
//Rutina para aux_hundir
/*void rutina_hundir(Heap, int, int);


Heap heap_crear(size_t tam){
	Heap h;
	h = malloc(sizeof(struct _Heap));
	h->datos = malloc(sizeof(int)*tam);
	h->nelements = 0;
	h->tam = tam; 
	return h;
	}

int heap_vacio(Heap h){
	return h->nelements == 0;
	}

void aux_flotar(Heap h, int pos){
	if(pos == 0)return;
	//Pos del padre
	int i = (pos-1)/2;
	if(h->datos[pos] < h->datos[i]){
		swap(&h->datos[pos], &h->datos[i]);
		aux_flotar(h,i);
	}
 }



void heap_agregar(Heap h, int dato){
	if(heap_vacio(h)){
		h->nelements++;
		h->datos[0] = dato;
		return;
		}
	h->nelements++;
	assert(h->nelements <= h->tam);
	h->datos[h->nelements-1] = dato;
	aux_flotar(h,h->nelements-1); 
	}


void aux_hundir(Heap h, int pos){
	int childLeft = pos*2+1, childRight = pos*2+2;
	if(childLeft < h->nelements && h->datos[pos] > h->datos[childLeft])
		rutina_hundir(h,pos,childLeft);
	else if(childRight < h->nelements && h->datos[pos] > h->datos[childRight])
		rutina_hundir(h,pos,childRight);
	}

void rutina_hundir(Heap h,int posA, int posB){
	swap(&h->datos[posA],&h->datos[posB]);
	//Comparamos el nuevo padre con el otro hijo
	aux_hundir(h,posA);
	//Comparamos el nuevo hijo con el resto de descendientes
	aux_hundir(h,posB);
	}

void heap_eliminar_minimo(Heap h){
	assert(!heap_vacio(h));
	h->nelements--;
	h->datos[0] = h->datos[h->nelements];
	aux_hundir(h,0);
	}


int heap_minimo(Heap h){
	assert(!heap_vacio(h));
	return h->datos[0];
	}


void heap_imprimir(Heap h){
	for(int i = 0, k = 1; i < h->nelements; i++){
		printf("%d ",h->datos[0]);
		if(i+2 == pow(2,k))puts(""),k++;
		}
	}



Heap heapify(int* arreglo, size_t tam){
	Heap h = heap_crear(tam);
	for(int i = 0;i < tam ; i++)
		heap_agregar(h,arreglo[i]);
	return h;
	
	}

void heap_destruir(Heap h){
	free(h->datos);
	free(h);
	}

void hsort(int* arreglo, size_t tam){
	Heap h = heapify(arreglo,tam);
	
	int min, k;
	for(k = 0; k < tam;k++){
		min = heap_minimo(h);
		if(arreglo[k] != min)swap(&arreglo[k],&min);
		
		heap_eliminar_minimo(h);
		}
	heap_destruir(h);
	}*/


void array_imprimir(int* arreglo,size_t tam){
	for(int i = 0;i < tam;i++)
		printf("%d ",arreglo[i]);
	}



aux_flotar(int* arreglo, int pos){
	if(pos == 0) return;
	int i = (pos-1)/2;
	if(arreglo[pos] > arreglo[i]){
		swap(arreglo+pos,arreglo+i);
		aux_flotar(arreglo,i);
		
		}
	
	
	}


void heapify(int* arreglo,size_t tam){
	for(int i = tam-1;i > 0; i++)
		aux_flotar(arreglo[i],i);
	}

