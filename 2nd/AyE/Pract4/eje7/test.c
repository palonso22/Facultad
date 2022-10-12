#include <stdio.h>
#include <stdlib.h>
#include "btree.h"

static void imprimir_entero(int data) {
  printf("%d ", data);
}

int main() { 
	BTree ll = btree_unir(2, btree_crear(), btree_crear());
	BTree l = btree_unir(7, btree_crear(), btree_crear());
	BTree r = btree_unir(5, ll, l);
	BTree mm=btree_unir(8,btree_crear(),btree_crear());
	BTree m=btree_unir(9,btree_crear(),btree_crear());
	BTree r2=btree_unir(3,mm,m);
	BTree raiz = btree_unir(4,r,r2);
	btree_recorrer(raiz,imprimir_entero);
	puts("");
	BTree arbolMirror=btree_mirror(raiz);
	btree_recorrer(arbolMirror,imprimir_entero);
	puts("");
	btree_destruir(raiz);
	return 0;
}
