


#ifndef _SORTG_
#define _SORTG_
#include <stdlib.h>
#include <stdio.h>

typedef int (*CmpFunc)(void *, void *);

void bsortg(void *base, int tam, size_t size, CmpFunc cmp);



void isortg(void *base, int tam, size_t size, CmpFunc cmp);



void ssortg(void *base, int tam, size_t size, CmpFunc cmp);






#endif
