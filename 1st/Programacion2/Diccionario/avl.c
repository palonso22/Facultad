#include "diccionario.h"


int arbolVacio(AVL arbol){
	return arbol == NULL;
	}

int alturaArbol(AVL arbol){
	if(!arbol)return -1;
	return 1 + max(alturaArbol(arbol->izq), alturaArbol(arbol->der));
	}

void arbolImprimir(AVL arbol){
	if(!arbol)return;
	arbolImprimir(arbol->izq);
	printf("%s ",arbol->palabra);
	arbolImprimir(arbol->der);	
	}


AVL rotar(AVL arbol, Orden orden){
	AVL aux, aux2,aux3;
	if(orden == SDER){
		aux = arbol->izq;
		arbol->izq = aux->der;
		aux->der = arbol;
		}
	else if(orden == SIZQ){
		aux = arbol->der;
		arbol->der = aux->izq;
		aux->izq = arbol;
		}
	else if(orden == DDER){
		aux = arbol->izq->der, aux2 = aux->der, aux3 = aux->izq;
		arbol->izq->der = aux3;
		aux->izq = arbol->izq;
		arbol->izq = aux2;
		aux->der = arbol;
		}
	else if(orden == DIZQ){
		aux = arbol->der->izq, aux2 = aux->izq, aux3 = aux->der;
		arbol->der->izq = aux3;
		aux->der = arbol->der;
		arbol->der = aux2;
		aux->izq = arbol;
		}
	//Actualizar altura
	aux->izq->alt = 1+max(alt(aux->izq->izq),alt(aux->izq->der));
	aux->der->alt = 1+max(alt(aux->der->izq),alt(aux->der->der));
	aux->alt = 1+max(alt(aux->izq),alt(aux->der));
	return aux;
	}






AVL equilibraArbol(AVL arbol){
	//Actualiza la altura del arbol
	arbol->alt = 1+max(alt(arbol->izq),alt(arbol->der));
	if(fabs(alt(arbol->izq) - alt(arbol->der)) == 2){
		//Comprobar en que arbol se produce el desbalance
		if(alt(arbol->izq) > alt(arbol->der)){
			if(!arbolVacio(arbol->izq->izq)){
				//Rotar una vez a la der
				arbol = rotar(arbol,SDER);
				}
			else{
				//Rotar dos veces hacia la der
				arbol = rotar(arbol,DDER);
				}
		}
		else{
			if(!arbolVacio(arbol->der->der)){
				//Rotar una vez a la izq
				arbol = rotar(arbol,SIZQ);
				}
			else{
				//Rotar dos veces a la izq
				arbol = rotar(arbol,DIZQ);
				}
			}
		}
	return arbol;
	}



AVL arbolInsertar(AVL arbol,char* palabra){
	if(!arbol){
		arbol = malloc(sizeof(struct _AVL));
		arbol->palabra = palabra;
		arbol->alt = 0;
		arbol->izq = NULL;
		arbol->der = NULL;
		return arbol;
		}
	else if(strcmp(arbol->palabra,palabra) > 0){
		arbol->izq = arbolInsertar(arbol->izq, palabra);
		}
	else if(strcmp(arbol->palabra,palabra) < 0){
		arbol->der = arbolInsertar(arbol->der,palabra);
		}
	
	arbol = equilibraArbol(arbol);
	}


void arbolBuscarAux(char* palabra,AVL arbol, int* contiene){
	if(!arbol)return;
	int valor = strcmp(arbol->palabra,palabra);
	if(!valor){
		*(contiene)++;
		return;
		}
	else if(valor > 0){
		arbolBuscarAux(palabra,arbol->izq,contiene);
		}
	else{
		arbolBuscarAux(palabra,arbol->der,contiene);
		}
	}




int arbolBuscar(char* palabra, AVL arbol){
	//Por el momento la palabra no se encuentra
	int contiene = 0;
	arbolBuscarAux(palabra,arbol,&contiene);
	return contiene;
	}


