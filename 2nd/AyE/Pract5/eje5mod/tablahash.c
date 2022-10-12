#include "tablahash.h"
#include <stdlib.h>


int aux_primo(int capacidad){
	for(int i = 2; i < capacidad;i++){
		if(capacidad % i == 0)return 0;
		}
	return 1;
	}


/**
 * Crea una nueva tabla Hash vacía, con la capacidad dada.
 */
TablaHash* tablahash_crear(unsigned capacidad, FuncionHash hash,FuncionIgualdad iguales, FuncionHash2 hash2) {
   //Comprobar que la capacidad este dada por un número primo
   assert(aux_primo(capacidad));
  // Pedimos memoria para la estructura principal y las casillas.
  TablaHash* tabla = malloc(sizeof(TablaHash));
  tabla->hash = hash;
  tabla->hash2 = hash2;
  tabla->iguales=iguales;
  tabla->capacidad = capacidad;
  tabla->tabla = malloc(sizeof(CasillaHash) * capacidad);
  tabla->numElems = 0;

  // Inicializamos las casillas con datos nulos.
  for (unsigned idx = 0; idx < capacidad; ++idx) {
    tabla->tabla[idx].clave = NULL;
    tabla->tabla[idx].dato = NULL;
  }

  return tabla;
}

/** Busca una posicion disponible para hacer la insercion**/
int aux_direccionamiento(TablaHash* tabla , void* clave){
	//Hacer un primer sondeo
	//Si la casilla esta vacia o fue eliminada insertar
	unsigned idx = tabla->hash(clave) % tabla->capacidad, idx2;
	if(!tabla->tabla[idx].clave || (tabla->iguales(tabla->tabla[idx].clave,clave) && !tabla->tabla[idx].dato ))return idx;
	//Hacer el sondeo hasta que se encuentre una casilla desocupada o hasta que
	//se encuentre una casilla que fue ocupada por un dato con la misma clave o 
	//hasta que no encuentra ninguna que cumpla lo anterior
	idx2 = tabla->hash2(tabla->hash,tabla->capacidad, &idx);
	while(tabla->tabla[idx2].clave != NULL && !(tabla->iguales(tabla->tabla[idx2].clave, clave) && tabla->tabla[idx2].dato == NULL ) && idx2 != idx){
		idx2 = tabla->hash2(tabla->hash,tabla->capacidad, &idx2);
	   }
	if( idx2 == idx) return -1;
	return idx2;
	}


/**
 * Inserta el dato en la tabla, asociado a la clave dada.
 */
int tablahash_insertar(TablaHash* tabla, void* clave, void* dato) {
  // Calculamos la posición de la clave dada, de acuerdo a la función hash.
  unsigned idx = aux_direccionamiento(tabla,clave);
  printf("%d",idx);
  //Si idx es -1 no encontramos casilla libre para el dato 
  if(idx == -1)return 1;
  //printf("pp %d\n",idx);
  // Si el lugar estaba vacío, incrementamos el número de elementos.
  tabla->tabla[idx].dato = dato;
  tabla->numElems++;
  if (tabla->tabla[idx].clave == NULL) tabla->tabla[idx].clave = clave;
  return 0;
 } 
  

  

/**
 * Busca un elemento dado en la tabla, y retorna un puntero al mismo.
 * En caso de no existir, se retorna un puntero nulo.
 */
void* tablahash_buscar(TablaHash* tabla, void* clave) {

  // Calcular la posición de la clave dada, de acuerdo a la función hash.
  unsigned idx = tabla->hash(clave) % tabla->capacidad;
  int temp = -1;
  //Si se encuentra el dato se retorna
  if(tabla->iguales(tabla->tabla[idx].clave,clave)){
	  if(tabla->tabla[idx].dato != NULL){
		return tabla->tabla[idx].dato;
		}
	  //Guardar la posicion  para luego insertar aca
	  temp = idx;
	 }  
  //Hacer un segundo sondeo
  unsigned idx2 = tabla->hash2(tabla->hash,tabla->capacidad, &idx);
  while((tabla->tabla[idx2].clave != NULL &&  !(tabla->iguales(tabla->tabla[idx2].clave, clave) && tabla->tabla[idx2].dato != NULL ) && idx2 != idx)){
	//Almacenar la posicion de la primer casilla eliminada
	if(temp == -1) temp = idx2;
	idx2 = tabla->hash2(tabla->hash,tabla->capacidad, &idx2);
	}
  //Si se recorre toda la tabla no se encuentra el dato solicitado
  if( idx2 == idx) return NULL;
  //Si se encontro una casilla mas cercana donde poder almacenar el dato
  //hacer el intercambio
  if(temp != -1){
  tabla->tabla[temp].dato = tabla->tabla[idx2].dato;
  tabla->tabla[idx2].dato = NULL;
  return tabla->tabla[temp].dato;
	}
  //Sino retornar el dato;
  return tabla->tabla[idx2].dato;
}

/**Elimina un dato de la tabla**/
void aux_eliminar(TablaHash* tabla, unsigned idx){
	tabla->tabla[idx].dato = NULL;
	tabla->numElems--;
	}


/**
 * Dada una clave, elimina todos los datos asociados a esa clave.
 */
void tablahash_eliminar(TablaHash* tabla, void* clave) {
  // Calcular la posición de la clave dada, de acuerdo a la función hash.
  unsigned idx = (tabla->hash(clave)) % tabla->capacidad;
  if(tabla->iguales(tabla->tabla[idx].clave,clave) && tabla->tabla[idx].dato != NULL){
	  //Eliminar el dato de esta casilla
	  aux_eliminar(tabla,idx);
	  return;
	 }
  else{
	unsigned idx2 = tabla->hash2(tabla->hash,tabla->capacidad, &idx);
	 // Eliminar el dato de la primer casilla cuyo campo dato no esta vacio
	 while(idx != idx2 && tabla->tabla[idx2].clave != NULL && tabla->iguales(tabla->tabla[idx2].clave, clave)){
	   if(tabla->tabla[idx2].dato != NULL ){
	   aux_eliminar(tabla, idx2);
	   break;
	     }
	   idx2 = tabla->hash2(tabla->hash,tabla->capacidad, &idx2);
	   }  
		  }
	}
	  

/**
 * Destruye la tabla.
 */
void tablahash_destruir(TablaHash* tabla) {
  free(tabla->tabla);
  free(tabla);
}
