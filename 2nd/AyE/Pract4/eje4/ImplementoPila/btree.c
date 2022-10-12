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
	*altura+=1;
	//ver porque rama se puede bajar
	if(arbol->left!=NULL && (arbol->left->left!=NULL || arbol->left->right!=NULL))aux_altura(arbol->left,altura);
	else if(arbol->right!=NULL && (arbol->right->left!=NULL ||arbol->right->right!=NULL))aux_altura(arbol->right,altura);
	return;
	}


int mayor(int a,int b){
	return a<b?b:a;
	}



int btree_altura(BTree arbol){
	if(!arbol)return 0;
	if(!arbol->left && !arbol->right)return 0;
	int alturaizq=0,alturader=0;
	if(arbol->left!=NULL)aux_altura(arbol->left,&alturaizq);
	if(arbol->right!=NULL)aux_altura(arbol->right,&alturader);
	return mayor(alturaizq,alturader);
	}



	
	



void aux_recorrer(Pila p,FuncionVisitante visit){
	BTree temp;
	Pila visitados=pila_crear(p->max);
	while(!pila_vacia(p)){
		temp=pila_top(p);
		//visitar nodo izq y agregar a visitados
		if(temp->left!=NULL){
			visit(temp->left->dato);
			pila_push(visitados,temp->left);
		 }
		//ver si se puede avanzar por nodo der sino visitar nodo der y agregar a visitados
		if(!pila_vacia(visitados)&&pila_top(visitados)!=temp->right && (temp->right->right!=NULL || temp->right->left!=NULL)){
			pila_push(p,temp->right);
		}
		//
		else{
			if(temp->right!=NULL)visit(temp->right->dato);
			pila_pop(p);
			if(!pila_vacia(visitados))pila_pop(visitados);
			}
		}
	}





void btree_recorrer(BTree arbol, BTreeOrdenDeRecorrido orden,FuncionVisitante visit){
	if(!arbol)return;
	int altura=btree_altura(arbol);
	Pila p=pila_crear(altura);
	BTree aux;
	//hacer el recorrido en post orden
	for(aux=arbol->left;aux->left!=NULL || aux->right!=NULL;aux=aux->left){
		pila_push(p,aux);
		}
	aux_recorrer(p,visit);
	/*for(size_t i=0;i<altura&&aux->right!=NULL;i++){
		pila_push(p,aux->right);
		aux=aux->right;
		}
	aux_recorrer(p,visit);*/
	visit(arbol->left->dato);
	visit(arbol->right->dato);
	visit(arbol->dato);
	//printf("\n");
	
	}













