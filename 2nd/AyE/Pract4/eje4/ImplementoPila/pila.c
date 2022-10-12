#include "btree.h"



Pila pila_crear(int tamanio){
	Pila p=malloc(sizeof(struct _Pila));
	p->pila=malloc(sizeof(BTree)*tamanio);
	p->ultimo=-1;
	p->max=tamanio;
	return p;
	}

int pila_vacia(Pila p){
	return p->ultimo==-1;
	}


BTree pila_top(Pila p){
	if(pila_vacia(p))return NULL;
	return p->pila[p->ultimo];
	}


void pila_push(Pila p, BTree arbol){
	p->ultimo++;
	p->pila[p->ultimo]=arbol;
	}

void pila_pop(Pila p){
	p->ultimo--;
	}
