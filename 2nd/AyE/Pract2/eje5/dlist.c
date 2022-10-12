#include "dlist.h"
#include <stdlib.h>
#include <stdio.h>

int menor(int a, int b){
  return a<b;
}

int mayor(int a, int b){
  return a>b;
}

int igualdad(int a, int b){
  return a==b;
}


SList dlist_crear() {
  return NULL;
}

void dlist_destruir(SList lista) {
  if(!lista)return;
  SNodo *nodoAEliminar;
  SNodo *aux=lista;
  while (lista->sig!=aux) {
    nodoAEliminar = lista;
    lista = lista->sig;
    free(nodoAEliminar);
  }
  free(aux);
}


SList dlist_agregar_final(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;

  if (!lista){
    nuevoNodo->sig = nuevoNodo;
    nuevoNodo->ant=nuevoNodo;
    return nuevoNodo;
  }
  SList aux=lista;
  lista->ant->sig = nuevoNodo;
  nuevoNodo->ant=aux->ant;
  nuevoNodo->sig=lista;
  lista->ant=nuevoNodo;
  return lista;
}

SList dlist_agregar_inicio(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  if(!lista){
    nuevoNodo->sig=nuevoNodo;
    nuevoNodo->ant=nuevoNodo;
    return nuevoNodo;
  }
  lista->ant->sig = nuevoNodo;
  nuevoNodo->ant=lista->ant;
  nuevoNodo->sig=lista;
  lista->ant=nuevoNodo;
  return nuevoNodo;
}

void dlist_recorrer(SList lista, FuncionVisitante visit,DListOrdenDeRecorrido orden) {
  if(!lista){
    printf("Lista Vacia");
    return;
  }
  visit(lista->dato);
  for (SNodo *nodo =lista->sig; nodo != lista; nodo = nodo->sig)
    visit(nodo->dato);
}

int dlist_longitud(SList lista){
  int i=0;
  if(!lista)return i;
  SList aux=lista;
  for(;lista->sig!=aux;lista=lista->sig,i++);
  return ++i;
}

void dlist_concatenar(SList lista, SList lista2){
  if(!lista || !lista2)return ;
  SList aux=lista,aux2=lista2->ant;


  //El ultimo de lista apunta a lista2
  lista->ant->sig=lista2;
  printf("%d\n", lista->ant->sig->dato);

  //El siguiente del  ultimo de lista2 es el primero de lista 
  lista2->ant->sig=lista;
  printf("%d\n", lista2->ant->sig->dato);

  //El anterio de lista2 es el ultimo de lista
  lista2->ant=aux->ant;
  printf("%d\n", lista2->ant->dato);

  //El anterio de lista es el ultimo de lista 2
  lista->ant=aux2;
  printf("%d\n", aux2->ant->dato);

}
  

int cslist_insertar(SList lista, int dato, int datoInsert){
  if(!lista)return 0;
  SList aux=lista;
  if(lista->dato==dato){
    lista->dato=datoInsert;
    return 1;
  }
  for(lista=lista->sig;lista!=aux && lista->dato!=dato;lista=lista->sig);
  if(lista==aux)return 0;
  lista->dato=datoInsert;
  return 1;

}




/*SList slist_crear_insertar(size_t capacidad){
  SList lista = slist_crear();
  int decision=0, elto=0;
  for(size_t i=0;i<capacidad;i++){
    printf("1 para agregar eltos al principio de la lista\n");
    printf("2 para agregar eltos al final:\n");
    scanf("%d",&decision);
    switch(decision){
      case 1:
        printf("Ingrese elto:");
        scanf("%d",&elto);
        lista = slist_agregar_inicio(lista, elto);
        break;
      case 2:
        printf("Ingrese elto:");
        scanf("%d",&elto);
        lista=slist_agregar_final(lista,elto);
        break;
      default:
        printf("Opcion incorrecta intente de nuevo.\n");
        i--;
    }
  }
  return lista;
}

void slist_eliminar_pos(SList lista,size_t pos){
  SNodo *temp;
  for(size_t i=0;i<pos-2;lista=lista->sig,i++);
  temp=lista->sig;
  lista->sig=lista->sig->sig;
  free(temp);
}

SList slist_eliminar_dato(SList lista, int dato){
  //Si la lista es vacia no hacemos ningun cambio
  if(lista==NULL)return lista;
  SList temp=lista;

  //Miramos si el dato está en el comienzo de la lista
  if(temp->dato==dato){
    lista=lista->sig;
    free(temp);
    return lista;
  }


  
  //Nos movemos por la lista con un temp hasta llegar al último nodo
  // o al que contiene el dato buscado
  for(;temp->sig!=NULL&&lista->dato!=dato&&temp->sig->dato!=dato;temp=temp->sig);
  
  //Si llegamos al final de la lista el dato
  // no se encuentra
  if(temp->sig==NULL)return lista;
  
  //Si encontramos el dato apuntamos
  //el nodo anterio al nodo con el dato
  // al nodo siguiente al nodo con el dato
  SList nodoSigAlElim=temp->sig->sig;
  free(temp->sig);
  temp->sig=nodoSigAlElim;
  return lista;
}


int slist_contiene(SList lista, int dato){
  //Si la lista es vacia no ahi nada que comprobar
  if(lista==NULL)return 0;
  
  //Recorremos la lista hasta que no haya un sig
  //O hasta que estemos parados sobre el nodo con el dato
  for(;lista->sig!=NULL && lista->dato!=dato;lista=lista->sig);

  //Verificamos que condicion se violo para salir del bucle
  if(lista->dato!=dato)return 0;
  return 1;
}

int contiene_custom(int a, int b){
  return a==b;
}

int slist_indice(SList lista,int dato){
  int i=0;
  for(;lista->sig!=NULL&&lista->dato!=dato;lista=lista->sig,i++);
  if(lista->sig==NULL&&lista->dato!=dato)return -1;
  return i;
}

SList slist_criterio(SList lista,SList lista2,Comparacion comparar) { 
  if(comparar(slist_longitud(lista),slist_longitud(lista2)))return lista;
  return lista2;
}





SList slist_intersecar(SList lista, SList lista2){
  if(lista==NULL || lista2==NULL)return NULL;
  
  //Creamos una lista interseccion
  SList listIntersec=slist_crear();
  
  //Chequeamos que elementos se encuentran en ambas listas
  for(;lista!=NULL;lista=lista->sig){
    if(slist_contiene(lista2,lista->dato)){
      listIntersec=slist_agregar_final(listIntersec,lista->dato);
    }
  }
  
  return listIntersec;
}


SList slist_intersecar_custom(SList lista, SList lista2, Igual contiene){
  if(lista==NULL || lista2==NULL)return NULL;
  
  //Creamos una lista interseccion
  SList listIntersec=slist_crear(), temp;
  
  //Chequeamos que elementos se encuentran en ambas listas
  for(;lista!=NULL;lista=lista->sig){
    temp=lista2;
    for(;temp!=NULL;temp=temp->sig){
      if(contiene(lista->dato,temp->dato)){
        listIntersec=slist_agregar_final(listIntersec,lista->dato);
      }  
    } 
  }
  return listIntersec;
}






void slist_ordenar(SList lista,Comparacion comparar){
  //Si la lista es vacia no se modifica
  if(lista==NULL)return;

  //Tomamos un elto de la lista y vamos
  // comparandolo con el elto siguiente
  for(;lista->sig!=NULL;lista=lista->sig){
    for(SList temp=lista;temp->sig!=NULL;temp=temp->sig){
      
      //Si la comparacion es valida
      // intercambiamos sus punteros
      if(comparar(lista->dato,temp->sig->dato)){
        SList aux=lista->sig;
        lista->sig=temp->sig->sig;
        temp->sig->sig=aux;
      }
    
    }  
  }
}


SList slist_reverso(SList lista){
  if(lista==NULL)return NULL;
  SList temp=slist_crear();
  for(;lista!=NULL;lista=lista->sig){
    temp=slist_agregar_inicio(temp,lista->dato);
  }
  slist_destruir(lista);
  return temp;
}


SList slist_intercalar(SList lista,SList lista2){
  int longLista=slist_longitud(lista),longLista2=slist_longitud(lista2);

  //Si una lista es vacia devolvemos la otra
  if(longLista==0 || longLista2==0)return slist_criterio(lista,lista2,mayor);

  //Agregamos eltos de una forma intercalada hasta que 
  //lleguemos al final de una de las dos
  SList listIntercal=slist_crear();
  for(;lista!=NULL&&lista2!=NULL;lista=lista->sig,lista2=lista2->sig){
    listIntercal=slist_agregar_final(listIntercal,lista->dato);
    listIntercal=slist_agregar_final(listIntercal,lista2->dato);
  }
  if(longLista==longLista2){
    return listIntercal;
  }

  //Si una lista tiene mayor long que la otra
  // agregamos los eltos restantes
  SList listaMayor=slist_criterio(lista,lista2,mayor);

    for(;listaMayor!=NULL;listaMayor=listaMayor->sig){
      listIntercal=slist_agregar_final(listIntercal,listaMayor->dato);
    }
  return listIntercal;
}*/
















