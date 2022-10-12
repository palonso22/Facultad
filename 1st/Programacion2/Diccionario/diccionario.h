

#ifndef _DICCIONARIO_
#define _DICCIONARIO_
#define tamTabla 31
#define tamAlfabeto 63
#define max(a,b) (a >= b ? a:b)
#define alt(n) (n ? n->alt : -1)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
typedef enum{
	DIZQ,
	DDER,
	SIZQ,
	SDER
	}Orden;






//Funcion de hashs
typedef int (*Hash)(char*);


//Arbol AVL
typedef struct _AVL{
	int alt;
	char* palabra;
	struct _AVL* izq;
	struct _AVL* der;
	}*AVL;


//Casilla 
typedef AVL* Casilla;


//Tabla
typedef struct _TablaHash{
	Hash hash;
	Hash hash2;
	int eltos;
	Casilla*  tabla;
	}*Tabla;
	

//Lista
typedef struct _SList{
	char* palabra;
	struct _SList* sig;
	}*SList;





//Bufer auxiliar para almacenar informacion
char* llenarBufer(char*,char*,int);


//Crea la tabla hash
Tabla crearTabla(Hash,Hash);

//Agregar palabra a una tabla
void agregarPalabra(char*,Tabla);






/**Funciones de arbol AVL**/


//Insertar palabra a un arbol
AVL arbolInsertar(AVL,char*);

//Imprime un arbol AVL
void arbolImprimir(AVL);

//Busca en un arbol AVL
int arbolBuscar(char*,AVL);

/**Funciones de analisis de cadena**/
int analizarPalabra(char*,Tabla);


/**Funciones de lista**/
SList crearLista();


SList agregarLista(char*,SList);

#endif
