#include "ej4.h"
#include <stdio.h>
#include <stdlib.h>


SList slist_crear(){
	return NULL;
}

SList slist_agregar_inicio(SList lista,void* dato){
	SList nuevoNodo=malloc(sizeof(struct _Nodo));
	nuevoNodo->dato=dato;
	if(!lista){
		nuevoNodo->sig=NULL;
		return nuevoNodo;
	}
	nuevoNodo->sig=lista;
	return nuevoNodo;
}

void slist_imprimir(SList lista){
	if(!lista)return;
	SList aux=lista;
	for(;aux!=NULL;aux=aux->sig){
		printf("%d ",*(int*)aux->dato);
		}

}

SList slist_reverso(SList lista){
	//creamos una pila vacia
	Pila p=pila_crear();
	SList aux=lista;
	
	//Apilamos los nodos de la lista
	//El primer nodo de la lista será 
	//el último elto de la pila
	for(;aux!=NULL;aux=aux->sig){
		p=pila_push(p,aux);
	}
	Pila temp=p;
	
	//Recorremos la pila apuntado el nodo
	//que pertenece al elto actual al nodo
	//del elto siguiente.
	for(;temp->sig!=NULL;temp=temp->sig){
		temp->nodo->sig=temp->sig->nodo;
	}
	
	//El nodo del último elto apuntará a NULL
	temp->nodo->sig=NULL;
	return p->nodo;
}

Pila pila_crear(){
	return NULL;
	}

Pila pila_push(Pila p,SList nodo){
	Pila nuevoElto=malloc(sizeof(struct _Pila));
	nuevoElto->nodo=nodo;
	if(!p){
		nuevoElto->sig=NULL;
		return nuevoElto;
	}
	nuevoElto->sig=p;
	return nuevoElto;
}

void pila_imprimir(Pila p){
	if(!p)return;
	for(;p->sig!=NULL;p=p->sig){
		printf("%d",*(int*)p->nodo->dato);
	}
}


