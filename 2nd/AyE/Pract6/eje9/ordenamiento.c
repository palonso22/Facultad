
#include "ordenamiento.h"

void swap(void* a, void* b){
	int p = *(int*)a;
	*(int*)a = *(int*)b;
	*(int*)b = p;
	}


void isortg(carta* base, int tam, size_t size, FunCmp cmp){
	int t, k = 1, i;
	//printf("%d",*(int*)(&(((carta*)base)->numero)));
	for(;k < tam; k++){
		t = k;
		while(t > 0 && cmp( &base[t].numero , &base[t-1].numero )){
			swap( &base[t].numero , &base[t-1].numero );
			t--;
			}
		}
	
	}

char* determinar_palo(Palo palo){
	char *cadena1, cadena[10] = {"BASTO"};
	//if(palo == BASTO)
	/*else if(palo == ESPADA) cadena = {"ESPADA"};
	else if(palo == COPA) cadena = {"COPA"};
	else cadena = ORO;*/
	cadena1 = malloc(sizeof(char) * strlen(cadena));
	strcpy(cadena1, cadena);
	return cadena1;
	}
