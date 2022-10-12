#ifndef __SLIST_H__
#define __SLIST_H__

#include <stddef.h>

typedef void (*FuncionVisitante) (int dato);
typedef int (*Comparacion) (int a,int b);
typedef int (*Igual) (int dato,int dato2);



typedef struct _SNodo {
  int dato;
  struct _SNodo *sig;
  struct _SNodo *ant;
} SNodo;

typedef SNodo *SList;

typedef enum{
	char recorrido_hacia_adelante;
	char recorrido_hacia_atras;
}DlistOrdenRecorrido;


/*Determina el menor de dos numeros
menor:int->int->int*/
int menor(int a, int b);

/*Determina el mayor de dos numeros
mayor:int->int->int*/
int mayor(int a, int b);

/*Determina si dos números son iguales
igualdad:int->int->int*/
int igualdad(int a, int b);
/**
 * Devuelve una lista vacía.
 */
SList dlist_crear();

/**
 * Destruccion de la lista.
 */
void dlist_destruir(SList lista);
/**
 * Determina si la lista es vacía.
 */
int slist_vacia(SList lista);

/**
 * Agrega un elemento al final de la lista.
 */
SList dlist_agregar_final(SList lista, int dato);

/**
 * Agrega un elemento al inicio de la lista.
 */
SList dlist_agregar_inicio(SList lista, int dato);

/**
 * Recorrido de la lista, utilizando la funcion pasada.
 */
void dlist_recorrer(SList lista, FuncionVisitante visit);




/*Devuelve la longitud de una lista
  clongitud:SList->int*/
int dlist_longitud(SList lista);

/*Concatena dos listas modificandolas
	concatenar:SLlist->SLlist->none*/
void dlist_concatenar(SList lista, SList lista2);

/*Obtiene un dato en una posicion arbitraria
	slist_obtener: SList->size_t->int*/
int slist_obtener(SList lista, size_t pos);



/*Inserta un dato en una posicion arbirtraria
 slist_insertar:SList->size_t->int->void*/
int cslist_insertar(SList lista, int dato,int datoInsert);

/*Permite crear e ingresar una lista
slist_crear_insertar:size_t->SList*/
SList slist_crear_insertar(size_t capacidad);


/*Permite eliminar un dato en la lista en una posicion arbitraria
slist_eliminar_pos:SList->size_t->none*/
void slist_eliminar_pos(SList lista,size_t pos);

/*Dado un dato, eliminar al primer nodo que lo contiene
slist_eliminar_dato:SList->int->SList*/
SList slist_eliminar_dato(SList lista, int dato);

/*Determina si un dato se encuentra en algún nodo de la lista
slist_contiene:SList->int->int*/
int slist_contiene(SList lista, int dato);

/*Determina si dos enteros son iguales
contiene_custom:int->int->int*/
int contiene_custom(int a, int b);


/*Devuelve la posición de la primera ocurrencia del
elemento dato si el mismo está en la lista dada, -1 en caso que no esté.
slist_indice:SList->int->int*/
int slist_indice(SList lista,int dato);

/*Dado un criterio devuelve una lista
slist_menor_long:SList->SList->SList*/
SList slist_criterio(SList lista,SList lista2, Comparacion comparar);

/*Devuelve una nueva lista cuyos eltos están en ambas listas.
slist_intersecar:SList->SList->SList*/
SList slist_intersecar(SList lista, SList lista2);


/*Devuelve una nueva lista cuyos eltos están en ambas listas.
slist_intersecar:SList->SList->Igual->SList*/
SList slist_intersecar_custom(SList lista, SList lista2, Igual contiene);

/*Dada una lista la ordena según algun criterio
slist_ordenar:Slist->Comparacion->none*/	
void slist_ordenar(SList lista,Comparacion comparar);


/*Dada una lista la invierte
slist_reverso:SList->none*/
SList slist_reverso(SList lista);

/*Dadas dos listas las intercala
*/
SList slist_intercalar(SList lista,SList lista2);

#endif /* __SLIST_H__ */
