#ifndef __BTREE_H__
#define __BTREE_H__
#define MAX 100
#include  <stdlib.h>
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
void btree_recorrer(BTree arbol, BTreeOrdenDeRecorrido orden,FuncionVisitante visit);


//funciones para pila




typedef struct _Pila{
	BTree* pila;
	int ultimo,max;
	}*Pila;

/*Crea una pila*/	
Pila pila_crear(int tamanio);


/*Determina si una pila esta vacia*/
int pila_vacia(Pila p);

/*Devuelve el elto de la cima de la pila*/
BTree pila_top(Pila p);

/*Agrega un elto a la cima de la pila*/
void pila_push(Pila p, BTree arbol);

/*Elimina el elto de la cima*/
void pila_pop(Pila p);
	

#endif /* __BTREE_H__ */
