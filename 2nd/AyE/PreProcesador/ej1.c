
#line 3000	
#include <stdio.h>

#define TRUE 0

#if TRUE!=0 
#define  FALSE 0
#else
#define FALSE 1
#endif
#define DEV(a,b)(a>b? a:b)


int main(){
	printf("%d",DEV(28,5));
	return 0;

}