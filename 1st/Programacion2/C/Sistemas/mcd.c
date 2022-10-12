#include <stdio.h>
#include <math.h>
#include <assert.h>
#include <stdlib.h>


int mcd(int a,int b){
	/*Dados 2 enteros a y b devuelve el máximo común divisor entre ellos
	mcd:int->int->int*/
	//Divisor, dividendo, variable de iteracion,resto,valor de salida
	int divisor,dividendo,i,resto,salida=0;
	a=abs(a);
	b=abs(b);
	//Dividendo es el nro mayor
	if (a>b){
		dividendo=a;
		divisor=b;
	}
	else if (b>a){
		dividendo=b;
		divisor=a;
	}
	else{
		return a;
	}
	//Algoritmo de Euclides
	while(salida==0){
		for(i=0;divisor*i<=dividendo;i++){
		}
		resto=dividendo-divisor*(i-1);
		printf("%d=%d-%d*%d\n",resto,dividendo,divisor,(i-1));
		if(resto==0){
			salida=1;
		}
		else{
		dividendo=divisor;
		divisor=resto;
	}
}
	return divisor;
}





int main(){
	int a,b;
	printf("Ingrese el primer número:");
	scanf("%d",&a);
	printf("Ingrese el segundo número:");
	scanf("%d",&b);
	if (a==0 || b==0){
		printf("Ni a ni b pueden ser 0\n");
	}
	else{
		printf("El mcd de %d y %d es %d\n",a,b,mcd(a,b));
		assert(mcd(6,3)==3);
		assert(mcd(9,3)==3);
		assert(mcd(3,2)==1);
		printf("Testeo Completo...\n");
	}
}





