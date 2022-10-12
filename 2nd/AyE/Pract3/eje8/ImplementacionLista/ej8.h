

#ifndef _COLAS_
#define _COLAS_
#include <stdlib.h>
#include <stdio.h>

typedef struct _ListCola{
	int dato;
	struct _ListCola* sig;
	}*PCola;

/*Determina si una cola es vacia*/
int cola_prioridad_es_vacia(PCola cola);

/*Obtiene el mínimo elto*/
int* cola_prioridad_obtener_minimo(PCola cola);

/*Quita el elto prioritario*/
PCola cola_prioridad_eliminar_minimo(PCola cola);

/*Inserta un elto con determinada prioridad*/
PCola cola_prioridad_insertar(PCola cola, int dato);

/*Imprime una cola*/
void cola_prioridad_imprimir(PCola cola);

/*Crea una cola*/
PCola cola_prioridad_crear();

#endif 
