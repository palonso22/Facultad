
#include "ej7.h"















BHeap bheap_crear(){
	BHeap h=malloc(sizeof(struct _BHeap));
	h->nelemts=0;
	return h;
	}
	
int bheap_es_vacio(BHeap h){
	return h->nelemts==0;
	}


void bheap_imprimir(BHeap h){
	if(!h->nelemts){printf("vacio\n");return;}
	for(int i=0,k=1;i<h->nelemts;i++){
		printf("%d ",h->datos[i]);
		if(i+2==pow(2,k)){printf("\n");++k;}
		}
	printf("\n");
	}

void aux_hundir(int arreglo[],int nelemts,int pos){
	//calcular pos del hijo izq
	int i=2*pos+1;
	//comprobar que existe un hijo
	if(i>nelemts-1)return;
	//comparar con el hijo izq
	if(arreglo[pos]>arreglo[i]){
		int aux=arreglo[pos];
		arreglo[pos]=arreglo[i];
		arreglo[i]=aux;
		//comparar el nuevo hijo con el resto de descendientes
		aux_hundir(arreglo,nelemts,i);
		//comparar el nuevo padre con el otro hijo
		aux_hundir(arreglo,nelemts,pos);
		}
	//sino comparar si existe
	//con el hijo derecho
	else if(i+1<nelemts-1 && arreglo[pos]>arreglo[i+1]){
		i++;
		int aux=arreglo[pos];
		arreglo[pos]=arreglo[i];
		arreglo[i]=aux;
		aux_hundir(arreglo,nelemts,i);
		aux_hundir(arreglo,nelemts,pos);
		}
	return;
	}
	

void bheap_eliminar_minimo(BHeap h){
	//caso heap vacio
	if(!h->nelemts){
		printf("esta vacio");
		return;
		}
	h->nelemts--;
	//si el heap solo tiene un elto no modificar mas nada
	if(!h->nelemts)return;
	h->datos[0]=h->datos[h->nelemts];
	//bheap_imprimir(h);
	aux_hundir(h->datos,h->nelemts,0);
	printf("\n");
	bheap_imprimir(h);
	/*aux_hundir(h->datos,h->nelemts,0);
	printf("\n");
	bheap_imprimir(h);*/
	}

void bheap_destruir(BHeap h){
	free(h);
	}
	
void aux_flotar(int arreglo[],int pos){
	if(!pos)return;
	//inicializar el i en la pos
	// del primer padre
	int i = (pos- 1) / 2;
	//comparar con el padre
	//si es menor los intercambiamos
	if(arreglo[i]>arreglo[pos]){
		int aux=arreglo[i];
		arreglo[i]=arreglo[pos];
		arreglo[pos]=aux;
		aux_flotar(arreglo,i);
		}
	return;
	}


	
	
	
void bheap_insertar(BHeap h,int dato){
	if(!h->nelemts){
		h->nelemts++;
		h->datos[0]=dato;
		return;
		}
	h->nelemts++;
	assert(h->nelemts>MAX_HEAP==0);
	h->datos[h->nelemts-1]=dato;
	aux_flotar(h->datos,h->nelemts-1);
	}
