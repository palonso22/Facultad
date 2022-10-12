

#ifndef _HEAP_
#define _HEAP_
#define MAX 100
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include <stdio.h>
#include <math.h>
typedef struct _Heap{
	int datos[MAX], nelemts;
	}*Heap;
	

/**Crea un heap**/
Heap heap_crear();



/**Agrega eltos a un heap**/
void heap_agregar(Heap , int);



/**Obtener el minimo de un heap**/
int heap_minimo(Heap);




/**Eliminar el minimo de un heap**/
void heap_eliminar_minimo(Heap);



/**Destruye un heap**/
void heap_destruir(Heap);

/**Determina si un heap esta vacio**/
int heap_vacio(Heap);




/**Imprime un heap**/
void heap_imprimir(Heap);


/**Transforma un arreglo en un heap**/
Heap heapify(int*,size_t);

/**Une dos heaps**/
Heap bheap_merge(Heap heap1, Heap heap2);

/****/



#endif
