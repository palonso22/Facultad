#include "ej6.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main(){
	srand(time(NULL));
	Cola c=cola_crear();
	if(cola_es_vacia(c))printf("esta vacia");
	printf("\n");
	printf("\n");
	for(int i=0;i<20;i++){
		cola_encolar(&c,rand()&+9);
		cola_imprimir(c);
		printf("\n");
		}
	for(int i=0;i<20;i++){
		cola_desencolar(&c);
		cola_imprimir(c);
		printf("\n");
		}
	if(cola_es_vacia(c))printf("esta vacia");
	}
