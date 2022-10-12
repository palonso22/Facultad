


#ifndef _COLAS_
#define _COLAS_
#define MAX_HEAP 15
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <time.h>


typedef struct _HCola{
	int heap[MAX_HEAP];
	int head,nelemts;
	}*PCola;
	
/*Crear una cola*/
PCola cola_prioridad_crear();

/*Determina si una cola es vacia*/
int cola_prioridad_es_vacia(PCola cola);

/*Inserta un elto con determinada prioridad*/
void cola_prioridad_insertar(PCola cola, int dato);

/*Elimina el minimo elto*/
void cola_prioridad_eliminar_minimo(PCola cola);

/*Imprime una cola*/
void cola_prioridad_imprimir(PCola h);



#endif
