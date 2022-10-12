#include "ej5.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

Cola cola_inicializar(){
	Cola c=malloc(sizeof(struct _Cola));
	c->primero=-1;
	c->ultimo=0;
	}
	
int cola_es_vacia(Cola c){
	return c->primero==-1;
	}

int cola_primero(Cola c){
	assert(c->primero!=-1);
	return c->datos[c->primero];
	}

void cola_encolar(Cola c, int d){
	if((c->primero+1)==MAX_COLA){
		return;
		}
	c->primero++;
	c->datos[c->primero]=d;
	return ;
	}

void cola_desencolar(Cola c){
	if(c->primero>-1)c->primero--;
	return;
	}

void cola_imprimir(Cola c){
	if(c->primero==-1)return;
	int i=c->primero;
	for(;i>=c->ultimo;i--){
		printf("%d ",c->datos[i]);
		}
	return;
	}
	

