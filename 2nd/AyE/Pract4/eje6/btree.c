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


void btree_calcular(BTree arbol,int* cantidad){
	if(arbol!=NULL){
		++(*cantidad);
		btree_calcular(arbol->left,cantidad);
		btree_calcular(arbol->right,cantidad);
		}
	}

	



void aux_recorrer_bfs(Cola c,FuncionVisitante visit){
	BTree* arreglo=c->cola;
	for(int i=c->primero;i<c->ultimo+1;i++){
		visit(arreglo[i]->dato);
		}
	}
	
void aux_agregar_hijos(Cola c,int cantidad){
	BTree* arreglo=c->cola;
	for(int i=c->primero;i<c->primero+cantidad;i++){
¿		if(arreglo[i]->left!=NULL)cola_encolar(c,arreglo[i]->left);
		if(arreglo[i]->right!=NULL)cola_encolar(c,arreglo[i]->right);
		}
	}

void aux_eliminar_padres(Cola c,int cantidad){
	for(int j=0;j<cantidad;j++){
		cola_desencolar(c);
		}
	}

void btree_recorrer_bfs(BTree arbol,FuncionVisitante visit){
	if(!arbol)return;
	Cola c=cola_crear();
	int cantidad;
	cola_encolar(c,arbol);//raiz
	while(!cola_vacia(c)){
			aux_recorrer_bfs(c,visit);
			cantidad=c->ultimo-c->primero+1;
			aux_agregar_hijos(c,cantidad);
			aux_eliminar_padres(c,cantidad);
			}
		}
