#include "sortg.h"

void swap(void* a , void* b){
	//printf("")
	int p = *(int*)a;
	*(int*)a  = *(int*)b;
	*(int*)b = p;
	}




void bsortg(void *base, int tam, size_t size, CmpFunc cmp){
	if(tam == 1)return;
	size_t j = size;
	int ordenado = 0;
	for(int i = 1; i < tam-1 && !ordenado ;i++){
		ordenado = 1;
		for(int k = 0; k < tam-1;k++){

			if( cmp( (base+(j*k)) ,   (base + (j*(k+1) )))){
			swap(base + (j*k) , base + (j*(k+1) ));
			ordenado = 0;			
			  }
		}
	}
}


void ssortg(void *base, int tam, size_t size, CmpFunc cmp){
	if(tam < 2)return;
	size_t j = size;
	int ordenado = 0, contador = 0;
	while(tam > 1 && !ordenado){
		void* mayor = base;//Mayor hasta ahora
		ordenado = 1;
		for(int k = 0; k < tam-1;k++){
			contador++;
			printf("vale %d\n",contador);
			if(cmp(base + (k*j), base + ((k+1)*j))){
				swap( base + (k*j), base + ((k+1)*j)); 
				ordenado = 0;
			  }
		   }
		tam--;
		
		}
	
	}



void isortg(void *base, int tam, size_t size, CmpFunc cmp){
	if(tam < 2)return;
	size_t j = size;
	int ordenado = 0, contador = 0, t, k = 1, i;
	for(; k < tam; k++){
		t = k;
		i= t-1;
		while(t > 0 && cmp( base + (j*i), base + (j*t) ) ){
			swap( base + (j*t), base + (j*i)  );
			t--, i = t - 1;
			}
		}
		
	   
	}













			//printf("%d %d\n",*(int*)(base+(j*i)),*(int*)(base + (j*(i+1) )));
