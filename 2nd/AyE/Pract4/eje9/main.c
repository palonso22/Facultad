#include "bstree.h"



static void imprimir_entero(int data) {
  printf("%d \n", data);
}



int main(){
	srand(time(NULL));
	BSTree arbol=bstree_crear();
	arbol=bstree_insertar(arbol,3);
	arbol=bstree_insertar(arbol,1);
	arbol=bstree_insertar(arbol,6);
	arbol=bstree_insertar(arbol,6);
	arbol=bstree_insertar(arbol,4);
	arbol=bstree_insertar(arbol,5);
	arbol=bstree_insertar(arbol,4);
	/*arbol=bstree_insertar(arbol,4);
	arbol=bstree_insertar(arbol,3);*/
	/*for(int i=0;i<6;i++){
		arbol=bstree_insertar(arbol,rand()%10+1);
		}*/
	bstree_recorrer(arbol,BTREE_RECORRIDO_IN,imprimir_entero);
	/*arbol=bstree_eliminar(arbol,3);
	arbol=bstree_eliminar(arbol,2);
	arbol=bstree_eliminar(arbol,1);
	arbol=bstree_eliminar(arbol,-1);
	arbol=bstree_eliminar(arbol,4);
	arbol=bstree_eliminar(arbol,4);
	arbol=bstree_eliminar(arbol,3);
	arbol=bstree_eliminar(arbol,4);
	//arbol=bstree_eliminar(arbol,4);
	arbol=bstree_eliminar(arbol,5);*/
	puts("");
	//printf("%d",arbol->right->left->right->left->dato);
	BSTree  min=bstree_min(arbol);
	printf("%d",min->dato);
	}
