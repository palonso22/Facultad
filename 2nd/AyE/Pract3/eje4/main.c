#include "ej4.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(){
	srand(time(NULL));
	SList lista=slist_crear();
	for(int i=0;i<10;i++){
		int* dato=malloc(sizeof(int));
		*dato=rand()%10+1;
		lista=slist_agregar_inicio(lista,dato);
	}
	slist_imprimir(lista);
	printf("\n");
	lista=slist_reverso(lista);
	slist_imprimir(lista);
		
}
