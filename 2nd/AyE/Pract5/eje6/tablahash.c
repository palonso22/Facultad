#include "tablahash.h"
#include <assert.h>
#include <stdlib.h>





/**
 * Crea una nueva tabla Hash vacía, con la capacidad dada.
 */
TablaHash* tablahash_crear(unsigned capacidad, FuncionHash hash,FuncionIgualdad iguales) {
  // Pedimos memoria para la estructura principal y las casillas.
  TablaHash* tabla = malloc(sizeof(TablaHash));
  tabla->claves = NULL;
  tabla->hash = hash;
  tabla->capacidad = capacidad;
  tabla->iguales=iguales;
  tabla->tabla = malloc(sizeof(CasillaHash) * capacidad);
  tabla->numElems = 0;

  // Inicializamos las casillas con datos nulos.
  for (unsigned idx = 0; idx < capacidad; ++idx) {
    tabla->tabla[idx].clave = NULL;
    tabla->tabla[idx].pila = NULL;
  }

  return tabla;
}


/**
 * Inserta el dato en la tabla, asociado a la clave dada.
 */
void tablahash_insertar(TablaHash* tabla, void* clave, void* dato) {
  // Calcular la posicion que le corresponde evaluando la clave con la funcion hash
  //Incrementar la cantidad de eltos
  unsigned idx = (tabla->hash(clave)) % tabla->capacidad;
  tabla->numElems++;
  //Si la casilla estaba vacia, marcar la casilla con la clave
  if (tabla->tabla[idx].clave == NULL) tabla->tabla[idx].clave = clave;
  //Agregar elto en la pila que corresponde a esa clave
  tabla->tabla[idx].pila = pila_push(tabla->tabla[idx].pila,dato,clave);
  //Si la clave no fue usada antes, registrar la clave
  if(!pila_contiene(tabla->claves,clave)){
	   int* i = malloc(sizeof(int));
	   *i = 0;
	   tabla->claves = pila_push(tabla->claves,i, clave);
	}
   }





/**
 * Busca un elemento dado en la tabla, y retorna un puntero al mismo.
 * En caso de no existir, se retorna un puntero nulo.
 */
void* tablahash_buscar(TablaHash* tabla, void* clave) {
  // Calculamos la posición de la clave dada, de acuerdo a la función hash.
  unsigned idx = tabla->hash(clave);
  idx = idx % tabla->capacidad;
  // Si el lugar esta vacío, retornamos un puntero nulo.
  if (!tabla->iguales(tabla->tabla[idx].clave,clave)){
    return NULL;
	}

  return pila_buscar(tabla->tabla[idx].pila, clave, tabla->iguales);
}


/**
 * Elimina un elemento de la tabla.
 */
void tablahash_eliminar(TablaHash* tabla, void* clave) {
  // Calculamos la posición de la clave dada, de acuerdo a la función hash.
  unsigned idx = tabla->hash(clave);
  idx = idx % tabla->capacidad;

  // Si el lugar estaba ocupado, decrementamos el número de elementos.
  if (tabla->tabla[idx].clave != NULL)
    tabla->numElems--;
  //Eliminamos el elto en la cima de la pila
  tabla->tabla[idx].pila = pila_pop(tabla->tabla[idx].pila); 
}


void tablahash_destruir(TablaHash* tabla){
	//Caso tabla vacia
	if(!tabla) return;
	while(!pila_vacia(tabla->claves)){
		//Obtener la clave en  la cima de la pila
		void* clave = pila_top(tabla->claves);
		//Calcular su posicion en la tabla 
		unsigned idx = tabla->hash(clave) % tabla->capacidad;
		//Destruir la pila de la casilla en la posicion dada
		pila_destruir(tabla->tabla[idx].pila);
		//Quitar la clave del registro
		tabla->claves = pila_pop(tabla->claves); 
		}
	free(tabla);
	}





