#include "ej8.h"




int main(){
	//srand(time(NULL));
	PCola cola=cola_prioridad_crear();
	
	cola_prioridad_insertar(cola,4);
	cola_prioridad_insertar(cola,10);
	cola_prioridad_insertar(cola,7);
	cola_prioridad_insertar(cola,5);
	cola_prioridad_insertar(cola,1);
	cola_prioridad_insertar(cola,1);
	cola_prioridad_insertar(cola,3);
	cola_prioridad_insertar(cola,12);
	cola_prioridad_insertar(cola,103);
	cola_prioridad_insertar(cola,99);
	//cola_prioridad_insertar(cola,18);
	cola_prioridad_insertar(cola,5);
	cola_prioridad_insertar(cola,2);
	cola_prioridad_insertar(cola,4);
	cola_prioridad_insertar(cola,0);
	printf("\n");
	cola_prioridad_imprimir(cola);
	}
