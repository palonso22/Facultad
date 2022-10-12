#include "eje2.h"
#include <stdio.h>




int main(){
	Pila p=pila_crear();
	pila_push(p,5);
	pila_push(p,11);
	pila_push(p,25);
	pila_push(p,55);
	pila_imprimir(p);
	printf("\n");
	if(pila_vacia(p))printf("esta vacia\n");
	
	
	}
