#include <stdio.h>
#include <stdlib.h>
#define SUMATORIA(dimension) (dimension==0 ? 0:(dimension)*(dimension+1)/2)
#define TRUE 1
#define FALSE 0
#define CERO 0.00

/*Represent una matriz triang inferior con un estructura.
	*El campo direccion es un ptro al arreglo.
	*El campo dimension da el tamaño a la matriz.
*/

typedef struct{
	float* direccion;
	size_t dimension;
}MatrizTriangInf;


MatrizTriangInf* matriz_crear(size_t dimension){
	/*Dada la dimension retorna un ptro a una estructura 
	MatrizTriangInf.
	crear_matriz:size_t->MatrizTriangInf* */
	MatrizTriangInf* estructMatriz=malloc(sizeof(MatrizTriangInf));
	estructMatriz->direccion=malloc(sizeof(float)*SUMATORIA(dimension));
	estructMatriz->dimension=dimension;
	return estructMatriz;
}


void matriz_ingresar(MatrizTriangInf* estructMatriz){
	/*Permite ingresar valores en el arreglo apuntado por el campo direccion.
	matriz_ingresar:MatrizTriangIng*->none */
	size_t dimension=estructMatriz->dimension,cantVres=SUMATORIA(dimension), i;
	float* arreglo=estructMatriz->direccion;
	for(i=0;i<cantVres;i++){
		printf("Arreglo[%zu]=",i);
		scanf("%f",arreglo+i);
	}
}

int posicion_permitida(size_t fila, size_t col){
	/*Determina si la posicion en un arreglo está permitida.
	posicion_permitida:size_t->size_t->int */
	//Si col>fila no habrá ningún valor en el arreglo para esta posicion
	if(col>fila){
		return FALSE;
	}
	return TRUE;
}

double matriz_leer(float* arreglo,size_t fila, size_t col){
	/*Dada una posicion en fila y col devuelve el dato alojado en esa posicion
	en el arreglo ap untado por el campo direccion del ptro a una estructura MatrizTriangInf.
	matriz_leer:MatrizTriangInf*->size_t->size_t->double */
	//Verificamos que halla algún valor para está posicion en el arreglo
	if(!posicion_permitida(fila,col)){
		return CERO;
	}
	else{
		size_t posArreglo=SUMATORIA(fila)+col;
		return arreglo[posArreglo];
	}
}

void matriz_mostrar(MatrizTriangInf* estructMatriz){
	/*Dado un ptro a una estructura MatrizTriangInf
	muestra por pantalla el arreglo apuntado por su campo direccion.
	matriz_mostrar:MatrizTriangInf*->none */
	size_t dimension=estructMatriz->dimension, cantEltosArreglo=SUMATORIA(dimension),i,j;
	float* arreglo=estructMatriz->direccion;
	for(i=0;i<dimension;i++){
		for(j=0;j<dimension;j++){
			// matriz_leer(arreglo,i,j);
			printf("%.2f ", matriz_leer(arreglo,i,j));
		}
		printf("\n");
	}

}

void matriz_escribir(MatrizTriangInf* estructMatriz,size_t fila, size_t col, double val){
	/*Dado un ptro a una estructura MatrizTriangInf, una pos en fila y col y un valor double,
	escribe el valor en el arreglo apuntado por el campo direccion de la estructura en la posicion
	dada.
	matriz_escribir:MatrizTriangInf*->size_t->size_t->double->none*/
	if(!posicion_permitida(fila,col)){
		printf("Elija otra posicion:\n");
		printf("Fila:");
		scanf("%zu",&fila);
		printf("Columna:");
		scanf("%zu",&col);
		matriz_escribir(estructMatriz,fila-1,col-1,val);
	}
	size_t posArreglo=SUMATORIA(fila)+col;
	float* arreglo=estructMatriz->direccion;
	arreglo[posArreglo]=val;
}

void matriz_destruir(MatrizTriangInf* estructMatriz){
	/*Dado un ptro a una estructura MatrizTriangInf, libera 
	la memoria ocupado por la estructura y sus campos.
	matriz_destuir:MatrizTriangInf*->void*/
	free(estructMatriz->direccion);
	estructMatriz->direccion=NULL;
	free(estructMatriz);
	estructMatriz=NULL;
}




int main(){
	size_t dimension, posFil,posCol;
	double val;
	printf("Ingrese la dimension:");
	scanf("%zu",&dimension);
	MatrizTriangInf* estructMatriz=matriz_crear(dimension);
	printf("Ingrese valores:\n");
	matriz_ingresar(estructMatriz);
	matriz_mostrar(estructMatriz);
	printf("\n");
	printf("Ingrese fila:");
	scanf("%zu",&posFil);
	printf("Ingrese col:");
	scanf("%zu",&posCol);
	printf("Ingrese valor a escribir:");
	scanf("%lf",&val);
	matriz_escribir(estructMatriz,posFil-1,posCol-1,val);
	matriz_mostrar(estructMatriz);
}