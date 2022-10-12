#include "tablahash.h"


Pila pila_crear(){
	return NULL;
	}
	
int pila_vacia(Pila p){
	return p == NULL;
	}	


Pila pila_pop(Pila p){
	assert(p != NULL);
	struct _Nodo* nodoAEliminar = p;
	p = p->sig;
	free(nodoAEliminar);
	return p;
	}

void* pila_top(Pila p){
	assert(p != NULL);
	return p->dato;
	}

Pila pila_push(Pila p,void* clave, void* dato){
	Nodo* nuevoNodo = malloc(sizeof(Nodo));
	nuevoNodo->dato = dato;
	nuevoNodo->clave = clave;
	nuevoNodo->sig = p;
	return nuevoNodo;
	}

void pila_destruir(Pila p){
	while(!pila_vacia(p)){
		p = pila_pop(p);
		}
	}


int pila_contiene(Pila p, void* clave){
	for(;p != NULL && (*(int*)(p->dato) != *(int*)clave); p = p->sig);
	return p != NULL;
	}


void pila_imprimir(Pila p){
	while(p != NULL){
		printf("%d\n",*(int*)p->dato);
		p = p->sig;
		}
	}

void* pila_buscar(Pila p, void* clave, FuncionIgualdad cmp){
	if(!p) return NULL;
	if(cmp (p->clave, clave)) return p->dato;
	for(;p->sig != NULL && !cmp(p->clave, clave); p = p->sig);
	if(!p->sig) return NULL;
	return p->dato;
	}

