#include "hsort.h"
#define MAX 7




int main(){
	size_t tam = MAX;
	srand(time(NULL));
	int arreglo[MAX];
	for(int i = 0;i < MAX; i++){
		arreglo[i] = rand()%20+1;
		}
	array_imprimir(arreglo,tam);
	heapify(arreglo,tam);
	puts("");
	array_imprimir(arreglo,tam);
	
	/*array_imprimir(arreglo,MAX);
	hsort(arreglo,MAX);
	puts("");
	array_imprimir(arreglo,MAX);
	puts("");*/
	
	}







/*
size_t j = 	MAX;
	Heap h = heap_crear(j);
	for(int i = 0;i < MAX; i++){
		heap_agregar(h,arreglo+i);
		}
	heap_imprimir(h), puts("");
	heap_eliminar(h), heap_imprimir(h), puts("");
	heap_eliminar(h), heap_imprimir(h), puts("");
	heap_eliminar(h), heap_imprimir(h), puts("");
	heap_eliminar(h), heap_imprimir(h), puts("");
	puts("");*/

/*heap_imprimir(h);
	heap_eliminar_minimo(h);
	puts("");
	heap_imprimir(h);
	heap_eliminar_minimo(h);
	puts("");
	heap_imprimir(h);
	heap_eliminar_minimo(h);
	puts("");
	heap_imprimir(h);*/
	
