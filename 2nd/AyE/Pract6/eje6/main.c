#include "sortg.h"
#define tam(a) (sizeof(a)/sizeof(int))

static int comparar(void* a , void* b){
	return *(int*)a > *(int*)b;
	}


int main(){
	
	int arr[] = {12, 2, 4, 1,9,11,13,0, 3, 7, 8, 6 };
	int arr2[] = {2,1};
	int i;

  isortg(arr, tam(arr), sizeof(int), comparar);
  for (i  = 0; i < tam(arr); ++i)
    printf("%d ", arr[i]);
  puts("");
	
	
	
	}
