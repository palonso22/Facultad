#include  <stdio.h>


#define SUMARRAY(x,y,suma) for(int i=0;i<y;i++){suma+=x[i];}



int main(){
	int array[]={1,2,3,4,5,6,76,7,8,9},suma=0,result;
	SUMARRAY(array,10,suma);
	printf("La suma de los elementos del arreglo es %d",suma);
}