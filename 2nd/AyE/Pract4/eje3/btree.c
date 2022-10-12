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


void btree_recorrer(BTree tree,BTreeOrdenDeRecorrido BTREE_RECORRIDO_POST,FuncionVisitante imprimir_entero){
	if(tree!=NULL){
		printf("\n");
		imprimir_entero(tree->dato);
		btree_recorrer(tree->left, BTREE_RECORRIDO_POST,imprimir_entero);
		btree_recorrer(tree->right, BTREE_RECORRIDO_POST,imprimir_entero);
		}
	return;
	}

void btree_suma(BTree arbol,int* suma){
	//si arbol es no nulo
	if(arbol!=NULL){
		*suma+=arbol->dato;
		//hace sum por izq y por der
		btree_suma(arbol->left,suma);
		btree_suma(arbol->right,suma);
		}
	}


void btree_calcular(BTree arbol,int* cantidad){
	if(arbol!=NULL){
		++(*cantidad);
		btree_calcular(arbol->left,cantidad);
		btree_calcular(arbol->right,cantidad);
		}
	}
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	





