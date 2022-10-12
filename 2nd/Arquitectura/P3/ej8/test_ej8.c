
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
void sumsse(float*,float*,int);

void sum(float*,float*,int);

int main(){
	unsigned long int nanos;
	struct timespec start, end;
	
	
	//float a[] = {1,2,3,7,3,5,7,20,41}, b[] = {4,5,6,7,6,8,9,3,1};
	float* a = malloc(sizeof(float)*100000000), *b = malloc(sizeof(float)*100000000);
	clock_gettime(CLOCK_REALTIME,&start);
	sumsse(a,b,9);
	clock_gettime(CLOCK_REALTIME,&end);
	nanos = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec);
	
	
	/*for(int i = 0; i < 9;i++){
		printf("%.2f\n",a[i]);
		}*/
	
	printf("Con sumsse el tiempo es %lu nanosegundos.\n",nanos);
	
	printf("\n");
	
	clock_gettime(CLOCK_REALTIME,&start);
	sum(a,b,9);
	clock_gettime(CLOCK_REALTIME,&end);
	/*for(int i = 0; i < 9;i++){
		printf("%.2f\n",a[i]);
		}*/
	nanos = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec);
	printf("Con sum el tiempo es %lu nanosegundos.\n",nanos);
	
	
	
	}
