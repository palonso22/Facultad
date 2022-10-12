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


void btree_recorrer_extra(BTree arbol, FuncionVisitanteExtra visit, void *extra){
	if(!arbol)return;
	visit(arbol->dato,extra);
	btree_recorrer_extra(arbol->left,visit, extra);
	btree_recorrer_extra(arbol->right,visit,extra);
	}
