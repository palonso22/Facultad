#include "ej7.h"
#include <stdio.h>
#include <time.h>

int main(){
	srand(time(NULL));
	BHeap h=bheap_crear();
	/*bheap_insertar(h,10);
	bheap_insertar(h,2);
	bheap_insertar(h,2);
	bheap_insertar(h,4);
	bheap_insertar(h,10);
	bheap_insertar(h,2);
	bheap_insertar(h,8);
	bheap_insertar(h,8);
	bheap_insertar(h,-1);
	bheap_insertar(h,1);*/
	for(int i=0;i<15;i++){
		bheap_insertar(h,rand()%100+1);
		}
	bheap_imprimir(h);
	/*bheap_eliminar_minimo(h);
	printf("\n");
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_imprimir(h);*/
	//bheap_destruir(h);
	}
