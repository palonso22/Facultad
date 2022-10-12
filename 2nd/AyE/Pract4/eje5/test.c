#include <stdio.h>
#include <stdlib.h>
#include "btree.h"

static void imprimir_entero(int data) {
  printf("%d ", data);
}

static void sumar_enteros(int dato,void* suma){
	*(int*)suma+=dato;
	}

static void incrementar_cant()

int main() {
	BTree ll = btree_unir(1, btree_crear(), btree_crear());
	BTree l = btree_unir(2, ll, btree_crear());
	BTree r = btree_unir(3, btree_crear(), btree_crear());
	BTree raiz = btree_unir(4, l, r);
	int suma=0;
	btree_recorrer_extra(raiz, sumar_enteros, &suma);
	puts("");
	printf("%d",suma);
	btree_destruir(raiz);
	

	return 0;
}
