#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int **crearMatriz(int CantFilas,int CantColumnas);
void ingresarMatriz(int **Matriz,int CantFilas,int CantColumnas);
void ImprimirMatriz(int** Matriz, int CantFilas,int CantColumnas);
int** MatrizTranspuesta(int** Matriz,int CantFilas,int CantColumnas);


int main(){
	int **Matriz,CantFilas,CantColumnas,i,j,**MTranspuesta;
	printf("Ingrese un tamaño para la matriz:");
	scanf("%d",&CantFilas);
	CantColumnas=CantFilas;
	//Creamos la matriz..
	Matriz=crearMatriz(CantFilas,CantColumnas);
	//Ingresamos valores en la matriz..
	ingresarMatriz(Matriz,CantFilas,CantColumnas);
	//Mostramos la matriz..
	printf("La matriz ingresada es: \n");
	ImprimirMatriz(Matriz,CantFilas,CantColumnas);
	printf("\n\n");
	//Calculamos su transpuesta..
	MTranspuesta=MatrizTranspuesta(Matriz,CantFilas,CantColumnas);
	//Imprimimos el resultado...
	printf("Su transpuesta es: \n");
	ImprimirMatriz(MTranspuesta,CantFilas,CantColumnas);
	}


int **crearMatriz(int CantFilas,int CantColumnas){
	/*Crea una matriz.
	crearMatriz: int->int->int**/
	int **Matriz=malloc(sizeof(int*)*CantFilas),i,j;
	for(i=0;i<CantFilas;i++){
			Matriz[i]=malloc(sizeof(int)*CantColumnas);
	}
	return Matriz;
}

void ingresarMatriz(int **Matriz,int CantFilas,int CantColumnas){
	/*Permite ingresar valores a una matriz.
	ingresarMatriz:int**->int->int->None*/
	int i,j;
	printf("Ingrese valores en la matriz:\n");
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas;j++){
			printf("[%d][%d]:",i+1,j+1);
			scanf("%d",(Matriz[i]+j));
		}
	}
}

void ImprimirMatriz(int** Matriz, int CantFilas,int CantColumnas){
	/*Imprime una matriz en pantalla.
	ImprimirMatriz: int**->int->int->void*/
	int i,j;
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas;j++){
			printf("%d ", Matriz[i][j]);
		}
		printf("\n");
	}
}

int** MatrizTranspuesta(int** Matriz,int CantFilas,int CantColumnas){
	/*Dada una matriz devuelve su transpuesta.
	MatrizTranspuesta:int**->int->int->int** */
	int** MatrizTranspuesta=crearMatriz(CantFilas,CantColumnas),i,j,l=0,k;
	for(i=0;i<CantFilas;i++){
		k=0;
		for(j=0;j<CantColumnas;j++){
			MatrizTranspuesta[l][k]=Matriz[j][i];
			k++;
		}
		l++;
	}
	return MatrizTranspuesta;
}