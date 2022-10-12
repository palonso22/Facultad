#include <stdio.h>
#include <stdlib.h>
#include "dlist.h"

static void imprimir_entero(int dato) {
  printf("%d ", dato);
}



int main(int argc, char *argv[]) {

  SList lista = dlist_crear(), lista2=dlist_crear(), listIntercal;

  
  lista = dlist_agregar_final(lista, 25);
  lista = dlist_agregar_final(lista, 5);
  lista = dlist_agregar_final(lista, 3);
  lista = dlist_agregar_inicio(lista, 12);
  lista = dlist_agregar_inicio(lista, 19);

  dlist_recorrer(lista,imprimir_entero);
  puts("");
  puts("");



lista2 = dlist_agregar_inicio(lista2, 6);
lista2 = dlist_agregar_inicio(lista2, 2);
lista2 = dlist_agregar_inicio(lista2, 1);
lista2 = dlist_agregar_final(lista2,10);
lista2 = dlist_agregar_inicio(lista2,11);
lista2 = dlist_agregar_final(lista2, 6);
lista2 = dlist_agregar_final(lista2, 7);
lista2 = dlist_agregar_final(lista2, 8);
lista2 = dlist_agregar_final(lista2, 9);
lista2 = dlist_agregar_final(lista2, 10);
lista2 = dlist_agregar_inicio(lista2, 9);
lista2 = dlist_agregar_inicio(lista2, 8);
lista2 = dlist_agregar_inicio(lista2, 7);
lista2 = dlist_agregar_final(lista2, 6);
lista2 = dlist_agregar_final(lista2, 2);
lista2 = dlist_agregar_inicio(lista2, 8);

dlist_recorrer(lista2,imprimir_entero);
  puts("");
  puts("");


dlist_concatenar(lista,lista2);
dlist_recorrer(lista,imprimir_entero);
puts("");
puts("");
printf("La longitud es %d\n",dlist_longitud(lista));

/*printf("Se inserto el dato? %d\n",cslist_insertar(lista,27,1));
cslist_recorrer(lista,imprimir_entero);
puts("");
puts("");*/



//dlist_destruir(lista);
return 0;
}
