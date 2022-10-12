#include <stdio.h>
#include <stdlib.h>
#include "cslist.h"

static void imprimir_entero(int dato) {
  printf("%d ", dato);
}



int main(int argc, char *argv[]) {
  size_t capacidad=0;

  /*printf("Agregue la cantidad de eltos en la primer lista:");
  scanf("%zu",&capacidad);
  SList lista=slist_crear_insertar(capacidad);*/

  SList lista = slist_crear(), lista2=slist_crear(), listIntercal;

  
  lista = cslist_agregar_final(lista, 25);
  lista = cslist_agregar_final(lista, 5);
  lista = cslist_agregar_final(lista, 3);
  lista = cslist_agregar_inicio(lista, 12);
  lista = cslist_agregar_inicio(lista, 19);

  cslist_recorrer(lista,imprimir_entero);
  puts("");
  puts("");

printf("La longitud es %d\n",cslist_longitud(lista));
puts("");
puts("");

/*lista2 = cslist_agregar_inicio(lista2, 6);
lista2 = cslist_agregar_inicio(lista2, 2);
lista2 = cslist_agregar_inicio(lista2, 1);
lista2 = cslist_agregar_final(lista2,10);
lista2 = cslist_agregar_inicio(lista2,11);
lista2 = cslist_agregar_final(lista2, 6);
lista2 = cslist_agregar_final(lista2, 7);
lista2 = cslist_agregar_final(lista2, 8);
lista2 = cslist_agregar_final(lista2, 9);
lista2 = cslist_agregar_final(lista2, 10);
lista2 = cslist_agregar_inicio(lista2, 9);
lista2 = cslist_agregar_inicio(lista2, 8);
lista2 = cslist_agregar_inicio(lista2, 7);
lista2 = cslist_agregar_final(lista2, 6);
lista2 = cslist_agregar_final(lista2, 2);
lista2 = cslist_agregar_inicio(lista2, 3);

cslist_recorrer(lista2,imprimir_entero);
  puts("");
  puts("");

printf("La longitud es %d\n",cslist_longitud(lista2));

cslist_concatenar(lista,lista2);
cslist_recorrer(lista,imprimir_entero);
puts("");
puts("");
printf("La longitud es %d\n",cslist_longitud(lista));*/

printf("Se inserto el dato? %d\n",cslist_insertar(lista,27,1));
cslist_recorrer(lista,imprimir_entero);
puts("");
puts("");



cslist_destruir(lista);
cslist_destruir(lista2);
return 0;
}
