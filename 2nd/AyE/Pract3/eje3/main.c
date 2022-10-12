#include "eje3.h"
#include <stdio.h>
#include <time.h>
#include <stdlib.h>



int main(){
	srand(time(NULL));
	Pila p=pila_crear();
	for(int i=0;i<5;i++){
		p=pila_push(p,rand()%10+1);
		}
	pila_imprimir(p);
	printf("\n");
	printf("%d el que esta en la cima\n",pila_top(p));
	/*for(int i=0;i<5;i++){
		p=pila_pop(p);
		}*/
	pila_destruir(p);
	pila_imprimir(p);
	}
