#include <stdio.h>
#include <stdlib.h>
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

unsigned hash2(FuncionHash hash, unsigned capacidad,void* clave){
	unsigned idx = (hash(clave) + 1) % capacidad - 1;
	return idx;
	}



int main(void) {
  int x = 42, y = 45, z = 3,w = 99 ;
  TablaHash * tabla = tablahash_crear(10, hash,iguales, hash2);

 
 for(int i = 0; i < 5;i++){
	 tablahash_insertar(tabla,&x,&z);
	 }
 tablahash_insertar(tabla, &y, &w);
 tablahash_eliminar(tabla, &x);
 printf("dato pos clave\n");
 for(int i = 0;i < 10; i++){
	if(!tabla->tabla[i].dato && !tabla->tabla[i].clave) printf("-1   %d   -1\n",i);
	else if(!tabla->tabla[i].dato && tabla->tabla[i].clave != NULL) printf("-1   %d   %d\n",i, *(int*)tabla->tabla[i].clave);
	else printf("%d   %d   %d\n", *(int*)tabla->tabla[i].dato,i,*(int*)tabla->tabla[i].clave);
	}
 
 
 /*Revisar que pasa cuando buscamos con la misma clave*/
  
 //printf("z : %d\n", *((int *)tablahash_buscar(th, &y)));
 // printf("z : %d\n", *((int *)tablahash_buscar(th, &x)));

  //tablahash_eliminar(th, &x);

  //tablahash_destruir(th);

  return 0;
}
