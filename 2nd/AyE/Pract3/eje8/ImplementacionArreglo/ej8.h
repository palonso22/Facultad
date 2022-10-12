#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <time.h>



#ifndef _COLAS_
#define _COLAS_
#define MAX_COLA 5

typedef struct _ArregloCola{
	int datos[MAX_COLA];
	int primero;
	int ultimo;
	}*PCola;
	
	
/*Crea una cola de prioridad*/
PCola cola_prioridad_crear();

/*Determina si una cola esta vacia*/
int cola_prioridad_es_vacia(PCola cola);

/*Obtiene el elto prioritario*/
int cola_prioridad_obtener_minimo(PCola cola);

/*Quita el elto prioritario*/
void cola_prioridad_eliminar_minimo(PCola cola);

/*Inserta un elto con determinada prioridad*/
void cola_prioridad_insertar(PCola cola, int dato);

/*Imprime una cola*/
void cola_prioridad_imprimir(PCola cola);











#endif
