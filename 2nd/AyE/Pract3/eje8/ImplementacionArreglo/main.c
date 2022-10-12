#include "ej8.h"


int main(){
	int i=0;
	//srand(time(NULL));
	PCola cola=cola_prioridad_crear();
	cola_prioridad_insertar(cola,3);
	cola_prioridad_insertar(cola,1);
	cola_prioridad_insertar(cola,7);
	cola_prioridad_insertar(cola,8);
	cola_prioridad_insertar(cola,-1);
	//cola_prioridad_imprimir(cola);
	//printf("\n");
	cola_prioridad_eliminar_minimo(cola);
	cola_prioridad_eliminar_minimo(cola);
	cola_prioridad_eliminar_minimo(cola);
	cola_prioridad_imprimir(cola);
	cola_prioridad_insertar(cola,2);
	//cola_prioridad_imprimir(cola);
	printf("\nestos son los datos %d %d %d\n",cola->datos[3],cola->datos[4],cola->datos[0]);
	printf("\n");
	cola_prioridad_insertar(cola,3);
	//cola_prioridad_insertar(cola,4);
	/*cola_prioridad_insertar(cola,0);*/
	printf("\n");
	cola_prioridad_imprimir(cola);
	/*printf("%d",cola->ultimo);
	printf("%d",cola->primero);*/
	}
