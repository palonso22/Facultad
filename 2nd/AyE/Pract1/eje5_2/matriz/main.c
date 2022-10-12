#include <stdlib.h>
#include <stdio.h>
#include "matriz.h"


int main(){
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
	/*/*printf("\n");
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
	//destruiMatrizBi(estructMatriz);*/

}

