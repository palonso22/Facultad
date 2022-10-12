
#ifndef _CARTAS_
#define _CARTAS_
#include <stdio.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>

typedef int (*FunCmp) (void*, void*);

typedef enum {
BASTO,
ORO,
ESPADA,
COPAS
} Palo;





typedef struct carta_ {
Palo palo;
int numero;
} carta;

void isortg(carta*, int, size_t, FunCmp);

char* determinar_palo(Palo );

#endif
