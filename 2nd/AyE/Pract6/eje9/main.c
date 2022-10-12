
#include "ordenamiento.h"
#define tam(a) (sizeof(a)/sizeof(carta))

static int funcion_comparar(void* a, void* b){
	return *(int*)a < *(int*)b;
	}




int main(){
	srand(time (NULL));
	carta cartas[10];
	for(int i = 0; i < 10;i++){
		cartas[i].numero = rand()%12+1;
		cartas[i].palo = BASTO;
		}
	isortg(cartas, tam(cartas), sizeof(carta), funcion_comparar);
	
	for(int i = 0; i < 10;i++){
		printf("%d : %s \n", cartas[i].numero, determinar_palo(cartas[i].palo));
		}
	
	
	
	
	
	}


