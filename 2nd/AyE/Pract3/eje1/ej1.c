#include "eje1.h"
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

Pila pila_crear(){
	Pila p=malloc(sizeof(struct _Pila));
	p->ultimo=-1;
	return p;
	}
	
int pila_vacia(Pila p){
	return (p->ultimo==-1);
	}
	
int pila_top(Pila p){
	assert(!pila_vacia(p));
	return (p->datos[p->ultimo]);
	}

void pila_push(Pila p, int d){
	assert(p->ultimo+1<MAX_PILA);
	p->ultimo++;
	p->datos[p->ultimo]=d;
	//printf("%d\n",p->datos[p->ultimo]);
	//printf("%d\n",p->ultimo);

	}

void pila_pop(Pila p){
	assert(!pila_vacia(p));
	p->ultimo--;
	}

void pila_imprimir(Pila p){
	assert(!pila_vacia(p));
	int longitud=p->ultimo+1, *arreglo=p->datos;
	printf("%d\n",longitud);
	for(int i=0;i<longitud;i++){
		printf("%d",arreglo[i]);
		}
	}

