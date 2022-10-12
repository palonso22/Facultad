#include <stdio.h>

#include "alist.h"








int main() {
  lista *lista_prueba = lista_crear(8);

  lista_agregar_principio(lista_prueba, 9);
  lista_agregar_final(lista_prueba, 1);
  lista_agregar_final(lista_prueba, 2);
  lista_agregar_final(lista_prueba, 3);
  lista_agregar_final(lista_prueba, 4);
  /*lista_agregar_final(lista_prueba, 5);
  lista_agregar_principio(lista_prueba, -1);*/
  lista_insertar(lista_prueba,7);
  lista_insertar(lista_prueba,22);
  lista_imprimir(lista_prueba);


  /*printf("La longitud es %zu\n",lista_longitud(lista_prueba));
  printf("El primero  esta en la pos %d\n",lista_prueba->primero);/
  printf("El segundo  esta en la pos %d\n",lista_prueba->siguientes[6]);
  printf("El primero es %d\n",lista_prueba->datos[6]);
  printf("El segundo es %d\n",lista_prueba->datos[lista_prueba->siguientes[6]]);*/

  /*lista *lista_prueba2 = lista_crear(8);

  lista_agregar_final(lista_prueba2, 7);
  lista_agregar_final(lista_prueba2, 8);
  lista_agregar_final(lista_prueba2, 11);
  lista_agregar_final(lista_prueba2, 10);
  lista_agregar_final(lista_prueba2, 11);
  lista_agregar_principio(lista_prueba2, 13);
  lista_agregar_principio(lista_prueba2, 14);

  lista_imprimir(lista_prueba2);

  lista_concat(lista_prueba,lista_prueba2);
  lista_imprimir(lista_prueba);*/



 // lista_destruir(lista_prueba2);
  //lista_destruir(lista_prueba);

  return 0;
}
