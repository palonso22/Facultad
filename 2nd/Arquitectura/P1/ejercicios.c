#include <stdio.h>
#include  <math.h>


void imprimirBin(int var){
	int aux = 0;
	for(int i = sizeof(var)*8-1; i >= 0  ;i--){
		aux++;
		printf("%d", (var & (1 << i) ? 1 : 0));
		if(aux % 8 == 0)printf(" ");
		}
	}





unsigned mult(unsigned a, unsigned b){
	//Comparar por igualdad b con 0 y 1
	if( !b )return 0;
	if(b == 1)return a;
	//Caso par
	if(!(b & 1) ){
		return mult(a << 1,b >> 1);
		}
	//Caso impar
	return (mult(a << 1 , b >> 1) ) + a; 
	}



/*void rotar(int a, int b, int c, int d){
	//Rotar los valores
	a = a ^ b ^ c ^ d;
	b = a ^ d ^ c ^ b;
	c = b ^ a ^ d ^ c;
	d = c ^ b ^ a ^ d;
	a = d ^ c ^ b ^ a;
	}*/





/*void rotar(int* a, int* b, int* c){
	int aux = *a;
	*a = auxRotar(*a,*b);
	*b = auxRotar(*b,*c);
	*c = auxRotar(*c,aux);
	}*/


int main(){
	//short i = 1;
	int i = 1;
	/*int a = -5, b = 35, c = 4;
	//int var = -1 & (~ (1 << 8)) ;
	//var = ~var;
	/*int var = 5 , var2 = 8;
	var = var << 8;
	var2 = var2 << 7; 
	imprimirBin(var);
	puts("");
	var = var + var2;
	//var = -1 & var << ((sizeof(var)*8-1) / 4)+1;
	//var = (var |  1) << (sizeof(var)*8-1);
	//var = (1 << (sizeof(var)*8-1) ) | (1 << ((sizeof(var)*8-1) / 2) );
	//var = -1 & (1 << ((sizeof(var)*8-1) / 4) );
	//rotar(&a,&b,&c);
	printf("%d",mult(b,1));*/
	i = i << 30;
	imprimirBin(i);
	puts("");
	i = i << 15;
	imprimirBin(i);
	i = i >> 15;
	puts("");
	imprimirBin(i); 
	}



