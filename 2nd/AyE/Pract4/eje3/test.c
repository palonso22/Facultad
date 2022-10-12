#include <stdio.h>
#include <stdlib.h>
#include "btree.h"

static void imprimir_entero(int data) {
  printf("%d ", data);
}

int main() {
	int suma =0,cantidad=0;
	BTree ll = btree_unir(1, btree_crear(), btree_crear());
	BTree l = btree_unir(2, ll, btree_crear());
	BTree r = btree_unir(3, btree_crear(), btree_crear());
	BTree raiz = btree_unir(4, l, r);
	BTree nodo2=btree_unir(5, btree_crear(), btree_crear());
	BTree nodo3=btree_unir(3, btree_crear(), btree_crear());
	BTree nodo1=btree_unir(4,nodo2,nodo3);
	BTree nodo0=btree_unir(25,btree_crear(),btree_crear());
	btree_recorrer(nodo0, BTREE_RECORRIDO_POST, imprimir_entero);
	puts("");
	printf("la altura es %d",btree_altura(nodo0));
	//btree_destruir(raiz);

	return 0;
}
