#include "heap.h"






int main(){
	clock_t t_ini, t_fin;
	//srand(time(NULL));
	double secs;
	t_ini = clock();
	Heap h = heap_crear();
	for(int i = 0;i < MAX;i++){
		heap_agregar(h,rand()%10+5);
		}
	heap_imprimir(h);
	heap_eliminar_minimo(h);
	puts("");
	heap_imprimir(h);
	
	heap_eliminar_minimo(h);
	puts("");
	heap_imprimir(h);	
	heap_destruir(h);
	t_fin = clock();
	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
	printf("%.16g milisegundos\n", secs * 1000.0);
	}

