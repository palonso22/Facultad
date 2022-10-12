
#ifndef _pila_
#define _pila_

typedef struct _Pila {
int* datos;
int ultimo;
int max_pila;
} *Pila;

Pila pila_crear();

int pila_vacia(Pila p);

int pila_top(Pila p);

void pila_push(Pila p, int d);

void pila_pop(Pila p);

void pila_imprimir(Pila p);

#endif
