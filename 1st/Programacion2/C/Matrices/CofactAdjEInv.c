#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void ImprimirMatriz(int** Matriz, int CantFilas,int CantColumnas);
int** MatrizTranspuesta(int** Matriz,int CantFilas,int CantColumnas);
int** crearMatriz(int CantFilas,int CantColumnas);
int** ReducirMatriz(int** Matriz,int CantFilas,int CantColumnas,int FilaAReducir,int ColumnaAReducir);
int CalcDeterminante(int** Matriz, int CantFilas, int CantColumnas);
int** MatrizDCofactores(int** Matriz,int CantFilas,int CantColumnas);
int** MatrizInversa(int** Matriz,int**MAdjunta,int CantFilas,int CantColumnas);












int main(){
	int Matriz[3][3]={{4,8,9},{-5,46,4},{21,30,50}},i,j;
	int **ptrMatriz=malloc(sizeof(int*)*3),**MCofactores,**MAdjunta,**MInversa;
	ptrMatriz[0]=Matriz[0];
	ptrMatriz[1]=Matriz[1];
	ptrMatriz[2]=Matriz[2];
	MCofactores=MatrizDCofactores(ptrMatriz,3,3);
	printf("La matriz de cofactores es: \n");
	ImprimirMatriz(MCofactores,3,3);
	printf("\n");
	MAdjunta=MatrizTranspuesta(MCofactores,3,3);
	printf("La matriz adjunta es: \n");
	ImprimirMatriz(MAdjunta,3,3);
	printf("\n");
	MInversa=MatrizInversa(ptrMatriz,MAdjunta,3,3);
	printf("La matriz inversa es: \n");
	ImprimirMatriz(MInversa,3,3);
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

void ImprimirMatriz(int** Matriz, int CantFilas,int CantColumnas){
	/*Imprime una matriz en pantalla.
	ImprimirMatriz: int**->int->int->void*/
	int i,j;
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas;j++){
			printf("%.2f ", (float)Matriz[i][j]);
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

int** MatrizInversa(int** Matriz,int**MAdjunta,int CantFilas,int CantColumnas){
	/*Dada una matriz calcula su matriz de cofactores.
	MatrizDeCofactores: int**->int->int->int** */
	int **MInversa=crearMatriz(CantFilas,CantColumnas),i,j,determinante;
	determinante=CalcDeterminante(Matriz,CantFilas,CantColumnas);
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas;j++){
			(float)MInversa[i][j];
			MInversa[i][j]=pow(determinante,-1)*MAdjunta[i][j];
			printf("%.2f ",MInversa[i][j]);
		}
	}
	return MInversa;
}