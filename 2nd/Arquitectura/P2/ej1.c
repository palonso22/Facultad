#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ieee754.h>

#define exp_fl(x) ((*(int*)&x & (255 << 23)) >> 23) - 127


#define man_fl(x)  (*(int*)&x & (int)(pow(2,23)-1))























void imprimir_bin(int x){
	for(int i = 31; i >= 0; i--){
		printf("%d", x & ( 1 << i) ? 1 : 0);
		if( i == 31 || i == 23) printf(" ");
		}
	}





int main(){
	system("clear");
	printf("\n\n\n\n\n");
	printf("                                            ");
	float x = 4.75, t;
	int m = man_fl(x);
	int e = exp_fl(x);
	int y = (int)(pow(2,7)-1) << 23;
	y = y | m;
	t = *(float*)&y;
	printf("\n%.2f",t*pow(2,e));
	
	
	
	
	
	}
