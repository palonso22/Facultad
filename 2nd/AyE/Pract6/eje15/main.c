#include "msort.h"



int main(){
	//srand(time(NULL));
	Lista l = lista_crear();
	for(int i = 0;i < 4;++i){
		l = lista_agregar(l,rand()%20+1);
		}
	lista_imprimir(l);
	l = msort(l);
	puts("");
	lista_imprimir(l);
	
	}
