#include <stdio.h> 
#include <stdlib.h>
#include <math.h>

int **crearMatriz(int CantFilas,int CantColumnas);
void ingresarMatriz(int **Matriz,int CantFilas,int CantColumnas);
int** ReducirMatriz(int** Matriz,int CantFilas,int CantColumnas,int FilaAReducir,int ColumnaAReducir);
int CalcDeterminante(int** Matriz, int CantFilas, int CantColumnas);
void ImprimirMatriz(int** Matriz, int CantFilas,int CantColumnas);
int** MatrizDCofactores(int** Matriz,int CantFilas,int CantColumnas);
int** MatrizTranspuesta(int** Matriz,int CantFilas,int CantColumnas);
float** MatrizInversa(int determinante,int**MAdjunta,int CantFilas,int CantColumnas);
float **crearMatrizInversa(int CantFilas,int CantColumnas);
void ImprimirMatrizInversa(float** Matriz, int CantFilas,int CantColumnas);

//Programa
int main(){
	int **Matriz,CantFilas,CantColumnas,i,j,**MatrizReducida,determinante,**MCofactores,**MAdjunta;
	float **MInversa;
	printf("Ingrese un tamaño para la matriz:");
	scanf("%d",&CantFilas);
	CantColumnas=CantFilas;
	//Creamos la matriz..
	Matriz=crearMatriz(CantFilas,CantColumnas);
	//Ingresamos valores en la matriz..
	ingresarMatriz(Matriz,CantFilas,CantColumnas);
	//Mostramos la matriz..
	printf("\nLa matriz ingresada es: \n");
	ImprimirMatriz(Matriz,CantFilas,CantColumnas);
	printf("\n\n");
	//Calculamos el determinante.
	determinante=CalcDeterminante(Matriz,CantFilas,CantColumnas);
	//Imprimimos el determinante.
	printf("Su determinante es %d \n",determinante);
	MCofactores=MatrizDCofactores(Matriz,CantFilas,CantColumnas);
	//Calculamos su matriz de cofactores y la mostramos en pantalla.
	printf("\nSu matriz de cofactores es:\n");
	ImprimirMatriz(MCofactores,CantFilas,CantColumnas);
	printf("\n");
	//Calculamos su adjunta y la imprimimos.
	MAdjunta=MatrizTranspuesta(MCofactores,CantFilas,CantColumnas);
	printf("\nSu adjunta es:\n");
	ImprimirMatriz(MAdjunta,CantFilas,CantColumnas);
	//Calculamos su inversa y la imprimimos.
	MInversa=MatrizInversa(determinante,MAdjunta,CantFilas,CantColumnas);
	printf("\nLa matriz inversa es: \n");
	ImprimirMatrizInversa(MInversa,CantFilas,CantColumnas);
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
			printf("Matriz[%d][%d]:",i+1,j+1);
			scanf("%d",(Matriz[i]+j));
		}
	}
}

int** ReducirMatriz(int** Matriz,int CantFilas,int CantColumnas,int FilaAReducir,int ColumnaAReducir){
	/*Devuelve una matriz igual a la dada pero sin la fila y columna indicadas.
	ReducirMatriz:int**->int->int->int->int->int** */

	//Variables de tamaño(FilasMReducida,ColumnasMReducida) y variables de posición(i,j,l,k).
	int FilasMReducida=CantFilas-1,ColumnasMReducida=CantColumnas-1,i,j,l=0,k;
	int** MatrizReducida=crearMatriz(FilasMReducida,ColumnasMReducida);
	for(i=0;i<CantFilas;i++){
		k=0;
		for(j=0;j<CantColumnas;j++){
			//Copiamos todos los valores de la matriz a la matriz reducida excepto aquellos que esten en la fila y columna indicadas.
			if(i!=FilaAReducir-1 && j!=ColumnaAReducir-1){
				MatrizReducida[l][k]=Matriz[i][j];
				k++;
				//Al haber terminado de copiar una fila avanzamos a la siguiente.
				if(k==ColumnasMReducida){
					l++;
				}
			}
		}
		
	}
	return MatrizReducida;
}

int CalcDeterminante(int** Matriz, int CantFilas, int CantColumnas){
	/*Calcula la determinante de una matriz.
	determinante: int**->int->int->int*/
	int determinante=0;
	if(CantFilas==1 && CantColumnas==1){
		determinante+=Matriz[0][0];
		return determinante;
	}
	int j;
	for(j=0;j<CantColumnas;j++){
		int** MatrizReducida=ReducirMatriz(Matriz,CantFilas,CantColumnas,1,j+1);
		determinante+=pow(-1,2+j)*Matriz[0][j]*CalcDeterminante(MatrizReducida,CantFilas-1,CantColumnas-1);
	}
	return determinante;
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

int** MatrizDCofactores(int** Matriz,int CantFilas,int CantColumnas){
	/*Dada una matriz calcula su matriz de cofactores.
	MatrizDeCofactores: int**->int->int->int** */
	int **MCofactores=crearMatriz(CantFilas,CantColumnas),i,j,cofactor;
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas;j++){
			cofactor=pow(-1,i+j)*CalcDeterminante(ReducirMatriz(Matriz,CantFilas,CantColumnas,i+1,j+1),CantColumnas-1,CantColumnas-1);
			MCofactores[i][j]=cofactor;
		}
	}
	return MCofactores;
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

float** MatrizInversa(int determinante,int**MAdjunta,int CantFilas,int CantColumnas){
	/*Dada una matriz y su adjunta, calcula su inversa.
	MatrizDeCofactores: int->int**->int->int->float** */
	float **MInversa=crearMatrizInversa(CantFilas,CantColumnas);
	int i,j;
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas;j++){
			MInversa[i][j]=pow(determinante,-1)*MAdjunta[i][j];
		}
	}
	return MInversa;
}


float **crearMatrizInversa(int CantFilas,int CantColumnas){
	/*Crea una matriz de tipo float.
	crearMatriz: int->int->float**/
	float **Matriz=malloc(sizeof(float*)*CantFilas);
	int i,j;
	for(i=0;i<CantFilas;i++){
			Matriz[i]=malloc(sizeof(float)*CantColumnas);
	}
	return Matriz;
}


void ImprimirMatrizInversa(float** Matriz, int CantFilas,int CantColumnas){
	/*Imprime la matriz inversa en pantalla.
	ImprimirMatriz: int**->int->int->none*/
	int i,j;
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas;j++){
			printf("%.2f ", Matriz[i][j]);
		}
		printf("\n");
	}
}
