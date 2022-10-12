#include <stdio.h>
#define PRINT(z) (printf("%d\n",z))
#define PRINTARRAY(x,y) for(int i=0;i<y;i++){PRINT(x[i]);}

int main(){
	int array[]={1,2,3,4};
	PRINTARRAY(array,4);

	return 0;
}