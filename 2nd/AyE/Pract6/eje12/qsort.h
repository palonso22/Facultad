



#ifndef _QSORT_
#define _QSORT_
#include <stdlib.h>
#include <time.h>
#include <stdio.h>

typedef enum{
	RAMDON,
	ULTIMO,
	MEDIO,
	MEDIANA
	}Pivot;





void qsort2(int* , int , int, Pivot, int*);

void imprimir_arreglo(int*, int);







#endif
