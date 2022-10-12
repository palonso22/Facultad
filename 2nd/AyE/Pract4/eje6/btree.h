#ifndef __BTREE_H__
#define __BTREE_H__
#define MAX 100
#include <stdlib.h>
#include <stdio.h>

typedef void (*FuncionVisitante) (int dato);

typedef enum {
  BTREE_RECORRIDO_IN,
  BTREE_RECORRIDO_PRE,
  BTREE_RECORRIDO_POST
} BTreeOrdenDeRecorrido;

typedef struct _BTNodo {
  int dato;
  struct _BTNodo *left;
  struct _BTNodo *right;
} BTNodo;

typedef BTNodo *BTree;

/**
 * Devuelve un arbol vacío.
 */
BTree btree_crear();

/**
 * Destruccion del árbol.
 */
void btree_destruir(BTree nodo);

/**
 * Crea un nuevo arbol, con el dato dado en el nodo raiz, y los subarboles dados
 * a izquierda y derecha.
 */
BTree btree_unir(int dato, BTree left, BTree right);

/**
 * Recorrido del arbol, utilizando la funcion pasada.
 */
void btree_recorrer_bfs(BTree arbol,FuncionVisitante visit);



//funciones de cola

typedef struct _Cola{
	BTree cola[MAX];
	int primero,ultimo;
	}*Cola;

/*Dado un nivel crea una cola*/
Cola cola_crear();


/*Determina si una cola está vacia*/
int cola_vacia(Cola c);


/*Agrega un elto al final de la cola*/
int cola_encolar(Cola c, BTree nodo);


/*Elimina el ultimo elto de una cola3*/
void cola_desencolar(Cola c);


/*Dada una cola obtiene su primer elto*/
BTree cola_primero(Cola c);


/*Destruye una cola*/
void cola_destruir(Cola c);











#endif /* __BTREE_H__ */
