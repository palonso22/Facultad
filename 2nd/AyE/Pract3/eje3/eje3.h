/*Implementaremos una pila como una pila enlazada mediante una estructura cuyos campos contienen:
 * dato: int que se almacena en la pila
 * sig: ptr al proximo elto en la pila*/
 
#ifndef _pila_
#define _pila_


typedef struct _SNodo{
int dato;
struct _SNodo* sig;
}SNodo;

typedef SNodo* Pila;

/*Crea una pila*/
Pila pila_crear();

/*Determina si la pila está vacia*/
int pila_vacia(Pila p);

/*Toma una pila y devuelve el elto  en la cima*/
int pila_top(Pila p);

/*Agrega un elto a la pila*/
Pila pila_push(Pila p, int d);

/*Toma una pila y elimina el elto en la cima*/
Pila pila_pop(Pila p);

/*Toma una pila y la imprime en orden*/
void pila_imprimir(Pila p);

/*Destruye una pila*/
void pila_destruir(Pila p);


#endif
