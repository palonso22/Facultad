#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define exp_fl(x) ((*(int*)&x & (255 << 23)))

#define man_fl(x)  (*(int*)&x & (int)(pow(2,23)-1))


void imprimir_bin(long int x){
	for(int i = 63; i >= 0;i--){
		printf("%d", x & (1 << i) ? 1:0);
		if (i == 63 || i == 52) printf(" "); 
		}
	}


//void imprimir_bin(int x )










/*int main(){
	float t = pow(2,0.4043463);
	float e = pow(2,76);
	int y = *(int*)&e;
	system("clear");
	printf("\n\n");
	float avogadro = 6.02252;
	printf("Numero a convertir en simple precision: %.5f x 10^23 \n\n",avogadro);
	int x = *(int*)&avogadro;
	printf("%.5f en simple precision:\n",avogadro);
	imprimir_bin(x);
	printf("\n\n");
	printf("10^23 = 2^(76.4043463) = 2^76 * 2^(0.4043463)\n\n");
	printf("2^76 en simple precision:\n");
	imprimir_bin(y);
	printf("\n\n");
	printf("2^(0.4043463) en simple precision:\n");
	int p = *(int*)&t;
	imprimir_bin(p); 
	puts("");
	int b = producto_bin(t,e);
	t = *(float*)&b;
	//int f = producto_bin (t,avogadro);
	//printf("\n\nEl producto es:\n");
	//imprimir_bin(b);
	printf("\n");
	return 0;
	}*/


int main(){
	double t = 1.0;
	long int d = *(long int*)&t;
	imprimir_bin(d);

	}


