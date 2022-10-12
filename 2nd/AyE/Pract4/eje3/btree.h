#ifndef __BTREE_H__
#define __BTREE_H__
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
void btree_recorrer(BTree arbol, BTreeOrdenDeRecorrido orden, FuncionVisitante visit);

/*Calcula la suma de un arbol de enteros*/
void btree_suma(BTree arbol,int* suma);


/*Calcula la cantidad de nodos de un arbol de enteros*/
void btree_calcular(BTree arbol,int* cantidad);

/*Calcula la altura de un arbol de enteros*/
int btree_altura(BTree arbol);









#endif /* __BTREE_H__ */
