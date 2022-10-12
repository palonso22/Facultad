#include <setjmp.h>
#include  <stdio.h>



long int buf[8];


int setjmp2(long int*);

void longjmp2(long int*, int);

int f2(){
	longjmp2(buf,0);
	printf("No deberia llegar hasta aca");
	return 1;
	}


int main(){
	if(setjmp2(buf) == 0){
		printf("Bufer copiado\n");
		f2();
		}
	else{
		printf("Salto realizado\n");
		return 0;
		}
	longjmp2(buf,0);
	return 0;
	
	
	}


