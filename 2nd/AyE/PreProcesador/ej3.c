#include <stdio.h>



#define SUM(x,y)(x+y)

int main(){
	int x=3,y=5;
	printf("La suma de %d y %d es %d",x+y,y,SUM(x+y,y));
	return 0;
} 