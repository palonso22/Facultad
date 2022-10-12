#include <stdio.h>
#include <stdlib.h>

#ifndef _Slist_
#define _Slist_

typedef struct _Nodo{
	void* dato;
	struct _Nodo* sig;
}*SList;

typedef struct _Pila{
	SList nodo;
	struct _Pila* sig;
}*Pila;


/*Crea una lista*/
SList slist_crear();

/*Agrega un nodo al comienzo de la lista*/
SList slist_agregar_inicio(SList lista,void* dato);

/*Destruye una lista*/
void slist_destruir(SList lista);

/*Imprime una lista*/
void slist_imprimir(SList lista);

/*Invierte una lista*/
SList slist_reverso(SList lista);

/*Crea una pila*/
Pila pila_crear();

/*Agrega eltos a una pila*/
Pila pila_push();

/*Imprime una pila*/
void pila_imprimir(Pila p);













#endif
