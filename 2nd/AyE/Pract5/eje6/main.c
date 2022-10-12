
#include "tablahash.h"

unsigned hash(void* clave) {
  int* p = clave;
  return *p;
}

int iguales(void* clave1, void* clave2) {
  int* p = clave1;
  int* q = clave2;
  return *p == *q;
}




int main(void) {
 int x = 42, y = 42, z = 3,w = 99, q = 44, r = 88;
 TablaHash * th = tablahash_crear(10, hash,iguales);
 tablahash_insertar(th, &x, &z);
 
 tablahash_insertar(th,&y,&w);
 tablahash_insertar(th,&q, &r);
  pila_imprimir(th->claves);
 //printf("%d",*(int*)tablahash_buscar(th,&x));
 //tablahash_eliminar(th,&x);
 //printf("%d",*(int*)tablahash_buscar(th,&x));
 //pila_imprimir(th->claves);
 
 /*Revisar que pasa cuando buscamos con la misma clave*/
  
// printf("z : %d\n", *((int *)tablahash_buscar(th, &y)));
 // printf("z : %d\n", *((int *)tablahash_buscar(th, &x)));


  tablahash_destruir(th);

  return 0;
}
