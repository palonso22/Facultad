


#ifndef _CBTREE_
#define _CBTREE_
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <assert.h>

typedef struct CBTree_{
	int* arbol,nElements,cantMax;
	}*CBTree;
	

/**Crea un nuevo arbol de una cantidad maxima de niveles datos**/
CBTree cbtree_crear(size_t nivel);


/**Destruye un arbol**/
void cbtree_destruir(CBTree estructArbol);




#endif
