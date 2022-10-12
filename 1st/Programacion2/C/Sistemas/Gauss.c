#include <stdio.h>
#include <math.h>
#include <stdlib.h>

float **crearMatriz(int CantFilas,int CantColumnas);
void ingresarMatriz(float **Matriz,int CantFilas,int CantColumnas);
void ImprimirMatriz(float **Matriz, int CantFilas,int CantColumnas);
void ERF(float **Matriz,int CantFilas,int CantColumnas);
void CopiarMatrices(float **Matriz,float **MGemela,int CantFilas,int CantColumnas),


int main(){
	float **Matriz,**MERF;
	int CantFilas,CantColumnas,i,j;
	printf("Cantidad de incognitas:\n");
	scanf("%d",&CantFilas);
	CantColumnas=CantFilas;
	CantColumnas+=1;
	//Creamos la matriz con una columna adicional para la solucion..
	Matriz=crearMatriz(CantFilas,CantColumnas);
	//Ingresamos valores en la matriz..
	ingresarMatriz(Matriz,CantFilas,CantColumnas);
	//Mostramos la matriz..
	printf("\n El sistema ingresado es: \n");
	ImprimirMatriz(Matriz,CantFilas,CantColumnas);
	printf("\n\n");
	//Calculamos su Matriz ERF y la imprimimos.
	ERF(Matriz,CantFilas,CantColumnas); 
	printf("Su matriz ERF es:\n");
	ImprimirMatriz(Matriz,CantFilas,CantColumnas);
}







float **crearMatriz(int CantFilas,int CantColumnas){
	/*Crea una matriz.
	crearMatriz: int->int->int**/
	float **Matriz=malloc(sizeof(float*)*CantFilas);
	int i,j;
	for(i=0;i<CantFilas;i++){
			Matriz[i]=calloc(CantColumnas,sizeof(float));
	}
	return Matriz;
}

void ingresarMatriz(float **Matriz,int CantFilas,int CantColumnas){
	/*Permite ingresar valores a una matriz.
	ingresarMatriz:int**->int->int->None*/
	int i,j;
	printf("Ingrese el sistema:\n");
	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas-1;j++){
			printf("X[%d]=",j+1);
			scanf("%f",(Matriz[i]+j));
			if(j<CantColumnas-2){printf("+");}
		}
		printf("=");
		scanf("%f",(Matriz[i]+j));
		printf("\n\n");
	}
}

void ImprimirMatriz(float** Matriz, int CantFilas,int CantColumnas){
	/*Imprime una matriz en pantalla.
	ImprimirMatriz: int**->int->int->void*/
	int i,j;

	for(i=0;i<CantFilas;i++){
		for(j=0;j<CantColumnas-1;j++){
			printf("%.2f  ", Matriz[i][j]);
		}
		printf("| %.2f\n",Matriz[i][CantColumnas-1]);
	}
}


void CopiarMatrices(float **Matriz,float **MGemela,int CantFilas,int CantColumnas){
	/*Dadas dos matrices, copia todo coeficiente de la primera en la segunda.*/
	int i,j;
	for(i=0;i<CantFilas;i++){
			for(j=0;j<CantColumnas;j++){
				MGemela[i][j]=Matriz[i][j];
			}
	}
}


void ERF(float **Matriz,int CantFilas,int CantColumnas){
	/*Dada una matriz devuelve su forma escalon reducida por filas.
	ERF:int**->int->int->int** */
	float Inversa,Coef,Producto,**MGemela=crearMatriz(CantFilas,CantColumnas);
	int i,j,k;
	for(k=0;k<CantFilas;k++){
		CopiarMatrices(Matriz,MGemela,CantFilas,CantColumnas);
		//Calculamos la inversa del lugar kk si kk!=0
		if(Matriz[k][k]!=0){
			Inversa=pow(Matriz[k][k],-1);
			for(i=0;i<CantFilas;i++){
				for(j=0;j<CantColumnas;j++){

					if(i==k){
						//Multiplicamos la fila k por la inversa del lugar kk para hacer 1 en ese lugar.
						Coef=Matriz[i][j];
						Matriz[i][j]=Inversa*Coef;
					}
					else if(j>=k){
						if(k>0){Producto=MGemela[i][k]*MGemela[k][j]*Inversa;}
						else {Producto=MGemela[i][k]*Matriz[k][j];}
						Coef=MGemela[i][j];
						Matriz[i][j]=Coef-Producto;
					}			
				}
			}
		}



		else if(Matriz[k][k]==0){
			i=0;
			while(Matriz[i][k]==0){
				
		}
			}

























	}	
}
