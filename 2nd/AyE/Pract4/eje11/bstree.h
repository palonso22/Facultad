

#ifndef _BSTREE_
#define _BSTREE_
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
typedef void (*FuncionVisitante) (int dato);

typedef enum {
  BTREE_RECORRIDO_IN,
  BTREE_RECORRIDO_PRE,
  BTREE_RECORRIDO_POST
} BSTreeOrdenDeRecorrido;

typedef struct BSTree_{
	int dato;
	struct BSTree_* left;
	struct BSTree_* right;
	}*BSTree;


/**Crea un arbol**/
BSTree bstree_crear();

/**Agrega un elto a un arbol **/
BSTree bstree_insertar(BSTree arbol,int dato);



/**
 * Recorrido del arbol, utilizando la funcion pasada.
 */
void bstree_recorrer(BSTree arbol, BSTreeOrdenDeRecorrido orden,FuncionVisitante visit);


/**Elimina un elto de un arbol de busqueda**/
BSTree bstree_eliminar(BSTree arbol, int dato);

/**Determina si un elto está en un arbol de busqueda**/
int bstree_contiene(BSTree arbol, int dato);


/**Devuelve la altura de un arbol**/
int bstree_altura(BSTree arbol);

/**Calcula la cantidad de eltos de un arbol**/
int bstree_nelementos(BSTree arbol);

/**Obtiene el min de un arbol binario de busqueda**/
BSTree bstree_min(BSTree arbol);


/**Balancea en cantidad un arbol binario de busqueda**/
BSTree bstree_balancear(BSTree arbol);


#endif
