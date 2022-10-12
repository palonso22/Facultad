

#ifndef _HSORT_
#define _HSORT_
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include <math.h>


/**Estructura y Funciones basicas para heap**/


typedef struct _Heap{
	int* datos, nelements;
	size_t tam;
	}*Heap;
	

/**Crea un heap**/
Heap heap_crear(size_t);


/**Agrega un elto al heap**/
void heap_agregar(Heap,int);


/**Elimina el minimo elto de un heap**/
void heap_eliminar_minimo(Heap);


/**Extrae el minimo de un heap**/
int heap_minimo(Heap);


/**Destruye un heap**/
void heap_destruir(Heap);


/**Determina si un heap es vacio**/
int heap_vacio(Heap);

void heap_imprimir(Heap);



/**Algoritmo de ordenacion para un arreglo**/
void hsort(int*,size_t);

/**Imprime un arreglo**/
void heapify(int* arreglo,size_t tam);
void array_imprimir(int* arreglo,size_t tam);
#endif
