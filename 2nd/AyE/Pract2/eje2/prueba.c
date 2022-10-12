#include <stdio.h>

typedef int (*comparacion)(int a,int b);

int menor(int a, int b){
	if (a<b) return a;
	return b;
}

int comp(int a,int b,comparacion compara){
	compara(a,b);
}

int main(){
	printf("El menor es %d\n",comp(3,2,menor));

}