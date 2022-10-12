#include "ej7.h"








int main(){
	srand(time(NULL));
	BHeap h=bheap_crear();
	for(int i=0;i<7;i++){
		bheap_insertar(h,rand()%50+1);
		}
	bheap_imprimir(h);	
	
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);
	bheap_eliminar_minimo(h);


	}



