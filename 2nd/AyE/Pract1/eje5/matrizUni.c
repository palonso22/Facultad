#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct{
	float* direccion;
	int cantFilas;
	int cantCol;
}MatrizUni;

MatrizUni* crearMatrizUni(int cantFilas, int cantCol){
	/*Dada la longitud devuelve un ptro a una estructura MatrizUni.
	crarMatrizUni:int->MatrizUni* */
	MatrizUni *estructMatrizUni=malloc(sizeof(int*)+sizeof(int));
	float* direccion=malloc(sizeof(float)*cantFilas*cantCol);
	//Modificamos los campos 
	estructMatrizUni->direccion=direccion;
	estructMatrizUni->cantFilas=cantFilas;
	estructMatrizUni->cantCol=cantCol;
	return estructMatrizUni;
}

void ingresarMatrizUni(MatrizUni* estructMatrizUni){
	/*Dado un ptro a una estructura MatrizUni, permite ingresar vres en la matriz
	apuntada por el campo direccion. */
	//Guardamos cant de col, long del arreglo
	//Def VI
	int cantCol=estructMatrizUni->cantCol, cantFilas=estructMatrizUni->cantFilas,longArreglo=cantFilas*cantCol,i=-1,j=0,k;
	//Guardamos arreglo
	float *matriz=estructMatrizUni->direccion;
	//Ingresamos vres
	//Si i es multiplo de cantCol, j vuelve a 0
	for(k=0;k<longArreglo;k++){
		if(j%cantCol==0){
			j=0,i++;
		}
		printf("M[%d][%d]:",i+1,j+1);
		scanf("%f",matriz+k);
		j++;
	}
}

void mostrarMatrizUni(MatrizUni* estructMatrizUni){
	/*Dado un ptro a una estruct MatrizUni imprime todos los valores almacenados en la matriz
	apuntada por el campo direccion.
	mostrarMatrizUni: MatrizUni*->void*/
	int cantCol=estructMatrizUni->cantCol, longArreglo=(estructMatrizUni->cantFilas)*cantCol,k;
	float *matriz=estructMatrizUni->direccion;
	for(k=0;k<longArreglo;k++){
		if(k%cantCol==0 && k!=0){
			printf("\n");
		}
		printf("%.2f ",matriz[k]);
	} 
}

void escribirMatrizUni(MatrizUni* estructMatrizUni, int posArreglo, float dato){
	/*Dado un ptro a una estruct MatrizUni, una pos en el arreglo apuntado por el campo direccion
	y un dato float, escribe el dato en la pos dada.
	escribirMatrizUni: MatrizUni*->int->float->none*/
	float* matriz=estructMatrizUni->direccion;
	matriz[posArreglo-1]=dato;
}




void intercambiarFilasMatrizUni(MatrizUni* estructMatrizUni, int filaI, int filaJ){
	/*Dado un ptro a una estruct MatrizUni intercambia la fila j por la fila i del arreglo
	apuntado por el campo direccion.
	intercambiarFilasMatrizUni:MatrizUni*->int->int->none*/
	//Guardamos la cant de col, la cant de filas,long del arreglo,el inicio de las filas a intercambiar
	int cantCol=estructMatrizUni->cantCol, cantFilas=estructMatrizUni->cantFilas ,longArreglo=cantCol*cantFilas,inicioFilaI=(filaI-1)*cantCol,inicioFilaJ=(filaJ-1)*cantCol, i;
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




void destruirMatrizUni(MatrizUni* estructMatrizUni){
	/*Libera la memoria ocupada por el arreglo  y por la estructura en ese orden. 
	destruirMatrizUni:Matrizuni*->none*/
	free(estructMatrizUni->direccion);
	estructMatrizUni->direccion=NULL;
	free(estructMatrizUni);
	estructMatrizUni=NULL;
}


MatrizUni* insertarFilaMatrizUni(MatrizUni* estructMatrizUni,int filaNum){
	/*Dado un ptro a una estruct MatrizUni, agrega una fila al arreglo apuntado
	por el campo direccion en la pos indicada.
	insertarFilaMatrizUni:MatrizUni->int->*/
	//Guardamos cantidad de filas y col, la pos en el arreglo, def 2 VI
	int cantFilas=estructMatrizUni->cantFilas, cantCol=estructMatrizUni->cantCol, posArreglo=cantCol*(filaNum-1), i,k;
	//Def un ptro a una nueva estructura
	MatrizUni* newEstructMatrizUni=crearMatrizUni(cantFilas+1,cantCol);
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
	destruirMatrizUni(estructMatrizUni);
	return newEstructMatrizUni;

}


MatrizUni* sumarMatrizUni(MatrizUni *estructMatrizUniA, MatrizUni *estructMatrizUniB){
	/*Dados dos ptros a MatrizUni, crea un nuevo ptro a MatrizUni cuyos componentes del arreglo son la 
	suma de los  componentes de los arreglos (iguales) de los primeros dos.
	sumarMatrizUni:MatrizUni*->MatrizUni*->MatrizUni*.*/
	int cantFilas=estructMatrizUniA->cantFilas, cantCol=estructMatrizUniA->cantCol,i;
	MatrizUni* newEstructMatrizUni=crearMatrizUni(cantFilas,cantCol);
	float* newMatriz=newEstructMatrizUni->direccion,*matrizA=estructMatrizUniA->direccion,*matrizB=estructMatrizUniB->direccion;
	for(i=0;i<cantFilas*cantCol;i++){
		newMatriz[i]=matrizA[i]+matrizB[i];
	}
	return newEstructMatrizUni;
}

MatrizUni* productoMatrizUni(MatrizUni *estructMatrizUniA,MatrizUni *estructMatrizUniB){
	/* Dados dos ptros a MatrizUni, devuelve un ptro a MatrizUni cuyo campo direccion apunta a un arreglo
	resultante del producto de los arreglos apuntados por el campo direccion de los primeros dos.
	productoMatrizUni: MatrizUni*->MatrizUni*->MatrizUni* */
	int cantFilas=estructMatrizUniA->cantFilas,cantCol=estructMatrizUniB->cantCol,longArregloC=cantFilas*cantCol,producto;
	int iterProd=estructMatrizUniB->cantFilas,ki,posFila,posCol;
	MatrizUni** estructMatrizUniC=crearMatrizUni(cantFilas,cantCol);
	float** matrizA=estructMatrizUniA->direccion,**matrizB=estructMatrizUniB->direccion,**matrizC=estructMatrizUniC->direccion;
	for(i=0;i<longArregloC;i++){
		producto=0;
		if(ilongArregloC==0 && i!=0){
			m++;
		}
		if(i%)
		for(k=0;k<iterProd;k++0){
			producto+=
		}
		matrizC[i]=
	}

}






int main(){
	MatrizUni* estructMatrizUniA,*estructMatrizUniB,*estructMatrizUniC;
	int cantFilas,cantCol,posFil,posCol,posArreglo, filaI, filaJ, filaNum;
	float dato;
	printf("Ingrese la cantidad de filas:");
	scanf("%d",&cantFilas);
	printf("Ingrese la cantidad de col:");
	scanf("%d",&cantCol);
	estructMatrizUniA=crearMatrizUni(cantFilas,cantCol); 
	printf("\n");
	ingresarMatrizUni(estructMatrizUniA);
	printf("\n");
	mostrarMatrizUni(estructMatrizUniA);
	printf("\n");
	printf("Ingrese la cantidad de filas:");
	scanf("%d",&cantFilas);
	printf("Ingrese la cantidad de col:");
	scanf("%d",&cantCol);
	estructMatrizUniB=crearMatrizUni(cantFilas,cantCol); 
	printf("\n");
	ingresarMatrizUni(estructMatrizUniB);
	printf("\n");
	mostrarMatrizUni(estructMatrizUniB);
	printf("\n");
	printf("\n");
	estructMatrizUniC=productoMatrizUni(estructMatrizUniA,estructMatrizUniB);
	mostrarMatrizUni(estructMatrizUniC);

	
	/*printf("Ingrese una fila:");
	scanf("%d",&posFil);
	printf("Ingrese una col:");
	scanf("%d",&posCol);
	printf("Ingrese dato:");
	scanf("%f",&dato);
	posArreglo=cantCol*(posFil-1)+(posCol);
	escribirMatrizUni(estructMatrizUni,posArreglo,dato);
	printf("\n");
	mostrarMatrizUni(estructMatrizUni);*/
	
	/*printf("Ingrese las filas a intercambiar:\n");
	printf("fila I:");
	scanf("%d",&filaI);
	printf("fila J:");
	scanf("%d",&filaJ);
	intercambiarFilasMatrizUni(estructMatrizUni,filaI,filaJ)

	printf("Ingrese en que posicion desea insertar una fila:");
	scanf("%d",&filaNum);
	estructMatrizUni=insertarFilaMatrizUni(estructMatrizUni,filaNum);
	mostrarMatrizUni(estructMatrizUni);*/

}