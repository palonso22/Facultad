

#ifndef _MSORT_
#define _MSORT_
#include <stdlib.h>
#include <stdio.h>
#include <time.h>


typedef struct _Nodo{
	int dato;
	struct _Nodo* sig;
	}*Nodo;

typedef Nodo Lista;

 

/**Crea una lista vacia**/
Lista lista_crear();


/**Agrega un elto al inicio de la lista**/
Lista lista_agregar(Lista , int );


/**Retorna la cantidad de eltos de una lista**/
int lista_long(Lista);

/**Elimina una lista**/
void lista_destruir(Lista);



/**Imprime una lista**/
void lista_imprimir(Lista);

/**Algoritmo de ordenamiento por fusion**/
Lista msort(Lista);











#endif
