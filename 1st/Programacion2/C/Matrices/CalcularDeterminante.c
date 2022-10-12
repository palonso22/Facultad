#include <stdio.h> 
#include <stdlib.h>
#include <math.h>

int **crearMatriz(int CantFilas,int CantColumnas);
void ingresarMatriz(int **Matriz,int CantFilas,int CantColumnas);
int** ReducirMatriz(int** Matriz,int CantFilas,int CantColumnas,int FilaAReducir,int ColumnaAReducir);
int CalcDeterminante(int** Matriz, int CantFilas, int CantColumnas);
void ImprimirMatriz(int** Matriz, int CantFilas,int CantColumnas);



//Programa
int main(){
	int **Matriz,CantFilas,CantColumnas,i,j,**MatrizReducida,determinante;
	printf("Ingrese un tamaño para la matriz:");
	scanf("%d",&CantFilas);
	CantColumnas=CantFilas;
	//Creamos la matriz..
	Matriz=crearMatriz(CantFilas,CantColumnas);
	//Ingresamos valores en la matriz..
	ingresarMatriz(Matriz,CantFilas,CantColumnas);
	//Mostramos la matriz..
	ImprimirMatriz(Matriz,CantFilas,CantColumnas);
	printf("\n\n");
	//Calculamos el determinante.
	determinante=CalcDeterminante(Matriz,CantFilas,CantColumnas);
	//Imprimimos el determinante.
	printf("Su determinante es %d \n",determinante);
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
	printf("La matriz ingresada es: \n");
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas;j++){
			printf("%d ", Matriz[i][j]);
		}
		printf("\n");
	}
}