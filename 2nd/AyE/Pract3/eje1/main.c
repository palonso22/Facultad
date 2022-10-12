#include "eje1.h"
#include <stdio.h>




int main(){
	Pila p=pila_crear();
	pila_push(p,5);
	pila_push(p,11);
	pila_push(p,25);
	pila_imprimir(p);
	printf("\n");
	pila_pop(p);
	pila_imprimir(p);
	printf("\n");
	printf("%d",pila_top(p));
	printf("\n");
	pila_pop(p);
	pila_pop(p);
	if(pila_vacia(p))printf("esta vacia\n");
	
	
	}
