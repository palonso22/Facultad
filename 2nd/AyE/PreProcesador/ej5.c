#include <stdio.h>
#define MININUM2(a,b)(a>b ? b:a)

#define MININUM3(a,b,c)(MININUM2(MININUM2(a,b),c))


int main(){
	int a,b,c;
	printf("Introduzca el primer número:");scanf("%d",&a);
	printf("Introduzca el segundo número:");scanf("%d",&b);
	printf("Introduzca el tercer número:");scanf("%d",&c);
	printf("El mínimo es %d",MININUM3(a,b,c));
}