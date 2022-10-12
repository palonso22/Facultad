#include "eje2.h"
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

Pila pila_crear(){
	Pila p=malloc(sizeof(struct _Pila));
	p->datos=malloc(sizeof(int)*p->max_pila);
	p->ultimo=-1;
	p->max_pila=3;
	return p;
	}
	
int pila_vacia(Pila p){
	return p->ultimo==-1;
	}
	
int pila_top(Pila p){
	assert(!pila_vacia(p));
	return (p->datos[p->ultimo]);
	}

void pila_push(Pila p, int d){
	if(p->ultimo+1==p->max_pila){
		p->max_pila*=2;
		p->datos=realloc(p->datos,(size_t)(p->max_pila));
		}
	p->ultimo++;
	p->datos[p->ultimo]=d;
	}

void pila_pop(Pila p){
	assert(!pila_vacia(p));
	p->ultimo--;//Achicar
	}

void pila_imprimir(Pila p){
	assert(!pila_vacia(p));
	int longitud=p->ultimo+1, *arreglo=p->datos;
	printf("%d\n",longitud);
	for(int i=0;i<longitud;i++){
		printf("%d ",arreglo[i]);
		}
	}

