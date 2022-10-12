#include "btree.h"



Cola cola_crear(){
	Cola c=malloc(sizeof(struct _Cola));
	c->ultimo=-1;
	c->primero=0;
	return c;
	}

int cola_vacia(Cola c){
	return c->primero>c->ultimo;
	}

int cola_encolar(Cola c, BTree nodo){
	c->ultimo++;
	if(c->ultimo>MAX-1)return 1;
	c->cola[c->ultimo]=nodo;
	return 0;
	}

void cola_desencolar(Cola c){
	c->primero++;
	}

BTree cola_primero(Cola c){
	if(cola_vacia(c))return NULL;
	return c->cola[c->primero];
	}

void cola_destruir(Cola c){
	free(c->cola);
	}


	

