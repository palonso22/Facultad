#include "glist.h"
#include <stdlib.h>
#include <stdio.h>


//Funciones basicas

GList glist_crear(){
	return NULL;
}


GList glist_agregar_inicio(GList lista,void* dato){
	GNodo* nuevoNodo=malloc(sizeof(GNodo));
	nuevoNodo->dato=dato;
	if(!lista){
		nuevoNodo->sig=NULL;
		return nuevoNodo;
	}
	nuevoNodo->sig=lista;
	return nuevoNodo;
}

GList glist_agregar_final(GList lista, void* dato){
	GNodo* nuevoNodo=malloc(sizeof(GNodo));
	nuevoNodo->dato=dato;
	if(!lista){
		nuevoNodo->dato=dato;
		nuevoNodo->sig=NULL;
		return nuevoNodo;
	}
	GNodo* aux=lista;
	for(;aux->sig!=NULL;aux=aux->sig);
	aux->sig=nuevoNodo;
	nuevoNodo->sig=NULL;
	return lista;
}

void glist_recorrer(GList listaA,FVisitante visitante){
	if(!listaA){
		printf("Esta vacia\n");
		return;
	}
	for(GList aux=listaA;aux!=NULL;aux=aux->sig){
		visitante(aux->dato);
	}
}



void glist_destruir(GList listaA){
	for(;listaA!=NULL;listaA=listaA->sig){
		free(listaA->dato);
		free(listaA);
	}
}


size_t glist_longitud(GList listaA){
	size_t contador=0;
	for(;listaA!=NULL;listaA=listaA->sig,++contador);
	return contador;
}


GList glist_ingresar(){
  GList lista = glist_crear();
  char basura;
  int decision;
  void* elto;
  printf("Desea agregar mas eltos?:");
  scanf("%d",&decision);
  while(decision){
 	printf("Ingrese elto:");
    int* elto=malloc(sizeof(int));
    scanf("%d",elto);
    printf("1/2 para agregarlo al principio/final de la lista:");
    scanf("%d",&decision);
    switch(decision){
      case 1:
        lista=glist_agregar_inicio(lista, elto);
        break;
      case 2:
        lista=glist_agregar_final(lista,elto);
        break;
      default:
        printf("Opcion incorrecta intente de nuevo.\n");
        break;
    }
    printf("Desea agregar mas eltos?:");
    scanf("%c",&basura);	
    scanf("%d",&decision);
    system("clear");

  }
  return lista;
}

GList glist_ingresar_pos(GList listaA, void* dato,size_t pos){
	size_t longitud=glist_longitud(listaA);
	if(pos>longitud || !listaA){
		printf("No se puede ingresar en esa pos o la lista es vacia\n");
		return listaA;
	}
	if(pos==1){
		GList aux=listaA->sig;
		free(listaA->dato);
		free(listaA);
		aux=glist_agregar_inicio(listaA->sig,dato);
		return aux;
	}
	size_t i=0;
	GList aux=listaA,nodo=malloc(sizeof(GNodo));
	nodo->dato=dato;
	for(;i<pos-2;i++,aux=aux->sig);
	nodo->sig=aux->sig->sig;
	free(aux->sig);
	aux->sig=nodo;
	return listaA;
}

GList glist_concatenar(GList listaA, GList listaB){
	GList nodo=listaA;
	for(;nodo->sig!=NULL;nodo=nodo->sig);
	nodo->sig=listaB;
	return listaA;
}

GList glist_interseca(GList listaA, GList listaB,Comparacion igualdad){
	if(!listaA || !listaB)return NULL;
	GList listaIntersec=glist_crear(), aux,nodo=listaA;
	for(;nodo!=NULL;nodo=nodo->sig){
		for(aux=listaB;aux!=NULL;aux=aux->sig){
			if(igualdad(nodo->dato,aux->dato)){
				//printf("%d\n", *(int*)aux->dato);
				listaIntersec=glist_agregar_final(listaIntersec,aux->dato);
			}
		}
	}
	return listaIntersec;
}


int glist_contiene(GList listaA, void* dato,Comparacion igualdad){
	if(!listaA)return 0;
	GList aux=listaA ;
	for(;aux!=NULL&&!(igualdad(listaA->dato,dato));aux=aux->sig);
	return aux!=NULL;
}

size_t glist_indice(GList listaA, void* dato, Comparacion igualdad){
	GList aux=listaA;
	size_t i=0;
	for(;aux!=NULL&&!(igualdad(aux->dato,dato));aux=aux->sig,i++);
	if(!listaA)return -1;
	return i;

}

GList glist_eliminar(GList listaA, void* dato, Comparacion igualdad){
	if(!listaA)return NULL;
	GNodo* nodo=listaA;
	if(igualdad(listaA->dato,dato)){
		nodo=nodo->sig;
		free(listaA);
		return nodo;
	}
	for(;nodo->sig!=NULL&&!(igualdad(nodo->sig->dato,dato));nodo=nodo->sig);
	if(nodo!=NULL){
		GNodo* nodoAEliminar=nodo->sig;
		nodo->sig=nodo->sig->sig;
		free(nodoAEliminar);
	}
	return listaA;	
}



GList glist_ordenar(GList listaA,Comparacion mayor){
	if(!listaA)return NULL;
	GList listaOrdenada=glist_crear(),nodo=listaA;
	while(listaA!=NULL){
		GList aux=nodo->sig;
		for(;aux!=NULL&&(mayor(nodo->dato,aux->dato));aux=aux->sig){
		//printf("%d %d\n",*(int*)nodo->dato,*(int*)aux->dato);
	}
		if(!aux){
			listaOrdenada=glist_agregar_inicio(listaOrdenada,nodo->dato);
			aux=nodo->sig;
			listaA=glist_eliminar(listaA,nodo->dato,glist_igualdad);
			nodo=listaA;
		}
		else nodo=aux;
	}
	return listaOrdenada;
}

GList glist_reverso(GList listaA){
	GList listaReversa=glist_crear();
	for(;listaA!=NULL;listaA=listaA->sig){
		listaReversa=glist_agregar_inicio(listaReversa,listaA->dato);
	}
	return listaReversa;
}


GList glist_intercalar(GList listaA, GList listaB){
	//Si una lista es vacia devolvemos la otra
	if(!listaA||!listaB)return (GList)((uintptr_t)listaA^(uintptr_t)listaB);

	//En una lista nueva ingresamos los datos de ambas listas
	//de una forma intercalada
	GList listaIntercal=glist_crear();
	for(;listaA!=NULL&&listaB!=NULL;listaA=listaA->sig,listaB=listaB->sig){
		listaIntercal=glist_agregar_final(listaIntercal,listaA->dato);
		listaIntercal=glist_agregar_final(listaIntercal,listaB->dato);
	}

	//Si en alguna quedan eltos terminamos de ingresarlos
	GList aux=(GList)((uintptr_t)listaA^(uintptr_t)listaB);
	if(!aux)return listaIntercal;
	for(;aux!=NULL;aux=aux->sig){
		listaIntercal=glist_agregar_final(listaIntercal,aux->dato);
	}
	return listaIntercal;
}



























