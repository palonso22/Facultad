#include <math.h>
#include <stdio.h>
#define PI 3.141589
#define CALC_VOL(r) ((4/3)*PI*(pow(r,3)))
#define radio_Esferas 10


int main(){
	int i,j;
	for(i=1;i<radio_Esferas;i++){
		printf("El radio de la esfea es %.2f\n",CALC_VOL(i));
	}

}