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
		Mtz[i]=calloc(CantCol,sizeof(int));
	}
	return Mtz;
}

void CompletMtz(struct Matriz* MtzC){
	/* Permite ingresar los coeficientes de  una matriz.
	struct* Matriz->None */
	int i,j;
	for(i=0;i<MtzC->CantFil;i++){
		for(j=0;j<MtzC->CantCol;j++){
			printf("[%d][%d]=",i+1,j+1);scanf("%d",MtzC->Mtz[i]+j);
		}
	}
}

void ImprimMtz(struct Matriz MtzC){
	/* Imprime los coeficientes de una matriz
	ImprimMtz: Struct Matriz->None */
	int i,j;
	for(i=0;i<MtzC.CantFil;i++){
		for(j=0;j<MtzC.CantCol;j++){
			printf("%d ",MtzC.Mtz[i][j]);
		}
		printf("\n");

	}
} 






void  prodMtz(struct Matriz MtzA,struct Matriz MtzB,struct Matriz* MtzProd){
	/* Dadas dos matrices, calcula y completa su matriz producto.
	prodMtz: struct Matriz->struct Matriz->struct Matriz*->None */
	int i,j,k,LimSum=MtzA.CantCol,Sum;	
	for(j=0;j<MtzProd->CantCol;j++){
		for(i=0;i<MtzProd->CantFil;i++){
			Sum=0;
			for(k=0;k<LimSum;k++){
				Sum+=MtzA.Mtz[i][k]*MtzB.Mtz[k][j];
			}
			MtzProd->Mtz[i][j]=Sum; 	 
		}
	}
}

int main(){
	struct Matriz MtzProd, MtzB, MtzA;
	//Creamos, inicializamos e imprimimos la Matriz A.
	printf("Ingrese el tamaño de la matriz A\nFilas:");scanf("%d",&MtzA.CantFil);printf("Columnas:");scanf("%d",&MtzA.CantCol);
	MtzA.Mtz=crearMatriz(MtzA.CantFil,MtzA.CantCol);printf("Ingrese los coeficientes de la matriz A:\n");CompletMtz(&MtzA);ImprimMtz(MtzA);
	printf("\n\n");
	
	//Creamos, inicializamos e imprimimos la Matriz B.
	printf("Ingrese el tamaño de la matriz B\nFilas:");scanf("%d",&MtzB.CantFil);printf("Columnas:");scanf("%d",&MtzB.CantCol);
	MtzB.Mtz=crearMatriz(MtzB.CantFil,MtzB.CantCol);printf("Ingrese los coeficientes de la matriz B:\n");CompletMtz(&MtzB);ImprimMtz(MtzB);
	printf("\n\n");

	if(MtzA.CantCol==MtzB.CantFil)/*Creamos y completamos la matriz producto de A y B.*/{
		printf("Su producto es la matriz:\n");
		MtzProd.CantFil=MtzA.CantFil,MtzProd.CantCol=MtzB.CantCol;
		MtzProd.Mtz=crearMatriz(MtzProd.CantFil,MtzProd.CantCol);
		prodMtz(MtzA,MtzB,&MtzProd);
		ImprimMtz(MtzProd);
	}
	else{
		printf("¡Imposible el producto entre estas matrices!");
	}

}














