#include <stdio.h>
#include <stdlib.h>
#include "btree.h"

static void imprimir_entero(int data) {
  printf("%d ", data);
}

int main() {
  /*BTree lllll=btree_unir(15,btree_crear(),btree_crear());
  BTree llll=btree_unir(12,lllll,btree_crear());
  BTree lll=btree_unir(8,btree_crear(),btree_crear());
  BTree ll = btree_unir(1, lll, llll);
  BTree l = btree_unir(2, ll, btree_crear());
  BTree r = btree_unir(3, btree_crear(), btree_crear());*/
  BTree raiz = btree_unir(4,btree_crear(),btree_crear());

  btree_recorrer_bfs(raiz, imprimir_entero);
  puts("");
  btree_destruir(raiz);

  return 0;
}
