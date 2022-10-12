#include "ej8.h"






PCola cola_prioridad_crear(){
	return NULL;
	}

int cola_prioridad_es_vacia(PCola cola){
	return cola==NULL;
	}


PCola cola_prioridad_insertar(PCola cola,int dato){
	PCola nuevoNodo=malloc(sizeof(struct _ListCola));
	nuevoNodo->dato=dato;
	if(!cola){
		nuevoNodo->sig=NULL;
		return nuevoNodo;
		}
	if(cola->dato>nuevoNodo->dato){
		nuevoNodo->sig=cola;
		return nuevoNodo;
		}
	PCola aux=cola;
	for(;aux->sig!=NULL&&aux->sig->dato<nuevoNodo->dato;aux=aux->sig);
	if(!aux->sig){
		aux->sig=nuevoNodo;
		nuevoNodo->sig=NULL;
		return cola;
		
		}
	nuevoNodo->sig=aux->sig;
	aux->sig=nuevoNodo;
	return cola;
	}
	
	
void cola_prioridad_imprimir(PCola cola){
	if(!cola)return;
	PCola aux;
	for(;cola!=NULL;cola=cola->sig){
		printf("%d ",cola->dato);
		}
	}
	
PCola cola_prioridad_eliminar_minimo(PCola cola){
	if(!cola)return NULL;
	PCola nodoAEliminar=cola;
	cola=cola->sig;
	//free(nodoAEliminar);
	return cola;
	}	
	
int* cola_prioridad_obtener_minimo(PCola cola){
	if(!cola)return NULL;
	return &cola->dato;
	}
	
	
	
	
	
	
	
	
