#include "ej5.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(){
	//srand(time(NULL));
	Cola c=cola_inicializar();
	printf("\n");
	for(int i=0;i<10;i++){
		cola_encolar(c,rand()%10+1);
		}
	if(cola_es_vacia(c))printf("esta vacia");
	cola_imprimir(c);
	cola_desencolar(c);
	cola_encolar(c,12);
	printf("\n");
	cola_imprimir(c);
	printf("\n%d",c->datos[0]);
	}
