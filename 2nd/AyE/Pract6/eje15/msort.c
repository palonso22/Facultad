#include "msort.h"





Lista lista_crear(){
	return NULL;
	}

Lista lista_agregar(Lista l, int dato){
	Nodo nuevoNodo = malloc(sizeof(struct _Nodo));
	nuevoNodo->dato = dato;
	nuevoNodo->sig = NULL;
	if(!l)return nuevoNodo;
	Nodo aux = l;
	for(;aux->sig != NULL; aux = aux->sig);
	aux->sig = nuevoNodo;
	return l;
	}

int lista_long(Lista l){
	int k = 0;
	for(;l != NULL;l = l->sig,++k);
	return k;
	}
void lista_imprimir(Lista l){
	for(;l != NULL;l = l->sig)
		printf("%d ",l->dato);
	}


void lista_particionar(Lista l,Lista *lA,Lista *lB, int lon){
	int k = lon/2;
	*lA = l;
	for(int i = 0;i < k-1;l = l->sig, i++);
	*lB = l->sig;
	l->sig = NULL;
	}

int aux_lista_menor(Lista *lA){
	int min = (*lA)->dato;
	*lA = (*lA)->sig;
	return min;
	}

int lista_menor(Lista *lA,Lista *lB){
	if(!*lA)return aux_lista_menor(lB);
	if(!*lB)return aux_lista_menor(lA);
	if((*lA)->dato < (*lB)->dato)return aux_lista_menor(lA);
	return aux_lista_menor(lB);
	}




Lista lista_fusionar(Lista lA, Lista lB){
	Lista l = lista_crear();
	while(lA != NULL || lB != NULL){
		l = lista_agregar(l,lista_menor(&lA,&lB));
		}
	return l;
	}


Lista msort(Lista l){
	int k = lista_long(l);
	if(k<2)return l;
	Lista lA,lB;
	lista_particionar(l,&lA,&lB,k);
	lA = msort(lA),lB = msort(lB);
	l = lista_fusionar(lA,lB);
	return l;
	}
