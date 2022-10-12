#include "eje3.h"
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

Pila pila_crear(){	
	return NULL;
	}
	
int pila_vacia(Pila p){
	return p==NULL;
}
	
int pila_top(Pila p){
	return p->dato;
	}

Pila pila_push(Pila p, int d){
	SNodo* nuevoNodo=malloc(sizeof(SNodo));
	nuevoNodo->dato=d;
	if(!p){
		nuevoNodo->sig=NULL;
		return nuevoNodo;
	}
	nuevoNodo->sig=p;
	return nuevoNodo;
}




Pila pila_pop(Pila p){
	if(!p)return NULL;
	SNodo* nodoAELiminar=p;
	p=p->sig;
	free(nodoAELiminar);
	return p;
}

void pila_imprimir(Pila p){
	if(!p){
		printf("esta vacia");
		return;
	}
	Pila aux=p;
	for(;aux!=NULL;aux=aux->sig){
		printf("%d ",aux->dato);
		}
	}

void pila_destruir(Pila p){
	if(!p)return;
	Pila aux=p;
	while(aux!=NULL){
		SNodo* nodoADestruir=aux;
		aux=aux->sig;
		free(nodoADestruir);
	}

}
