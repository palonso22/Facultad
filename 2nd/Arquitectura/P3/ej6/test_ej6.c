#include <stdio.h>
#include <assert.h>

int solve(float a, float b, float c, float d, float e, float f, float* x, float* y);



int main(){
	float x, y;
	printf("%d\n",solve(3.7,0,2,3.9,2.6,1,&x,&y));
	printf("x = %.2f\n",x);
	printf("y = %.2f\n",y);
	printf("\n");
	printf("%d\n",solve(0,0,0,0,0,0,&x,&y));
	printf("x = %.2f\n",x);
	printf("y = %.2f\n",y);
	printf("\n");
	printf("%d\n",solve(0,0,5,0,0,0,&x,&y));
	printf("x = %.2f\n",x);
	printf("y = %.2f\n",y);
	printf("\n");
	printf("%d\n",solve(1,0,5,0,6,10,&x,&y));
	printf("x = %.2f\n",x);
	printf("y = %.2f\n",y);
	printf("\n");
	printf("%d\n",solve(5.2,3,5,3,0,0,&x,&y));
	printf("x = %.2f\n",x);
	printf("y = %.2f\n",y);
	printf("\n");
	printf("%d\n",solve(0,0,5,0,0,0,&x,&y));
	printf("x = %.2f\n",x);
	printf("y = %.2f\n",y);
	
	
	
	
	}

