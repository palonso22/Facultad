#ifndef __EJ3_H__
#define __EJ3_H__

#include <stddef.h>

typedef struct lista_ {
  size_t tamanio;
  int *datos;
  int *siguientes;
  char *usados;
  int primero;
  int ultimo;
} lista;

typedef lista* aLista;


lista* lista_crear(size_t);
void lista_destruir(lista*);
int lista_agregar_final(lista*, int);
int lista_agregar_principio(lista*, int);
void lista_imprimir(lista*);

int* arreglo_concat(int* arregloA, int* arregloB,size_t tamanioA,size_t tamanioB);

size_t lista_longitud(lista* lista);

size_t lista_longitud2(lista* lista);

/*Concatena dos listas
lista_concat:lista->lista->void*/
void lista_concat(aLista listaA,aLista listaB );

/*Agrega un elto en una lista en una posicion arbitraria
lista_insertar: lista->int->int*/
int lista_insertar(aLista listaA,int dato);

#endif
