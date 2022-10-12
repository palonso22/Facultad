#include "ordsel.h"


List lista_crear(){
	return NULL;
	}


List lista_agregar(List lista, int dato){
	List nuevoNodo = malloc(sizeof(struct _Nodo));
	nuevoNodo->dato = dato;
	nuevoNodo->sig = lista;
	return nuevoNodo;	
	}
	
void lista_eliminar(List lista){
	while(!lista){
		Nodo nodoAEliminar = lista;
		lista = lista->sig;
		free(nodoAEliminar);
		}
	}


void lista_imprimir(List lista){
	for(;lista != NULL; lista = lista->sig){
		printf("%d\n",lista->dato);
		}
	}



int lista_tamano(List lista){
	int i = 0;
	for(;lista != NULL;lista = lista->sig, i++);
	return i;
	}


List aux_select_sort(List lista, Nodo nodoMayor){
	for(;lista->sig != NULL;){
		  if(lista->sig == nodoMayor)lista->sig = lista->sig->sig;
		  if(lista->sig != NULL) lista = lista->sig;
		}
	lista->sig = nodoMayor;
	lista = lista->sig;
	//printf("pp %d",lista->dato);
	return lista;
	
	}



List select_sort(List lista, Comparar comparar){
	if(!lista)return NULL;
	int tam = lista_tamano(lista);
	List temp,lista2;
	while(tam > 1){
		//Caso lista tamaño 2
		if(tam == 2){
			if(lista->dato > lista->sig->dato){
				temp = lista;
				lista = lista->sig;
				temp->sig = lista->sig;
				lista->sig = temp;
				}
				tam--;
			}
		else{
			Nodo mayor = lista; //El primer nodo es el mayor por ahora
			temp = lista->sig;
			for(int i = 1; i < tam-1;i++,temp = temp->sig){
				//Comparar desde el segundo nodo hasta el penultimo de la sublista a ordenar
				//En caso de encontrar un nodo mayor guardarlo
				if(temp->dato > mayor->dato)mayor = temp;
				}
			//Comparar el ultimo de la sublista a ordenar  
			if(temp->dato > mayor->dato)mayor = temp;
			//Si el mayor era el primero, el segundo nodo sera el nuevo inicio
			if(mayor == lista)lista = lista->sig;
			//Guardar la sublista que ya esta ordenada
			lista2 = temp->sig;
			temp->sig = NULL;
			//Colocar el mayor en el ultimo lugar de la sublista por ordenar
			temp = aux_select_sort(lista,mayor);
			//Volver a concantenar las sublistas ordenadas
			temp->sig = lista2;
			tam--;
			 }
		}
	return lista;
}
