#include <stdio.h>
#include <math.h>
#include <stdlib.h>

//Calcula el exponente de la representacion en simple precision
#define exp_fl(x) ((*(int*)&x & (255 << 23)) >> 23) - 127

//Extrae la mantisa de la representacion en simple precision
#define man_fl(x)  (*(int*)&x & (int)(pow(2,23)-1))

/*int myisnan(float x){
	if(exp_fl(x) == 128 && man_fl(x) != 0)return 1;
	return 0;
	}*/



void imprimir_bin(int x){
	for(int i = sizeof(x)*8-1; i >= 0; i--){
		printf("%d", x & ( 1 << i) ? 1 : 0);
		if( i == 31 || i == 23) printf(" ");
		}
	}
	

int myisnan2(float x){
	float t = pow(2,128);
	t = t - t;
	if(*(int*)&x == *(int*)&t)return 1;
	return 0;
	}




int main() {
	/*//Testeo
	system("clear");
	printf("\n\n\n\n\n");
	
	//0/0
	float g = 0;
	float f = 0;
	f = g/f;
	printf("0 / 0 is nan?: %d \n",myisnan(f));
	printf("\n nan: %d\n",myisnan(f));
	
	
	//inf/inf
	int inf = -8388608, inf2 = 2139095040 ;
	g = *(float*)&inf;
	f = *(float*)&inf2;
	f = g/f;
	printf("inf / inf is nan?: %d \n",myisnan(f));
	printf("\n nan: %d\n",myisnan(f));
	
	
	//0*inf
	g = 0;
	f = g*f;
	printf("0 * inf is nan?: %d \n",myisnan(f));
	printf("\n nan: %d\n",myisnan(f));
	
	//inf - inf
	
	g = *(float*)&inf;
	f = *(float*)&inf; 
	f = g-f;
	printf("inf - inf is nan?: %d \n",myisnan(f));
	printf("\n nan: %d\n",myisnan(f));*/
	float t = pow(2,128),s = 1;
	t = t + s;
	int p = *(int*)&t;
	imprimir_bin(p);
	printf("%.2f",t + 1);
	
	
}
