#include <stdio.h>
#include <stdlib.h>
#include "tablahash.h"

unsigned hash(void* clave) {
  int* p = clave;
  return *p;
}

int iguales(void* clave1, void* clave2) {
  if(!clave1 || !clave2)return 0;
  int* p = clave1;
  int* q = clave2;
  return *p == *q;
}

unsigned hash2(FuncionHash hash, unsigned capacidad,void* clave){
	unsigned idx = (hash(clave) + 1) % (capacidad - 1);
	return idx;
	}



int main(void) {
  int x = 42, y = 45, z = 3,w = 99, r = 27 ;
  TablaHash * tabla = tablahash_crear(10, hash,iguales, hash2);


 for(int i = 0; i < 5;i++){
	 tablahash_insertar(tabla,&x,&z);
	 }
 tablahash_insertar(tabla, &x, &r);
 tablahash_eliminar(tabla, &x);
 tablahash_insertar(tabla, &x, &r);
 /*tablahash_insertar(tabla, &y, &w);
 tablahash_insertar(tabla, &x, &r);
 //tablahash_eliminar(tabla, &x);
 tablahash_eliminar(tabla, &x);
 for(int i = 0; i < 3;i++){
	 tablahash_insertar(tabla,&x,&z);
	 }*/
 printf("dato pos clave\n");
 for(int i = 0;i < 10; i++){
	if(!tabla->tabla[i].dato && !tabla->tabla[i].clave) printf("none   %d   -1\n",i);
	else if(!tabla->tabla[i].dato && tabla->tabla[i].clave != NULL) printf("none   %d   %d\n",i, *(int*)tabla->tabla[i].clave);
	else printf("%d   %d   %d\n", *(int*)tabla->tabla[i].dato,i,*(int*)tabla->tabla[i].clave);
	}
 
 
 /*Revisar que pasa cuando buscamos con la misma clave*/
  
 
 /*printf("z : %d\n", *((int *)tablahash_buscar(tabla, &x)));
 printf("\n\n\n\n");
 printf("dato pos clave\n");
 for(int i = 0;i < 10; i++){
	if(!tabla->tabla[i].dato && !tabla->tabla[i].clave) printf("-1   %d   -1\n",i);
	else if(!tabla->tabla[i].dato && tabla->tabla[i].clave != NULL) printf("-1   %d   %d\n",i, *(int*)tabla->tabla[i].clave);
	else printf("%d   %d   %d\n", *(int*)tabla->tabla[i].dato,i,*(int*)tabla->tabla[i].clave);
	}*/
 //tablahash_buscar(tabla, &x);

  //tablahash_eliminar(th, &x);

  //tablahash_destruir(th);

  return 0;
}
