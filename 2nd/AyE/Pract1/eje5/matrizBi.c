#include <stdio.h>
#include <stdlib.h>

typedef struct{
	float** direccion;
	int cantFil;
	int cantCol;
}MatrizBi;


MatrizBi* crearMatrizBi(int cantFilas,int cantCol){
	/*Dado el tamaño de filas y col, crea y retorna un ptro a una estructura MatrizBi
	MatrizBi:int->int->*MatrizBi*/
	//Ptro a una estruct MatrizBi
	MatrizBi* estructMatriz=malloc(sizeof(float**)+sizeof(size_t)*2);
	//Def VI
	int i;
	//Ptro doble que apunte a los ptros fila
	float **matriz=malloc(sizeof(float*)*cantFilas);
	//Reserv mem para cada fila
	for(i=0;i<cantFilas;i++){
		matriz[i]=malloc(sizeof(float)*cantCol);
	}
	//Apuntamos el campo direccion a la matriz creada
	estructMatriz->direccion=matriz;
	//Guardamos la capacidad de fil y col
	estructMatriz->cantFil=cantFilas;
	estructMatriz->cantCol=cantCol;
	return estructMatriz;
}


void ingresarMatrizBi(MatrizBi* estructMatriz){
	/*Dado un ptro a una estruc MatrizBi permite ingresar valores en la matriz apuntada
	por el campo direccion. 
	ingresarMatrizBi:MatrizBi*->none*/
	//2 VI
	int i,j,cantFilas=estructMatriz->cantFil, cantCol=estructMatriz->cantCol;
	//Guardamos matriz
	float **matriz=estructMatriz->direccion;
	//Ingresamos valores
	for(i=0;i<cantFilas;i++){
		for(j=0;j<cantCol;j++){
			printf("M[%d][%d]=",i+1,j+1);
			scanf("%f",matriz[i]+j);
		}
	}
}

void mostrarMatrizBi(MatrizBi* estructMatriz){
	/*Dado un ptro a una estruct MatrizBi muestra los vres guardados en el arreglo
	apuntado por el campo direccion.
	mostrarMatrizBi:MatrizBi*->none*/
	int i,j,cantFilas=estructMatriz->cantFil,cantCol=estructMatriz->cantCol;
	float **matriz=estructMatriz->direccion;
	for(i=0;i<cantFilas;i++){
		for(j=0;j<cantCol;j++){
			printf("%.2f ",matriz[i][j]);
		}
		printf("\n");
	}
}


void escribirMatrizBi(MatrizBi* estructMatriz, int posFil, int posCol, float dato){
	/*Dado un ptro a una estructura MatrizBi, una posicion y un dato, escribe el dato
	en dicha posicion en la matriz  apuntada por el campo direccion.
	escribirMatrizBi:MatrizBi*->int->int->float->none*/ 
	float **matriz=estructMatriz->direccion;
	matriz[posFil-1][posCol-1]=dato;
}

void intecambiarFilasMatrizBi(MatrizBi* estructMatriz, int filaI, int filaJ){
	/*Dado un ptro a una estruct MatrizBi, intercambia las filas dadas en el arreglo apuntado por
	el campo direccion.*/
	float** matriz=estructMatriz->direccion,*ptrI=matriz[filaI-1],*ptrJ=matriz[filaJ-1];

	matriz[filaI-1]=ptrJ;
	matriz[filaJ-1]=ptrI;
	estructMatriz->direccion=matriz;
}



void destruirMatrizBi(MatrizBi* estructMatriz){
	/*Libera la memoria ocupada por las filas del arreglo, el arreglo y la estructura, en 
	ese orden.
	destruirMatrizBi:MatrizBi*->none*/
	int cantFilas=estructMatriz->cantFil,i=0;
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

MatrizBi* sumaMatrizBi(MatrizBi* estructMatrizA,MatrizBi* estructMatrizB){
	/*Dados dos ptros a estruct MatrizBi, devuelve un ptro a MatrizBi cuyo ptro apunta a un arreglo
	cuyas componentes son la suma de las componente de los arreglos apuntados por el campo direccion
	de los primeros dos.
	sumaMatrizBi:MatrizBi*->MatrizBi*->MatrizBi* */
	int cantFilas=estructMatrizA->cantFil,cantCol=estructMatrizA->cantCol,i,j,k=estructMatrizB->cantFil;
	MatrizBi* estructMatrizC=crearMatrizBi(cantFilas,cantCol);
	float** matrizA=estructMatrizA->direccion, **matrizB=estructMatrizB->direccion, **matrizC=estructMatrizC->direccion;
	for(i=0;i<cantFilas;i++){
		for(j=0;j<cantCol;j++){
			matrizC[i][j]=matrizA[i][j]+matrizB[i][j];
		}
	}
	destruirMatrizBi(estructMatrizA);
	return estructMatrizC;
}

MatrizBi* productoMatrizBi(MatrizBi* estructMatrizBiA,MatrizBi* estructMatrizBiB){
	/* Dados dos ptros a MatrizUni, devuelve un ptro a MatrizUni cuyo campo direccion apunta a un arreglo
	resultante del producto de los arreglos apuntados por el campo direccion de los primeros dos.
	productoMatrizUni: MatrizUni*->MatrizUni*->MatrizUni* */
	int cantFilas=estructMatrizBiA->cantFil, cantCol=estructMatrizBiB->cantCol,i,j,k,iterProd=estructMatrizBiA->cantCol,producto;
	MatrizBi* estructMatrizBiC=crearMatrizBi(cantFilas,cantCol);
	float** matrizC=estructMatrizBiC->direccion,**matrizA=estructMatrizBiA->direccion,**matrizB=estructMatrizBiB->direccion;
	for(i=0;i<cantFilas;i++){
		for(j=0;j<cantCol;j++){
			producto=0;
			for(k=0;k<iterProd;k++){
				producto+=(matrizA[i][k]*matrizB[k][j]);
			}
			matrizC[i][j]=producto;
		}
	}
	destruirMatrizBi(estructMatrizBiA);
	destruirMatrizBi(estructMatrizBiB);
	return estructMatrizBiC;
}

MatrizBi* insertarFilaMatrizBi(MatrizBi* estructMatriz,int filaNum){
	/*Dado un prto a una estruct MatrizBi y un num de fila, inserta una nueva 
	fila en la pos num de fila.
	insertarFila:MatrizBi*->int*/
	int cantFilas=(estructMatriz->cantFil), cantCol=estructMatriz->cantCol,i,j,k;
	MatrizBi* newEstruct=crearMatrizBi(cantFilas+1,cantCol);
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
	//destruirMatrizBi(estructMatriz);
	return newEstruct;
}




int main(){
	MatrizBi* estructMatrizA, *estructMatrizB, *estructMatrizC;
	int cantFilas,cantCol, posFil, posCol,filaI,filaJ,filaNum;
	float dato;
	printf("Ingrese la cantidad de filas:");
	scanf("%d",&cantFilas);
	printf("Ingrese la cantidad de columnas:");
	scanf("%d",&cantCol);
	estructMatrizA=crearMatrizBi(cantFilas,cantCol);
	printf("\n");
	ingresarMatrizBi(estructMatrizA);
	printf("\n");
	mostrarMatrizBi(estructMatrizA);
	printf("\n");
	printf("\n");
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
	/*printf("Ingrese fila:");
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