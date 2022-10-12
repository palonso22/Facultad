#include "btree.h"
#include <stdlib.h>

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

void btree_recorrer(BTree arbol, BTreeOrdenDeRecorrido orden,FuncionVisitante visit){
	if(!arbol)return;
	if(orden==BTREE_RECORRIDO_POST){
		btree_recorrer(arbol->left,orden,visit);
		btree_recorrer(arbol->right,orden,visit); 
		printf("%d",arbol->dato);
		printf("\n");
		}
	else if(orden==BTREE_RECORRIDO_PRE){
		printf("%d",arbol->dato);
		printf("\n");
		btree_recorrer(arbol->left,orden,visit);
		btree_recorrer(arbol->right,orden,visit);
		}
	else{
		btree_recorrer(arbol->left,orden,visit);
		btree_recorrer(arbol->right,orden,visit);
		printf("%d",arbol->dato);
		printf("\n"); 
		}
	}
