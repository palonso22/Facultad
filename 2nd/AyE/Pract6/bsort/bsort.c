#include <stdio.h>

static void swap(int *p, int *q) {
  int t = *p;
  *p = *q;
  *q = t;
}

void bsort(int datos[], int tam) {
  int ordenado = 0, i;
	printf("%d \n",tam);
   for(int k = 1; k < tam -1 ;k++){
    for (i = 0; i < tam - 1; ++i)
      if (datos[i] > datos[i + 1])swap(&datos[i], &datos[i + 1]);
  }
}
