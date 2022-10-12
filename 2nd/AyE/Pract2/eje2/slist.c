#include "slist.h"
#include <stdlib.h>
#include <stdio.h>

int menor(int a, int b){
  return a<b;
}

int mayor(int a, int b){
  return a>=b;
}

int igualdad(int a, int b){
  return a==b;
}


SList slist_crear() {
  return NULL;
}

void slist_destruir(SList lista) {
  SNodo *nodoAEliminar;
  while (lista != NULL) {
    nodoAEliminar = lista;
    lista = lista->sig;
    free(nodoAEliminar);
  }
}

int slist_vacia(SList lista) {
  return lista == NULL;
}

SList slist_agregar_final(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = NULL;

  if (lista == NULL)
    return nuevoNodo;

  SList nodo = lista;
  for (;nodo->sig != NULL;nodo = nodo->sig);
  /* ahora 'nodo' apunta al ultimo elemento en la lista */

  nodo->sig = nuevoNodo;
  return lista;
}

SList slist_agregar_inicio(SList lista, int dato) {
  SNodo *nuevoNodo = malloc(sizeof(SNodo));
  nuevoNodo->dato = dato;
  nuevoNodo->sig = lista;
  return nuevoNodo;
}

void slist_recorrer(SList lista, FuncionVisitante visit) {
  if(lista==NULL){
    printf("Lista Vacia");
    return;
  }
  for (SNodo *nodo = lista; nodo != NULL; nodo = nodo->sig)
    visit(nodo->dato);
}

int slist_longitud(SList lista){
  int i=0;
  if(lista==NULL)return i;
  for(;lista->sig!=NULL;lista=lista->sig,i++);
  return ++i;
}

void slist_concatenar(SList lista, SList lista2){
  for(;lista2->sig!=NULL;lista2=lista2->sig);
    lista2->sig=lista;
}

int slist_obtener(SList lista, size_t pos){
  for(size_t i=0;i<pos-1;i++,lista=lista->sig); 
  return lista->dato;
}  

void slist_insertar(SList lista,size_t pos, int dato){
  for(size_t i=0;i<pos-1;i++,lista=lista->sig); 
   lista->ultimo=dato;
}

SList slist_crear_insertar(size_t capacidad){
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






/*SList slist_ordenar(SList lista,Comparacion comparar){
  //Si la lista es vacia no se modifica
  if(!lista)return lista;
  SList temp=lista->sig;

  //Primer caso: comparar primero y segundo
  if(comparar(lista->dato,temp->dato)){
    printf("%d %d\n", lista->dato,temp->dato);
    lista->sig=temp->sig;
    temp->sig=lista;
    lista=temp;
    //Comparar el nodo actual con el resto
  SList aux=lista; 
  temp=aux->sig;
  for(;aux->sig!=NULL;aux=aux->sig){
    //printf("%d\n",aux->dato);
    if(comparar(temp->dato,aux->sig->dato)){
      printf("%d %d\n", temp->dato,aux->sig->dato);
      aux->sig=aux->sig->sig;
      temp->sig=aux->sig->sig;
      aux->sig=temp;
    }
  }
  //(comparar(aux->dato,temp->dato))


  return lista;
  
}
  }*/

/*SList slist_ordenar(SList lista,Comparacion comparar){
  //Si la lista es vacia no se modifica
  if(!lista)return lista;
  //Tomamos un elto y recorremos la lista
  //Si encontramos una mayor, dejemos el anterior y tomamos ese
  //El elto que llegue al final de la lista lo mandamos a una lista nueva
  SList listaOrdenada=slist_crear(), temp=lista;
  while(lista!=NULL){
    SList aux=temp->sig;
    for(;aux!=NULL&&(comparar(temp->dato,aux->dato));aux=aux->sig){
      printf("%d %d\n",temp->dato,aux->dato);

    }
     if(aux==NULL){
        listaOrdenada=slist_agregar_inicio(listaOrdenada,temp->dato);
        lista=slist_eliminar_dato(lista,temp->dato);
        temp=lista;
      }
      else{
        temp=aux;
      } 
  }
  return listaOrdenada;
}*/

SList slist_ordenar(SList lista,Comparacion comparar){
  if(!lista)return NULL;
    SList temp=lista, aux=lista->sig;
    for(;aux!=NULL&&comparar(temp->dato,aux->dato);aux=aux->sig);
    if(aux!=NULL){
      lista=slist_intercambiar(lista,temp->dato,aux->dato);
      //slist_ordenar(lista,comparar);
    }
    return lista;

}

SList slist_intercambiar(SList lista, int datoA, int datoB){
  if(!lista)return NULL;
  if(!lista->sig)return lista;
  SList temp=lista;
  if(lista->dato==datoA){
    SList temp=lista;
    for(;lista->sig!=NULL&&lista->sig->dato!=datoB;lista=lista->sig);
    if(!lista->sig && lista->dato==datoB){
      SList aux
    }
    //el que apunta a datoB tiene que apuntar a datoA
    //el que es apuntado por datoB tiene que ser apuntado por datoA
    //el que es apuntado por datoA tiene que ser apuntado por datoB
    
    else{
      SList aux=lista->sig->sig, aux2=lista->sig;
      aux2->sig=temp->sig;
      lista->sig=temp;
      temp->sig=aux;
    }
    return aux2;
  }
  /*/SList temp2=lista;
  for(;temp!=NULL&&;)*/



  
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
}
















