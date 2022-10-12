


#ifndef _ORDSEL_
#define _ORDSEL_
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

typedef int (*Comparar)(void* a, void* b);


typedef struct _Nodo{
	int dato;
	struct _Nodo* sig;
	}*Nodo;

typedef Nodo List;

/**Crea una lista vacia**/
List lista_crear();

/**Agrega un elto al inicio de la lista**/
List lista_agregar(List lista, int dato);



/**Eliminar la lista**/
void lista_eliminar(List lista);


/**Imprime una lista**/
void lista_imprimir(List lista);

/**Ordena una lista con el metodo de ordenacion por seleccion**/
List select_sort(List lista, Comparar comparar);




#endif

