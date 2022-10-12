#include "cbtree.h"



int aux_cant(size_t nivel){
	int suma=0;
	for(int i=0;i<nivel+1;i++){
		suma+=pow(2,i);
		}
	return suma;
	}



CBTree cbtree_crear(size_t nivel){
	//calcular max de eltos considerando cuantos niveles tendra
	int max=aux_cant(nivel);
	CBTree estructArbol=malloc(sizeof(struct CBTree_));
	estructArbol->maxCant=max;
	estructArbol->arbol=malloc(sizeof(int)*max);
	estructArbol->nElements=0;
	return estructArbol;
	}


void cbtree_destruir(CBTree estructArbol){
	free(estructArbol->arbol);
	free(estructArbol);
	}
	
void cbtree_insertar(CBTree estructArbol,int dato){
	estructArbol->nElements++;
	assert(estructArbol->nElements>estructArbol->cantMax==0);
	estructArbol->arbol[estructArbol->nElements-1]=dato;
	}
	
void cbtree_recorrer
