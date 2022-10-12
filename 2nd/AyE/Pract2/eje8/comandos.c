#include "glist.h"
#include <string.h>

//Funciones comando

aGList comandos(char* comando,int arg1, int arg2,aGList estructArreglo){
	if(!strcmp(comando,"crear")){
		estructArreglo=malloc(sizeof(_aGList));
		estructArreglo->tamanio=(size_t)arg1;
		GList* aListas=comando_crear_listas((size_t)arg1);
		estructArreglo->aListas=aListas;
		return estructArreglo;
	}
	//else if(!strcmp(comando,"destruir")){;}
	//else if(!strcmp(comando,"imprimir")){;}
	//else if(!strcmp(comando,"agregar_final")){printf("aca tambien\n");;}
	//else if(!strcmp(comando,"agregar_inicio")){;}
	/*else if(!strcmp(comando,"agregar_pos")){;}
	else if(!strcmp(comando,"longitud")){;}
	else if(!strcmp(comando,"concatenar")){;}
	else if(!strcmp(comando,"eliminar")){;}
	else if(!strcmp(comando,"contiene")){;}
	else if(!strcmp(comando,"indice")){;}
	else if(!strcmp(comando,"intersecar")){;}	
	else if(!strcmp(comando,"ordenar")){;}*/
	else{printf("Error\n");}	


}




GList* comando_crear_listas(size_t tamanio){
	GList* aListas=malloc(sizeof(GList)*tamanio);
	for(size_t i=0;i<tamanio;i++){
		aListas[i]=glist_crear();
	}
	return aListas;
}

