//#include "matriz.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
** Implmentacion utilizando un unico arreglo unidimensional
*/

typedef struct{
	float* direccion;
	size_t cantFilas;
	size_t cantCol;
}Matriz;


Matriz* matriz_crear(size_t cantFilas, size_t cantColumnas) {
	/*Dada la longitud devuelve un ptro a una estructura MatrizUni.
	crarMatrizUni:int->MatrizUni* */
	Matriz *estructMatriz=malloc(sizeof(Matriz));
	float* direccion=malloc(sizeof(float)*cantFilas*cantColumnas);
	//Modificamos los campos 
	estructMatriz->direccion=direccion;
	estructMatriz->cantFilas=cantFilas;
	estructMatriz->cantCol=cantColumnas;
	return estructMatriz;
}

void matriz_ingresar(Matriz* estructMatrizUni){
	/*Dado un ptro a una estructura MatrizUni, permite ingresar vres en la matriz
	apuntada por el campo direccion. */
	//Guardamos cant de col, long del arreglo
	//Def VI
	size_t cantCol=estructMatrizUni->cantCol, cantFilas=estructMatrizUni->cantFilas,longArreglo=cantFilas*cantCol; 
	int i=-1,j=0,k;
	//Guardamos arreglo
	float *matriz=estructMatrizUni->direccion;
	//Ingresamos vres
	//Si j es multiplo de cantCol, j vuelve a 0
	for(k=0;k<longArreglo;k++){
		if(j%cantCol==0){
			j=0,i++;
		}
		printf("M[%d][%d]:",i+1,j+1);
		scanf("%f",matriz+k);
		j++;
	}
}

double matriz_leer(Matriz* matriz, size_t fil, size_t col) {
	/*Dada una posicion en fila y columna, devuelve el valor 
	guardado en esa posición en la matriz.*/
	size_t cantCol=matriz->cantCol, posArreglo=(cantCol*(fil)+(col));
	return matriz->direccion[posArreglo];

}

void matriz_mostrar(Matriz* estructMatrizUni){
	/*Dado un ptro a una estruct MatrizUni imprime todos los valores almacenados en la matriz
	apuntada por el campo direccion.
	mostrarMatrizUni: Matriz*->void*/
	size_t cantCol=estructMatrizUni->cantCol, cantFilas=estructMatrizUni->cantFilas,i,j;
	float *matriz=estructMatrizUni->direccion;
	for(i=0;i<cantFilas;i++){
		for(j=0;j<cantCol;j++){
			printf("%.2f ",matriz_leer(estructMatrizUni,i,j));
		}
		printf("\n");
	} 
}



void matriz_destruir(Matriz* estructMatrizUni) {
	/*Libera la memoria ocupada por el arreglo  y por la estructura en ese orden. 
	destruirMatrizUni:Matrizuni*->none*/
	free(estructMatrizUni->direccion);
	estructMatrizUni->direccion=NULL;
	free(estructMatrizUni);
	estructMatrizUni=NULL;
}



void matriz_escribir(Matriz* matriz, size_t fil, size_t col, double val) {
	/*Dado un ptro a una estruct MatrizUni, una pos en el arreglo apuntado por el campo direccion
	y un dato float, escribe el dato en la pos dada.
	escribirMatrizUni: MatrizUni*->int->float->none*/
	size_t cantCol=matriz->cantCol;
	size_t posArreglo=(cantCol*(fil-1)+(col))-1;
	float* matrizDir=matriz->direccion;
	matrizDir[posArreglo]=val;
}

size_t matriz_num_filas(Matriz* matriz) {
	/*Dado un ptro a una estructura Matriz, retorna el valor del campo cantFilas.
	matriz_num_filas:Matriz*->size_t*/
	return matriz->cantFilas;
}

size_t matriz_num_columnas(Matriz* matriz) {
	/*Dado un ptro a una estructura Matriz, retorna el valor del campo cantCol.
	matriz_num_columnas:Matriz*->size_t*/
	return matriz->cantCol;

}

void matriz_intercambiar_filas(Matriz* estructMatrizUni, size_t filaI, size_t filaJ){
	/*Dado un ptro a una estruct MatrizUni intercambia la fila j por la fila i del arreglo
	apuntado por el campo direccion.
	intercambiarFilasMatrizUni:MatrizUni*->size_t->size_t->none*/
	//Guardamos la cant de col, la cant de filas,long del arreglo,el inicio de las filas a intercambiar
	size_t cantCol=estructMatrizUni->cantCol, cantFilas=estructMatrizUni->cantFilas ,longArreglo=cantCol*cantFilas,inicioFilaI=(filaI-1)*cantCol,inicioFilaJ=(filaJ-1)*cantCol, i;
	//Hacemos una copia de la matriz
	float* matriz=estructMatrizUni->direccion, *matrizCopy=malloc(sizeof(float)*longArreglo);
	memcpy(matrizCopy,matriz,sizeof(float)*cantFilas*cantCol);
	//Recorremos el arreglo reemplazando en los lugares que corresponda
	for(i=0;i<cantCol;i++){
		matriz[inicioFilaI+i]=matrizCopy[inicioFilaJ+i];
	}
		
	for(i=0;i<cantCol;i++){
		matriz[inicioFilaJ+i]=matrizCopy[inicioFilaI+i];
		}
	//Liberamos la memoria usada para copiar la matriz
	free(matrizCopy);
	matrizCopy=NULL;
}

Matriz* matriz_insertar_fila(Matriz* estructMatrizUni,size_t filaNum){
	/*Dado un ptro a una estruct Matriz, agrega una fila al arreglo apuntado
	por el campo direccion en la pos indicada.
	insertarFilaMatrizUni:Matriz*->size_t->Matriz* */
	//Guardamos cantidad de filas y col, la pos en el arreglo, def 2 VI
	size_t cantFilas=estructMatrizUni->cantFilas, cantCol=estructMatrizUni->cantCol, posArreglo=cantCol*(filaNum-1), i,k;
	//Def un ptro a una nueva estructura
	Matriz* newEstructMatrizUni=matriz_crear(cantFilas+1,cantCol);
	//Copiamos los valores moviendo las filas que se encuentran desde la pos de
	//la nueva fila en adelante
	float* newMatriz=newEstructMatrizUni->direccion, *matriz=estructMatrizUni->direccion;
	for(i=0;i<(cantFilas*cantCol);i++){
		k=i;
		if(i>=posArreglo){
			k+=cantCol;
		}
		newMatriz[k]=matriz[i];
	}
	matriz_destruir(estructMatrizUni);
	return newEstructMatrizUni;
}

Matriz* matriz_sumar(Matriz *estructMatrizUniA, Matriz *estructMatrizUniB){
	/*Dados dos ptros a MatrizUni, crea un nuevo ptro a MatrizUni cuyos componentes del arreglo son la 
	suma de los  componentes de los arreglos (iguales) de los primeros dos.
	sumarMatrizUni:MatrizUni*->MatrizUni*->MatrizUni*.*/
	size_t cantFilas=estructMatrizUniA->cantFilas, cantCol=estructMatrizUniA->cantCol,i;
	Matriz* newEstructMatrizUni=matriz_crear(cantFilas,cantCol);
	float* newMatriz=newEstructMatrizUni->direccion,*matrizA=estructMatrizUniA->direccion,*matrizB=estructMatrizUniB->direccion;
	for(i=0;i<cantFilas*cantCol;i++){
		newMatriz[i]=matrizA[i]+matrizB[i];
	}
	return newEstructMatrizUni;
}

Matriz* matriz_producto(Matriz *estructMatrizUniA,Matriz *estructMatrizUniB){
	/* Dados dos ptros a MatrizUni, devuelve un ptro a MatrizUni cuyo campo direccion apunta a un arreglo
	resultante del producto de los arreglos apuntados por el campo direccion de los primeros dos.
	productoMatrizUni: MatrizUni*->MatrizUni*->MatrizUni* */
	
	//Guardamos cant col en arreglo A, cant col en arreglo B, long del arreglo B
	size_t cantFilasA=estructMatrizUniA->cantFilas,cantColB=estructMatrizUniB->cantCol,longArregloB=estructMatrizUniB->cantFilas*cantColB;
	
	//Guardamos long arreglo C, def pos de arreglo A, pos de arreglo B
	size_t longArregloC=cantFilasA*cantColB,posArregloA=0,posArregloB;

	//Def numK, donde numK es igual a la cant de col en A y la cant de fil en B
	//Def var iter 
	size_t numK=estructMatrizUniA->cantCol, i=0,j=0,k;
	float producto;

	//Creamos una estructura donde se almacenara la info de la matriz producto o matriz C
	Matriz* estructMatrizUniC=matriz_crear(cantFilasA,cantColB);

	//Guardamos los arreglos apuntados por la estruct A y la estruct B, guardamos el  arreglo C
	float* matrizA=estructMatrizUniA->direccion,*matrizB=estructMatrizUniB->direccion,*matrizC=estructMatrizUniC->direccion;

	//Recorremos el arreglo C
	for(k=0;k<longArregloC;k++){
		//En cada pos inicializamos producto en 0
		producto=0;
		//La pos inicial del arreglo B será al comienzo de cada col
		posMatrizB=j;

		//Cada sumatoria va de 0 a numK
		for(i=0;i<numK;i++){
			producto+=matrizA[posMatrizA+i]*matrizB[posMatrizB];

			//La pos del arreglo B va recorriendo todas las filas
			posMatrizB+=cantColB;

		}
		//Asignamos el producto escalar a la pos k de arreglo C 
		matrizC[k]=producto;

		//Si llegamos al final del arreglo B, retomamos la primer col del arreglo B
		//y pasamos a la siguiente fil del arreglo A
		if((posMatrizB-cantColB)==(longArregloB-1)){
			j=0;
			posMatrizA+=numK;
		}
		//Sino pasamos a la siguiente col del arreglo B
		else{
			j++;
		}
	}
	return estructMatrizUniC;
}



int main(){
	Matriz* estructMatrizUniA,*estructMatrizUniB,*estructMatrizUniC;
	//int posArreglo, 
	size_t cantFilas,cantCol, posFil, posCol, filaI, filaJ, filaNum;
	float dato;
	printf("Ingrese la cantidad de filas:");
	scanf("%zu",&cantFilas);
	printf("Ingrese la cantidad de col:");
	scanf("%zu",&cantCol);
	estructMatrizUniA=matriz_crear(cantFilas,cantCol); 
	printf("\n");
	matriz_ingresar(estructMatrizUniA);
	printf("\n");
	matriz_mostrar(estructMatrizUniA);
	printf("\n");
	printf("Ingrese la cantidad de filas:");
	scanf("%zu",&cantFilas);
	printf("Ingrese la cantidad de col:");
	scanf("%zu",&cantCol);
	estructMatrizUniB=matriz_crear(cantFilas,cantCol); 
	printf("\n");
	matriz_ingresar(estructMatrizUniB);
	printf("\n");
	matriz_mostrar(estructMatrizUniB);
	printf("\n");
	printf("\n");
	estructMatrizUniC=matriz_producto(estructMatrizUniA,estructMatrizUniB);
	matriz_mostrar(estructMatrizUniC);

	
	/*printf("Ingrese una fila:");
	scanf("%zu",&posFil);
	printf("Ingrese una col:");
	scanf("%zu",&posCol);
	printf("Ingrese dato:");
	scanf("%f",&dato);
	matriz_escribir(estructMatrizUniA,posFil,posCol,dato);
	printf("\n");
	matriz_mostrar(estructMatrizUniA);*/

	
	/*printf("Ingrese las filas a intercambiar:\n");
	printf("fila I:");
	scanf("%zu",&filaI);
	printf("fila J:");
	scanf("%zu",&filaJ);
	matriz_intercambiar_filas(estructMatrizUniA,filaI,filaJ);
	matriz_mostrar(estructMatrizUniA);*/

	/*printf("Ingrese en que posicion desea insertar una fila:");
	scanf("%zu",&filaNum);
	estructMatrizUniA=matriz_insertar_fila(estructMatrizUniA,filaNum);
	matriz_mostrar(estructMatrizUniA);*/

}

/*
if(longArregloC==0 && i!=0){
			m++;
		}
		if(i%)
		for(k=0;k<iterProd;k++0){
			producto+=
		}
		matrizC[i]=*/