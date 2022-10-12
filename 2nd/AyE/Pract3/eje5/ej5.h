#ifndef _COLA_
#define _COLA_
#define MAX_COLA 10

typedef struct _Cola {
int datos[MAX_COLA];
int primero, ultimo;
} *Cola;

/*Crea una cola*/
Cola cola_inicializar();

/*Determina si la cola está vacia */
int cola_es_vacia(Cola c);

/*Agrega el elto al final de la cola*/
void cola_encolar(Cola c, int d);

/*Toma una cola y devuelve el elto en la primer pos*/
int cola_primero(Cola c);

/*Toma una cola y elimina su primer elto*/
void cola_desencolar(Cola c);

/*Imprime una cola*/
void cola_imprimir(Cola c);























#endif
