#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>


int mcd(int a,int b){
	/*Dados 2 enteros a y b devuelve el máximo común divisor entre ellos
	mcd:int->int->int*/
	//Divisor, dividendo, variable de iteracion,resto,valor de salida
	int divisor,dividendo,i,resto,salida=0;
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


int mcm(int a, int b){
	/*Dados a,b enteros calcula su mcm
	mcm:int->int->int*/
	int mcm,c;
	a=abs(a);
	b=abs(b);
	c=mcd(a,b);
	mcm=(a*b)/c;
	return mcm;
}

void testeo(){
	assert(mcm(3,4)==12);
	assert(mcm(-3,-4)==12);
	assert(mcm(-3,4)==12);
	printf("\ntesteo completo\n");
}

int main(){
	int a,b;
	printf("Ingrese el primer número:");
	scanf("%d",&a);
	printf("Ingrese el segundo número:");
	scanf("%d",&b);
	if (a==0 || b==0){
		printf("Ni a ni b pueden ser 0");
	}
	else{
		printf("Su mcm es %d\n", mcm(a,b));
	}
	testeo();
}










































