#include "diccionario.h"



SList crearLista(){
	return NULL;
	}



SList agregarLista(char* palabra, SList l){
	//Crear nuevo nodo
	SList nuevoNodo = malloc(sizeof(struct _SList));
	nuevoNodo->palabra = palabra;
	//Colocar nodo al final de la lista
	if(!l){
		nuevoNodo->sig = NULL;
		return nuevoNodo;
		}
	SList aux = l;
	for(; aux->sig != NULL; aux = aux->sig);
	aux->sig = nuevoNodo;
	return l;
	}






