#ifndef _COLAS_
#define _COLAS_


typedef struct _CDNodo{
	int dato;
	struct _CDNodo* sig;
	struct _CDNodo* ant;
	}*CDList;



typedef CDList Cola;

/*Crea una cola*/
Cola cola_crear();

/*Determina si una cola es vacia*/
int cola_es_vacia(Cola c);

/*Devuelve el primer elto de una cola*/
int* cola_primero(Cola c);

/*Agrega eltos al inicio de la cola*/
void cola_encolar(Cola* c, int dato);

/*Imprimir cola*/
void cola_imprimir(Cola c);

/*Elimima el ultimo elto de una cola*/
void cola_desencolar(Cola* c);

#endif
