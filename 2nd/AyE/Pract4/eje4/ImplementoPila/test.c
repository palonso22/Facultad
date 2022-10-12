#include <stdio.h>
#include <stdlib.h>
#include "btree.h"

static void imprimir_entero(int data) {
  printf("%d ", data);
}

int main() {
  /*BTree l8= btree_unir(31,btree_crear(),btree_crear());
  BTree l7= btree_unir(21,btree_crear(),l8);*/
  BTree l4= btree_unir(16,btree_crear(),btree_crear());
  BTree l3= btree_unir(12,btree_crear(),btree_crear());
  BTree l2= btree_unir(0, l4, l3);
  BTree l1 = btree_unir(1, btree_crear(), btree_crear());
  BTree l = btree_unir(2, l1, l2);
  BTree r = btree_unir(3, btree_crear(), btree_crear());
  BTree raiz = btree_unir(4, l, r);
  btree_recorrer(raiz, BTREE_RECORRIDO_POST, imprimir_entero);
  puts("");
  //btree_destruir(raiz);

  return 0;
}
