#include "glist.h"
#include <string.h>

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
	aGList estructArreglo;
	char entrada[10], *arrayToken[10],*comando;
	int arg1,arg2;
	size_t i=0;

	printf("Ingrese un comando:");
	gets(entrada);
	arrayToken[i]=strtok(entrada," ");
	while(arrayToken[i]!=NULL){
		i++;
		arrayToken[i]=strtok(NULL," ");
	}
	comando=arrayToken[0];
	arg1=(int)*arrayToken[1]-48;
	if(arrayToken[2]!=NULL)arg2=(int)*arrayToken[2]-48;
	estructArreglo=comandos(comando,arg1,arg2,estructArreglo);
	printf("%zu\n",estructArreglo->tamanio);


}