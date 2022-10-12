#include <stdio.h>
#define MININUM2(a,b)(a>b ? b:a)


int main(){
	int a,b;
	printf("Introduzca el primer número:");scanf("%d",&a);
	printf("Introduzca el segundo número:");scanf("%d",&b);
	printf("El mínimo es %d",MININUM2(a,b));
}