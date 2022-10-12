#include "btree.h"
#include <stdlib.h>
#include <stdio.h>

BTree btree_crear() {
  return NULL;
}

void btree_destruir(BTree nodo) {
  if (nodo != NULL) {
    btree_destruir(nodo->left);
    btree_destruir(nodo->right);
    free(nodo);
  }
}

BTree btree_unir(int dato, BTree left, BTree right) {
  BTree nuevoNodo = malloc(sizeof(BTNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->left = left;
  nuevoNodo->right = right;
  return nuevoNodo;
}

void aux_altura(BTree arbol,int* altura){
	if(arbol!=NULL){
		++(*altura);
		if(!arbol->left)btree_altura(arbol->right);
		aux_altura(arbol->left,altura);
		}
	}
	



void btree_recorrer(BTree arbol, BTreeOrdenDeRecorrido orden,FuncionVisitante visit){
	if(!arbol)return;
	aux_altura(arbol,&longitud);
	BTree pila[longitud];
	aux_agregar_pila(arbol,orden,pila,&ultimo);
	for(int i=longitud-1;i>-1;i--){
		visit(pila[i]->dato);
		}
	}
