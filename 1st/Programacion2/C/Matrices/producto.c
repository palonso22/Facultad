#include <stdio.h>
#include <stdlib.h>

struct Matriz{
	int CantFil;
	int CantCol;
	int **Mtz;
};

int** crearMatriz(int CantFil,int CantCol){
	/*Dado el tamaño, crea una matriz.
	crearMatriz int->int->int** */
	int** Mtz=malloc(sizeof(int*)*CantFil),i,j;
	for(i=0;i<CantFil;i++){
		Mtz[i]=malloc(sizeof(int)*CantCol);
	}
	return Mtz;
}





int**  prodMtz(int **MtzA,int MtzB){
	/* Dadas dos matrices, calculo y devuelve su matriz producto.
	prodMtz: int**->int**->int** */
	//int MtzProd=malloc(sizeof(int*)*)

}

int main(){
	struct Matriz MtzProd,struct MatrizB MtzB,struct Matriz MtzA;
	printf("Ingrese el tamaño de la matriz A\nFilas:");scanf("%d",MtzA.CantFil);printf("Columnas:");scanf("%d",MtzA.CantCol);
	printf("Ingrese el tamaño de la matriz B\nFilas:");scanf("%d",MtzB.CantFil);printf("Columnas:");scanf("%d",MtzA.CantCol);
	MtzA.Mtz=crearMatriz(m,n);
	MtzB.Mtz=crearMatriz(p,q);


}















/*printf("Ingrese el tamaño de la matriz A\nFilas:");scanf("%d",&m);printf("Columnas:");scanf("%d",&n);
	printf("Ingrese el tamaño de la matriz B\nFilas:");scanf("%d",&p);printf("Columnas:");scanf("%d",&q);
	MtzA=crearMatriz(m,n);
	MtzB=crearMatriz(p,q);
	//MtzProd=producto(MtzA,MtzB);*/
