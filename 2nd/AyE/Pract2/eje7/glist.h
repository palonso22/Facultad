#ifndef __SLIST_H__
#define __SLIST_H__

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>



typedef struct _GNodo{
	void* dato;
	struct _GNodo* sig;
}GNodo;

typedef GNodo* GList;

typedef void (*FVisitante)(void* dato);
typedef int (*Comparacion)(void* a, void* b);

/**
 * Devuelve una lista vacía.
 */
GList glist_crear();

/*Determina si un elto es igual que otro
glist_igualdad:GList->void*->void*->int*/
int glist_igualdad(void* a, void* b);


/*Agrega un elto al inicio
glist_ingresar_inicio:GList->dato->GList*/
GList glist_agregar_inicio(GList lista, void* dato);

/*Agrega un elto al final.
glist_ingresar_final:GList->dato->GList*/
GList glist_agregar_final(GList lista, void* dato);

/*Recorrer los eltos con una funcion
glist_recorrer:GList->visitante->void*/
void glist_recorrer(GList listaA,FVisitante visitante);


/*Destruye una lista
glist_destruir:GList->void*/
void glist_destruir(GList listaA);

/*Retorna la longitud de una lista
glist_longitud:GList->size_t*/
size_t glist_longitud(GList listaA); 

/*Permite ingresar una lista al usuario
slist_ingresar:void->GList*/
GList glist_ingresar();

/*Permite al usuario ingresar un elto en una posicion arbitraria
glist_ingresar_pos:GList->void*->GList*/
GList glist_ingresar_pos(GList listaA, void* dato,size_t pos);

/*Concatena dos listas
glist_concantena:Glist->Glist->Glist*/
GList glist_concatenar(GList listaA,GList listaB);

/*Devuelve la interseccion entre dos listas
glist_interseca:GList->GList->GList*/
GList glist_interseca(GList listaA,GList listaB, Comparacion igualdad);

/*Determina si un elto se encuentra en la lista
glist_contiene:GList->void*->int*/
int glist_contiene(GList listaA, void* dato,Comparacion igualdad);

/*Devuelve la primer ocurrencia de un elto en la lista
glist_indice:GList->void*->int*/
size_t glist_indice(GList listaA, void* dato, Comparacion igualdad);

/*Ordena una lista
glist_ordena:GList->Comparacion->GList*/
GList glist_ordenar(GList listaA,Comparacion igualdad);

/*Elimina un elto de la lista
glist_eliminar:GList->void*->void*/
GList glist_eliminar(GList listaA,void* dato, Comparacion igualdad);


/*Revierte una lista
glist_reverso:GList->GList*/
GList glist_reverso(GList listaA);

/*Intercala dos listar
glist_intercalar:GList->GList->GList*/
GList glist_intercalar(GList listaA, GList listaB);





















#endif /* __SLIST_H__ */
