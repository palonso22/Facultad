#include "ej8.h"

int aux_retornar_pos(int arreglo[],int dato, int p){
	int i=(p-1)/2;
	for(;i!=0&&arreglo[i]>dato;p=i,i=(i-1)/2);
	if(!i&&arreglo[i]>dato)return 0;
	if(dato==3)printf("este es%d\n",p);
	return p;
	}
	
int aux_mover_arreglo(int arreglo[],int pos,int nelemts){
	for(int i=pos,k=0;i<nelemts;i++,k++){
		arreglo[nelemts-k]=arreglo[nelemts-(1+k)];
		}
	}



PCola cola_prioridad_crear(){
	PCola cola=malloc(sizeof(struct _HCola));
	cola->nelemts;
	}


int cola_prioridad_es_vacia(PCola cola){
	return cola->nelemts==0;
	}


void cola_prioridad_insertar(PCola cola, int dato){
	//si la cola es vacia el dato
	//va al inicio de la cola
	if(cola_prioridad_es_vacia(cola)){
		cola->nelemts++;
		cola->heap[0]=dato;
		return;
		}
	//chequear que no haya un desborde
	assert(cola->nelemts+1>MAX_HEAP==0);
	cola->nelemts++;
	int pos=aux_retornar_pos(cola->heap,dato,cola->nelemts-1);
	aux_mover_arreglo(cola->heap,pos,cola->nelemts);
	cola->heap[pos]=dato;
	return;
	}
	
void cola_prioridad_imprimir(PCola h){
	if(cola_prioridad_es_vacia(h)){printf("vacio\n");return;}
	for(int i=0,k=1;i<h->nelemts;i++){
		printf("%d ",h->heap[i]);
		if(i+2==pow(2,k)){printf("\n");++k;}
		}
	printf("\n");
	}
