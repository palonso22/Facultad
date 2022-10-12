#include <stdlib.h>
#include <stdio.h>
#include "matriz.h"

/*
** Implementacion utilizando un arreglo bidimensional (arreglo de punteros a arreglo)
*/

/*typedef struct{
	float** direccion;
	size_t cantFil;
	size_t cantCol;
}Matriz;*/


Matriz* matriz_crear(size_t numFilas, size_t numColumnas) {
	/*Dado el tamaño de filas y col, crea y retorna un ptro a una estructura MatrizBi
	MatrizBi:int->int->*MatrizBi*/
	//Ptro a una estruct MatrizBi
	Matriz* estructMatriz=malloc(sizeof(Matriz));
	//Def VI
	size_t i;
	//Ptro doble que apunte a los ptros fila
	float **matriz=malloc(sizeof(float*)*numFilas);
	//Reserv mem para cada fila
	for(i=0;i<numFilas;i++){
		matriz[i]=malloc(sizeof(float)*numColumnas);
	}
	//Apuntamos el campo direccion a la matriz creada
	estructMatriz->direccion=matriz;
	//Guardamos la capacidad de fil y col
	estructMatriz->cantFil=numFilas;
	estructMatriz->cantCol=numColumnas;
	return estructMatriz;

}

void matriz_ingresar(Matriz* estructMatriz){
	/*Dado un ptro a una estruc MatrizBi permite ingresar valores en la matriz apuntada
	por el campo direccion. 
	ingresarMatrizBi:MatrizBi*->none*/
	//2 VI
	size_t i,j,cantFilas=estructMatriz->cantFil, cantCol=estructMatriz->cantCol;
	//Guardamos matriz
	float **matriz=estructMatriz->direccion;
	//Ingresamos valores
	for(i=0;i<cantFilas;i++){
		for(j=0;j<cantCol;j++){
			printf("M[%d][%d]=",(int)(i+1),(int)(j+1));
			scanf("%f",matriz[i]+j);
		}
	}
}

void matriz_mostrar(Matriz* estructMatriz){
	/*Dado un ptro a una estruct MatrizBi muestra los vres guardados en el arreglo
	apuntado por el campo direccion.
	mostrarMatrizBi:MatrizBi*->none*/
	size_t i,j,cantFilas=estructMatriz->cantFil,cantCol=estructMatriz->cantCol;
	float **matriz=estructMatriz->direccion;
	for(i=0;i<cantFilas;i++){
		for(j=0;j<cantCol;j++){
			printf("%.2f ",matriz[i][j]);
		}
		printf("\n");
	}
}

void matriz_destruir(Matriz* estructMatriz){
	/*Libera la memoria ocupada por las filas del arreglo, el arreglo y la estructura, en 
	ese orden.
	destruirMatrizBi:MatrizBi*->none*/
	size_t cantFilas=estructMatriz->cantFil,i=0;
	float** matriz=estructMatriz->direccion;
	//Liberamos primero las filas segunda a ultima
	//Para no perder la referencia a la matriz
	for(i=1;i<cantFilas;i++){
		free(matriz[i]);
		(matriz[i])=NULL;
	}
	free(matriz);
	matriz=NULL;
	free(estructMatriz);
	estructMatriz=NULL;
}

double matriz_leer(Matriz* estructMatriz, size_t fil, size_t col) {
	/*Dado un ptro a una estructura matriz y una posicion en fila y columna,
	retorna el valor guardado en esa posición.
	matriz_leer:Matriz*->size_t->size_t->double*/
	float**  matrizDir=estructMatriz->direccion;
	return matrizDir[fil][col];
}

void matriz_escribir(Matriz* estructMatriz, size_t fil, size_t col, double val) {
	/*Dado un ptro a una estructura MatrizBi, una posicion y un dato, escribe el dato
	en dicha posicion en la matriz  apuntada por el campo direccion.
	escribirMatrizBi:MatrizBi*->int->int->float->none*/ 
	float **matriz=estructMatriz->direccion;
	matriz[fil-1][col-1]=val;
}

size_t matriz_num_filas(Matriz* matriz) {
	/*Retorna la cantidad de filas de la matriz apuntada
	por el campo direccion.
	matriz_num_filas:Matriz*->none*/
	return matriz->cantFil;

}

size_t matriz_num_columnas(Matriz* matriz) {
	/*Retorna la cantidad de filas de la matriz apuntada
	por el campo direccion.
	matriz_num_filas:Matriz*->none*/
	return matriz->cantCol;
}

void matriz_intercambiar_fila(Matriz* estructMatriz, size_t filaI, size_t filaJ){
	/*Dado un ptro a una estruct MatrizBi, intercambia las filas dadas en el arreglo apuntado por
	el campo direccion.*/
	float** matriz=estructMatriz->direccion,*ptrI=matriz[filaI-1],*ptrJ=matriz[filaJ-1];
	matriz[filaI-1]=ptrJ;
	matriz[filaJ-1]=ptrI;
	estructMatriz->direccion=matriz;
}

Matriz* matriz_suma(Matriz* estructMatrizA,Matriz* estructMatrizB){
	/*Dados dos ptros a estruct MatrizBi, devuelve un ptro a MatrizBi cuyo ptro apunta a un arreglo
	cuyas componentes son la suma de las componente de los arreglos apuntados por el campo direccion
	de los primeros dos.
	sumaMatrizBi:MatrizBi*->MatrizBi*->MatrizBi* */
	size_t cantFilas=estructMatrizA->cantFil,cantCol=estructMatrizA->cantCol,i,j,k=estructMatrizB->cantFil;
	Matriz* estructMatrizC=matriz_crear(cantFilas,cantCol);
	float** matrizA=estructMatrizA->direccion, **matrizB=estructMatrizB->direccion, **matrizC=estructMatrizC->direccion;
	for(i=0;i<cantFilas;i++){
		for(j=0;j<cantCol;j++){
			matrizC[i][j]=matrizA[i][j]+matrizB[i][j];
		}
	}
	matriz_destruir(estructMatrizA);
	return estructMatrizC;
}

Matriz* matriz_insertar_fila(Matriz* estructMatriz,int filaNum){
	/*Dado un prto a una estruct MatrizBi y un num de fila, inserta una nueva 
	fila en la pos num de fila.
	insertarFila:MatrizBi*->int*/
	size_t cantFilas=(estructMatriz->cantFil), cantCol=estructMatriz->cantCol,i,j,k;
	Matriz* newEstruct=matriz_crear(cantFilas+1,cantCol);
	float** newMatriz=newEstruct->direccion, **matriz=estructMatriz->direccion;
	for(i=0;i<cantFilas+1;i++){
		k=i;
		for(j=0;j<cantCol;j++){
			if(i>=filaNum-1){
				k++;
			}
			newMatriz[k]=matriz[i];
		}
	}
	matriz_destruir(estructMatriz);
	return newEstruct;
}



/*int main(){
	Matriz* estructMatrizA, *estructMatrizB, *estructMatrizC;
	size_t cantFilas,cantCol, posFil, posCol,filaI,filaJ,filaNum;
	float dato;
	printf("Ingrese la cantidad de filas:");
	scanf("%zu",&cantFilas);
	printf("Ingrese la cantidad de columnas:");
	scanf("%zu",&cantCol);
	estructMatrizA=matriz_crear(cantFilas,cantCol);
	printf("\n");
	matriz_ingresar(estructMatrizA);
	printf("\n");
	matriz_mostrar(estructMatrizA);
	printf("\n");
	/*printf("\n");
	printf("Ingrese la cantidad de filas:");
	scanf("%d",&cantFilas);
	printf("Ingrese la cantidad de columnas:");
	scanf("%d",&cantCol);
	estructMatrizB=crearMatrizBi(cantFilas,cantCol);
	printf("\n");
	ingresarMatrizBi(estructMatrizB);
	printf("\n");
	mostrarMatrizBi(estructMatrizB);
	printf("\n");
	printf("\n");
	estructMatrizC=productoMatrizBi(estructMatrizA,estructMatrizB);
	mostrarMatrizBi(estructMatrizC);
	printf("\n");
	printf("\n");
	printf("Ingrese fila:");
	scanf("%d",&posFil);
	printf("Ingrese col:");
	scanf("%d",&posCol);
	printf("Ingrese dato\n");
	scanf("%f",&dato);
	escribirMatrizBi(estructMatriz,posFil,posCol,dato);
	printf("\n");*/

	/*printf("Ingrese las filas a intercambiar:\n");
	printf("FilaI:");
	scanf("%d",&filaI);
	printf("filaJ:");
	scanf("%d",&filaJ);
	intecambiarFilasMatrizBi(estructMatriz,filaI,filaJ);*/

	/*printf("Ingrese en que posicion desea agregar una fila:");
	scanf("%d",&filaNum);
	estructMatriz=insertarFilaMatrizBi(estructMatriz,filaNum);


	mostrarMatrizBi(estructMatriz);
	//destruiMatrizBi(estructMatriz);

}*/
