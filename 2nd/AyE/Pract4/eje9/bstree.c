#include "bstree.h"
#define mayor(a,b) a>=b?a:b

BSTree bstree_crear(){
	return NULL;
	}



BSTree bstree_insertar(BSTree arbol,int dato){
	if(!arbol){
		arbol=malloc(sizeof(struct BSTree_));
		arbol->dato=dato;
		arbol->left=NULL;
		arbol->right=NULL;
		}
	else if(arbol->dato>dato){
	arbol->left=bstree_insertar(arbol->left,dato); 	
		}
	else{
	arbol->right=bstree_insertar(arbol->right,dato);
		}
	return arbol;
	}
	
void aux_eliminar(BSTree arbol){
  free(arbol);
  }  
  

BSTree bstree_eliminar_min(BSTree arbol) {
	BSTree aux=NULL;
	for(;arbol->left!=NULL;arbol=arbol->left){
		if(!arbol->left->left)aux=arbol;
		}
	//si el min no es la raiz del arbol
	//el hijo derecho de min pasa a ser
	//hijo izquierdo del padre de min
	if(aux!=NULL)aux->left=arbol->right;
	return arbol;
}

  
BSTree bstree_eliminar(BSTree arbol,int dato){
  if (!arbol)return NULL;
  if(dato == 9)printf("aca entra\n");
  if (arbol->dato==dato){
    if (!arbol->left && !arbol->right) {
      aux_eliminar(arbol);
      return NULL;
    }
    else if(!arbol->right) {
      BSTree aux=arbol->left;
      aux_eliminar(arbol);
      return aux;
    }
    else{
      BSTree min=aux_min(arbol->derecha);
      //Hacemos el reemplazo
      arbol->dato=min->dato;
      //si el min es la raiz del subarbol derecho
      //entonces el hijo derecho del min pasa a ser
      //el hijo derecho de arbol
      if(min==arbol->right)arbol->derecha = min->derecha;
      aux_eliminar(min);
      return arbol;
      } 
    }
   else if(dato<arbol->dato){
	  arbol->left=bstree_eliminar(arbol->left,dato);
	   }
   else{
	   arbol->right=bstree_eliminar(arbol->right,dato);
	   }
  }  


void aux_altura(BSTree arbol,int* altura){
	*altura+=1;
	//ver porque rama se puede bajar
	if(arbol->left!=NULL && (arbol->left->left!=NULL || arbol->left->right!=NULL))
		aux_altura(arbol->left,altura);
	else if(arbol->right!=NULL && (arbol->right->left!=NULL ||arbol->right->right!=NULL))
		aux_altura(arbol->right,altura);
	return;
	}




int bstree_altura(BSTree arbol){
	if(!arbol)return 0;
	if(!arbol->left && !arbol->right)return 0;
	int alturaizq=0,alturader=0;
	if(arbol->left!=NULL)aux_altura(arbol->left,&alturaizq);
	if(arbol->right!=NULL)aux_altura(arbol->right,&alturader);
	return mayor(alturaizq,alturader);
	}


void aux_nelementos(BSTree arbol, int* eltos){
	if(arbol!=NULL){
		(*eltos)++;
		aux_nelementos(arbol->left,eltos);
		aux_nelementos(arbol->right,eltos);
		}
	}


int bstree_nelementos(BSTree arbol){
	if(!arbol)return 0;
	int eltos=0;
	aux_nelementos(arbol,&eltos);
	return eltos;
	}


BSTree bstree_min(BSTree arbol){
	if(!arbol)return NULL;
	for(;arbol->left!=NULL;arbol=arbol->left);
	return arbol;
	}











  
  
  
  
  
  
  
  
  
void bstree_recorrer(BSTree arbol, BSTreeOrdenDeRecorrido orden,FuncionVisitante visit){
	if(!arbol)return;
	if(orden==BTREE_RECORRIDO_POST){
		bstree_recorrer(arbol->left,orden,visit);
		bstree_recorrer(arbol->right,orden,visit);
		visit(arbol->dato); 
		}
	else if(orden==BTREE_RECORRIDO_PRE){
		visit(arbol->dato);
		bstree_recorrer(arbol->left,orden,visit);
		bstree_recorrer(arbol->right,orden,visit);
		}
	else{
		bstree_recorrer(arbol->left,orden,visit);
		visit(arbol->dato);
		bstree_recorrer(arbol->right,orden,visit);
		}
		
	}

void aux_contiene(BSTree arbol,int* i ,int dato){
	if(arbol!=NULL){
		if(arbol->dato==dato){
			*i=1;
			return;
			}
		if(dato<arbol->dato)aux_contiene(arbol->left,i,dato);
		else aux_contiene(arbol->right,i,dato);
		}
	}
	


int bstree_contiene(BSTree arbol, int dato){
	if(!arbol)return 0;
	int i=0;
	aux_contiene(arbol,&i,dato);
	return i;
	}




	

