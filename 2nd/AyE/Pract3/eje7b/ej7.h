
#ifndef __heap_
#define _heap_
#define MAX_HEAP 20
#include <stdlib.h>



typedef struct _BHeap {
int datos[MAX_HEAP];
int nelemts;
} *BHeap;

/*Crea un heap vacio*/
BHeap bheap_crear();

/*Determina si un heap es vacio*/
int bheap_es_vacio(BHeap h);
 
/*Toma un heap y devuelve el menor elto
int bheap_minimo(BHeap h);*/

/*Toma un heap y elimina su menor elto*/
void bheap_eliminar_minimo(BHeap h);

/*Tom un heap y agrega un elto*/
void bheap_insertar(BHeap h, int dato);

/*Destruye un heap*/
void bheap_destruir(BHeap h);

/*Imprime un heap*/
void bheap_imprimir(BHeap h);

#endif

