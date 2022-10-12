#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "alist.h"



lista* lista_crear(size_t tamanio) {
  lista *nueva_lista = (lista*) malloc(sizeof(lista));

  nueva_lista->tamanio = tamanio;
  nueva_lista->datos = (int*) malloc(sizeof(int) * tamanio);
  nueva_lista->siguientes = (int*) malloc(sizeof(int) * tamanio);
  nueva_lista->primero = -1;
  nueva_lista->ultimo = -1;
 
  nueva_lista->usados = (char*) malloc(sizeof(char) * tamanio);
  for (int i = 0; i < tamanio; i++)
    nueva_lista->usados[i] = 0;

  return nueva_lista;
}


void lista_destruir(lista* lista) {
  free(lista->datos);
  free(lista->siguientes);
  free(lista->usados);
  free(lista);

  return;
}


int lista_agregar_final(lista* lista, int nuevo_dato) {

  if (lista->primero == -1) {
    // Lista vacia
    lista->primero = 0;
    lista->ultimo = 0;
    lista->datos[0] = nuevo_dato;
    lista->usados[0] = 1;  
    lista->siguientes[0] = -1;
    return 0;
  }
  
  int posicion = 0;
  while (posicion < lista->tamanio && lista->usados[posicion])
    posicion++;

  if (posicion == lista->tamanio)
    // No podemos insertar, devolver error
    return 1;
  
  // posicion apunta a un lugar vacio, lo usamos para guardar nuevo dato
  lista->datos[posicion] = nuevo_dato;
  lista->usados[posicion] = 1;
  lista->siguientes[lista->ultimo] = posicion;
  lista->ultimo = posicion;
  lista->siguientes[posicion] = -1;
  
  return 0;
}


int lista_agregar_principio(lista* lista, int nuevo_dato) {
  
  if (lista->primero == -1) {
    // Lista vacia
    lista->primero = 0;
    lista->ultimo = 0;
    lista->datos[0] = nuevo_dato;
    lista->usados[0] = 1;  
    lista->siguientes[0] = -1;
    return 0;
  }
  
  int posicion = 0;
  while (posicion < lista->tamanio && lista->usados[posicion])
    posicion++;

  if (posicion == lista->tamanio)
    // No podemos insertar, devolver error
    return 1;
  
  // posicion apunta a un lugar vacio, lo usamos para guardar nuevo dato
  lista->datos[posicion] = nuevo_dato;
  lista->usados[posicion] = 1;  
  lista->siguientes[posicion] = lista->primero;
  lista->primero = posicion;
  
  return 0;
}


void lista_imprimir(lista* lista) {
  int i = lista->primero;

  if (i == -1 || !lista->usados[i]) {
    // Nada que imprimir!
    printf("Lista vacia\n"); 
    return;
  }
  
  do {
    printf("%i ", lista->datos[i]);
    i = lista->siguientes[i];
  } while (i != -1);

  printf("\n");
  
  return;
}




size_t lista_longitud(lista* lista){
  size_t longitud=0;
  if(!lista->primero)return longitud;
  int i=lista->primero;
  do{
    longitud++;
    i=lista->siguientes[i];
  }while(i!=-1);
  return longitud;
}



/*int* arreglo_concat(int* arregloA,int tamanioA,int* arregloB, int tamanioB){
  int* temp=arregloA;
  arregloA=malloc(tamanioA+tamanioB);
  memcpy(arregloA,temp,sizeof(int)*7);i
  free(temp);
  memcpy(arregloA+7,arregloB,sizeof(int)*7);
  free(arregloB);
  return arregloA;
}*/

int* arreglo_concat(int* arregloA,int* arregloB, size_t tamanioA, size_t tamanioB){
  arregloA=realloc(arregloA,(tamanioA+tamanioB)*(sizeof(int)));
  memcpy(arregloA+tamanioA,arregloB,tamanioB*(sizeof(int)));
  return arregloA;
}






/*/void lista_concat(aLista listaA,aLista listaB ){

  //Si la lista es vacia no hacemos modificaciones
  if(listaA->primero==-1||!listaB->primero==-1);

  
  //Modificamos todos los arreglos
  size_t tamanioA=listaA->tamanio,tamanioB=listaB->tamanio;
  listaA->datos=arreglo_concat(listaA->datos,listaB->datos,tamanioA,tamanioB);
  listaA->siguientes=arreglo_concat(listaA->siguientes,listaB->siguientes,tamanioA,tamanioB);
  
  //Modificamos el arreglo usados aparte
  listaA->usados=realloc(listaA->usados,tamanioA+tamanioB);
  memcpy(listaA->usados+tamanioA,listaB->usados,tamanioB);
  
  //Modificamos los siguientes
  listaA->siguientes[listaA->ultimo]=listaB->primero+(int)(tamanioA-1);
  listaA->ultimo=listaB->ultimo;


  //Modificamos el tamanio
  listaA->tamanio=listaA->tamanio+listaB->tamanio;
  for(size_t i=0;i<listaA->tamanio;i++){
    printf("%d %d %d\n",listaA->datos[i],listaA->siguientes[i],listaA->usados[i] );
  }

}*/

void lista_concat(aLista listaA,aLista listaB){
  if(listaB->primero==-1)return;
  int i=listaB->primero;
  do{
    lista_agregar_final(listaA,listaB->datos[i]);
    i=listaB->siguientes[i];
  }while(i!=-1);
}


int lista_insertar(aLista listaA,int dato){
  if(listaA->primero==-1)lista_agregar_principio(listaA,dato);
  size_t i=0;
  for(;i<listaA->tamanio&&listaA->usados[i]!=0;i++){
    printf("aca entro %zu %zu\n",listaA->tamanio, i);
  }
  printf("aca tambien %zu\n",i);
  //if(i==listaA->tamanio)return 1;
  listaA->datos[i]=dato;
  listaA->usados[i]=1;
  listaA->siguientes[i]=-1;
  listaA->siguientes[listaA->ultimo]=i;
  listaA->ultimo=i;
  return 0;
}




