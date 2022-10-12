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


void aux_intercambiar_nodos(BTree arbol){
	if(arbol!=NULL){
		BTree aux=arbol->left;
		arbol->left=arbol->right;
		arbol->right=aux;
		aux_intercambiar_nodos(arbol->left);
		aux_intercambiar_nodos(arbol->right);
		}	
	}

void btree_recorrer(BTree arbol,FuncionVisitante visit){
	if(arbol!=NULL){
		visit(arbol->dato);
		btree_recorrer(arbol->left,visit);
		btree_recorrer(arbol->right,visit);
		}	
	}

void aux_copiar(BTree arbol,BTree* arbolMirror){
	if(arbol!=NULL){
		(*arbolMirror)=malloc(sizeof(BTNodo));
		(*arbolMirror)->dato=arbol->dato;
		aux_copiar(arbol->left,&((*arbolMirror)->left));
		aux_copiar(arbol->right,&((*arbolMirror)->right));
		}
	}


	BTree btree_mirror(BTree arbol){
	BTree arbolMirror=btree_crear();
	aux_copiar(arbol,&arbolMirror);
	aux_intercambiar_nodos(arbolMirror);
	return arbolMirror;
	}
