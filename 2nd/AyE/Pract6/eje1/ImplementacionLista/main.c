#include "ordsel.h"

int fun_comparar(void* a, void* b){
	//printf("%d %d\n",*(int*)a,*(int*)b);
	return *(int*)a > *(int*)b; 
	}



int main(){
	srand(time(NULL));
	List lista = lista_crear();
	for(int i = 0;i < 3;i++){
		lista = lista_agregar(lista,rand()%50+1);
		}
	/*lista = lista_agregar(lista,10);
	lista = lista_agregar(lista,4);
	lista = lista_agregar(lista,4);*/
	lista_imprimir(lista);
	printf("\n");
	lista = select_sort(lista, fun_comparar);
	lista_imprimir(lista);
	}
