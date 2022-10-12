#ifndef __TABLAHASH_H__
#define __TABLAHASH_H__
#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


/**
 * Tipo de las funciones hash a ser consideradas por las tablas hash.
 */
typedef unsigned (*FuncionHash)(void* clave);
typedef int (*FuncionIgualdad)(void* clave1,void* clave2);





/**Estructura para pila**/
typedef struct _Nodo{
	void* dato;
	void* clave;
	struct _Nodo* sig;	
	}Nodo;
	
typedef Nodo* Pila;



/**
 * Casillas en la que almacenaremos los datos de la tabla hash.
 */
typedef struct {
  void* clave;
  Pila pila;
} CasillaHash;

/**
 * Estructura principal que representa la tabla hash.
 */
typedef struct {
  CasillaHash* tabla;
  Pila claves;
  unsigned numElems;
  unsigned capacidad;
  FuncionHash hash;
  FuncionIgualdad iguales;
} TablaHash;

/**
 * Crea una nueva tabla Hash vacía, con la capacidad dada.
 */
TablaHash* tablahash_crear(unsigned capacidad, FuncionHash fun,FuncionIgualdad igualdad);

/**
 * Inserta el dato en la tabla, asociado a la clave dada.
 */
void tablahash_insertar(TablaHash* tabla, void* clave, void* dato);

/**
 * Busca un elemento dado en la tabla, y retorna un puntero al mismo.
 * En caso de no existir, se retorna un puntero nulo.
 */
void* tablahash_buscar(TablaHash* tabla, void* clave);

/**
 * Elimina un elemento de la tabla.
 */
void tablahash_eliminar(TablaHash* tabla, void* clave);

/**
 * Destruye la tabla.
 */
void tablahash_destruir(TablaHash* tabla);


/**Funciones para pila**/

/**Crea una pila**/
Pila pila_crear();


/**Agrega un elto en la pila**/
Pila pila_push(Pila p, void* dato, void* clave);

/**Toma una pila y elimina el último elto**/
Pila pila_pop(Pila p);

/**Devuelve el elto en la cima de la pila**/
void* pila_top(Pila p);


/**Determina si una pila es vacia**/
int pila_vacia(Pila p);

/**Destruye una pila**/
void pila_destruir(Pila p);


/**Imprime una pila**/
void pila_imprimir(Pila p);


/**Determina si un elto esta en la pila**/
int pila_contiene(Pila p, void* clave);


/**Buscar elto en la pila**/
void* pila_buscar(Pila p, void* clave, FuncionIgualdad cmp);














#endif /* __TABLAHASH_H__ */
