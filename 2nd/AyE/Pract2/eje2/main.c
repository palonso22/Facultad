#include <stdio.h>
#include <stdlib.h>
#include "slist.h"

static void imprimir_entero(int dato) {
  printf("%d ", dato);
}



int main(int argc, char *argv[]) {
  size_t capacidad=0;

  /*printf("Agregue la cantidad de eltos en la primer lista:");
  scanf("%zu",&capacidad);
  SList lista=slist_crear_insertar(capacidad);*/

  SList lista = slist_crear(), lista2=slist_crear(), listIntercal;

  lista = slist_agregar_inicio(lista, 6);
  lista = slist_agregar_inicio(lista, 1);
  lista = slist_agregar_inicio(lista, 2);
  lista = slist_agregar_inicio(lista, 3);
  lista = slist_agregar_final(lista, 0);
  lista = slist_agregar_final(lista, -1);



  slist_recorrer(lista, imprimir_entero);
  puts("");
  puts("");

  //printf("El valor de contiene es %d\n",slist_contiene(lista,6));

  lista=slist_intercambiar(lista,3,6);

  slist_recorrer(lista, imprimir_entero);
  puts("");
  puts("");

  

  /*lista=slist_eliminar_dato(lista,3);
  lista=slist_eliminar_dato(lista,4);
  lista=slist_eliminar_dato(lista,2);
  lista=slist_eliminar_dato(lista,1);*/



  /*printf("Ingrese la capacidad de la segunda lista:");
  scanf("%zu",&capacidad);*/

  /*lista2 = slist_agregar_inicio(lista2, 6);
  lista2 = slist_agregar_inicio(lista2, 2);
  lista2 = slist_agregar_inicio(lista2, 1);
  lista2 = slist_agregar_final(lista2,10);
  lista2 = slist_agregar_inicio(lista2,11);
  lista2 = slist_agregar_final(lista2, 6);
  lista2 = slist_agregar_final(lista2, 7);
  lista2 = slist_agregar_final(lista2, 8);
  lista2 = slist_agregar_final(lista2, 9);
  lista2 = slist_agregar_final(lista2, 10);
  lista2 = slist_agregar_inicio(lista2, 9);
  lista2 = slist_agregar_inicio(lista2, 8);
  lista2 = slist_agregar_inicio(lista2, 7);
  lista2 = slist_agregar_final(lista2, 6);
  lista2 = slist_agregar_final(lista2, 2);
  lista2 = slist_agregar_inicio(lista2, 3);*/

  
  /*slist_recorrer(lista2, imprimir_entero);
  puts("");
  puts("");

  

  listIntercal=slist_intercalar(lista,lista2);
  slist_recorrer(listIntercal, imprimir_entero);
  puts("");
  puts("");*/

  







 /*//printf("La longitud es %zu\n",slist_longitud(lista));*/

  /*slist_concatenar(lista,lista2);*/

  /*printf("La lista es: ");
  slist_recorrer(lista2, imprimir_entero);
  puts("");

  size_t d=3;
  printf("La longitud es %zu\n",slist_longitud(lista2));*/
  
  /*printf("El dato es  %d en la pos %zu\n",slist_obtener(lista2,d),d);
  slist_insertar(lista2,d,153);
  printf("Ahora es %d en la pos %zu\n",slist_obtener(lista2,d),d);*/


  slist_destruir(lista);
  //slist_destruir(lista2);

  return 0;
}
