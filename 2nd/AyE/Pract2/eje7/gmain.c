#include "glist.h"
#include <time.h>

void imprimir_enteros(void* dato){

	printf("%d ",*(int*)dato);
}

int glist_igualdad(void* a, void* b){
	return *(int*)a==*(int*)b;
}

int glist_mayor(void* a, void* b){
	return *(int*)a>*(int*)b;
}


int main(){
	srand(time(NULL));
	GList listaA=glist_crear(), listaB=glist_crear();
	for(size_t i=0;i<8;i++){
		int* elto=malloc(sizeof(int));
		*elto=rand()%100+1;
		listaA=glist_agregar_final(listaA,elto);
	}

	//listaA=glist_ingresar();


	glist_recorrer(listaA,imprimir_enteros);
	puts("");
	puts("");

	listaA=glist_ordenar(listaA,glist_mayor);
	
	glist_recorrer(listaA,imprimir_enteros);
	puts("");
	puts("");


	/*size_t pos=8;
	int* elto=malloc(sizeof(int));
	*elto=999;
	listaA=glist_ingresar_pos(listaA,elto,pos);*/

	
	/*for(size_t i=0;i<12;i++){
		int* elto=malloc(sizeof(int));
		*elto=rand()%100+1;
		listaB=glist_agregar_final(listaB,elto);
	}*/

	/*glist_recorrer(listaB,imprimir_enteros);
	puts("");
	puts("");

	listaA=glist_intercalar(listaA,listaB);

	glist_recorrer(listaA,imprimir_enteros);
	puts("");
	puts("");*/
	
}
