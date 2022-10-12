#include "ej6.h"
#include <stdio.h>
#include <stdlib.h>

Cola cola_crear(){
	return NULL;
	}
	
int cola_es_vacia(Cola c){
	return c==NULL;
	}

int* cola_primero(Cola c){
	if(!c)return NULL;
	return &c->dato;
	}

void cola_encolar(Cola* c, int dato){
	CDList nuevoNodo=malloc(sizeof(struct _CDNodo));
	nuevoNodo->dato=dato;
	if(!*c){
		nuevoNodo->sig=nuevoNodo;
		nuevoNodo->ant=nuevoNodo;
		*c=nuevoNodo;
		return;
		}
	nuevoNodo->ant=(*c)->ant;
	nuevoNodo->sig=*c;
	(*c)->ant->sig=nuevoNodo;
	(*c)->ant=nuevoNodo;
	(*c)=nuevoNodo;
	return;
	}

void cola_imprimir(Cola c){
 if(!c)return;
 Cola aux=c;
 printf("%d ",aux->dato);
 aux=aux->sig;
 for(;aux!=c;aux=aux->sig){
	 printf("%d ",aux->dato);
	 }
 }
 
 
void cola_desencolar(Cola* c){
	if(!*c)return;
	if((*c)->sig==(*c)){
		free(*c);
		(*c)=NULL;
		return;
		}
	CDList nodoAEliminar=(*c)->ant;
	nodoAEliminar->ant->sig=(*c);
	(*c)->ant=nodoAEliminar->ant;
	free(nodoAEliminar);
	}
 
 
	
