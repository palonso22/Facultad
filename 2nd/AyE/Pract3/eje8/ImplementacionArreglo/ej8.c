#include "ej8.h"

void aux_mover_arreglo(PCola cola, int pos){
	//iterar desde el primero hasta la pos dada
	//desplazando los eltos una pos
	//notar que si estamos en la pos 0
	//deberemos hacer una asignacion implicita
	for(int i=cola->primero;i!=pos;i--){
		if(i==0){
			cola->datos[0]=cola->datos[MAX_COLA-1];
			i=MAX_COLA-1;
			}
		cola->datos[i]=cola->datos[i-1];
		}
	}


int aux_obtener_pos(PCola cola,int dato){
	int i=cola->primero-1,pos=cola->primero;
	if(dato==3)printf("\n%d\n",i);
	if(i==-1)i=MAX_COLA-1;
	//iterar mientras que dato sea menor al elto
	//del arreglo o mientras no se llegue al final de la cola
	//tomando como pos los valores de i que pasen la condicion
	for(;i!=cola->ultimo&&cola->datos[i]>dato;pos=i,i--){
		if(dato==3)printf("\naca entra %d %d %d\n",cola->datos[i],dato,i);
		//si la i es 0 y se debe seguir iterando reiniciar
		if(i==0){
			i=MAX_COLA;
		 }
		}
	//si para en el ultimo compararlo
	if(i==cola->ultimo&&cola->datos[cola->ultimo]>dato)return cola->ultimo;
	return pos;
	}


PCola cola_prioridad_crear(){
	PCola cola=malloc(sizeof(struct _ArregloCola));
	cola->primero=-1;
	cola->ultimo=0;
	return cola;
	}




int cola_prioridad_es_vacia(PCola cola){
	return (cola->primero==-1);
	}

void cola_prioridad_insertar(PCola cola, int dato){
	//cola vacia
	if(cola_prioridad_es_vacia(cola)){
		++cola->primero;
		cola->datos[0]=dato;
		return;
		}
	++cola->primero;
	//si llega al maximo de la cola vuelve a 0
	if(cola->primero==MAX_COLA)cola->primero=0;
	//si primero pisa al ultimo la cola esta llena
	assert((cola->primero==cola->ultimo)==0);
	//buscar en que posicion insertar el nuevo dato
	int pos=aux_obtener_pos(cola,dato);
	//si la pos no es la primera
	//mover el arreglo 
	if(pos!=cola->primero){
		aux_mover_arreglo(cola,pos);
		}
	//insertar el dato
	cola->datos[pos]=dato;
	}

void cola_prioridad_eliminar_minimo(PCola cola){
	if(cola_prioridad_es_vacia(cola))return;
	 ++cola->ultimo;
	}
	
void cola_prioridad_imprimir(PCola cola){
	for(int i=cola->ultimo;;i++){
		if(i==MAX_COLA)i=0;
		printf("%d ",cola->datos[i]);
		if(i==cola->primero)break;
		}
	}
	

