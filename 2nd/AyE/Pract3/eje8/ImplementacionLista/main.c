#include "ej8.h"





int main(){
	PCola cola=cola_prioridad_crear();
	cola=cola_prioridad_insertar(cola,5);
	cola=cola_prioridad_insertar(cola,3);
	cola=cola_prioridad_insertar(cola,4);
	cola=cola_prioridad_insertar(cola,8);
	cola=cola_prioridad_insertar(cola,12);
	cola=cola_prioridad_insertar(cola,16);
	cola=cola_prioridad_insertar(cola,13);
	cola=cola_prioridad_insertar(cola,1);
	cola=cola_prioridad_insertar(cola,-1);
	cola_prioridad_imprimir(cola);
	printf("\n");
	if(!cola_prioridad_obtener_minimo(cola))printf("Esta vacia");	
	}
