#include "diccionario.h"
#define mayuscula(x) ((int)x < 65 || (int)x> 90 ? 0 : 1)
#define minuscula(x) ((int)x < 97 || (int)x > 122 ? 0 : 1)




char* llenarBufer(char* bufer, char* linea, int longitud){
	if(!bufer){
	  bufer = malloc(sizeof(char)*longitud);
	  bufer = strncpy(bufer,linea,longitud-2);
	  return bufer;
		}
	bufer = realloc(bufer,strlen(bufer) + strlen(linea));
	bufer = strcat(bufer,linea);
	return bufer;
	}


Tabla crearTabla(Hash fHash, Hash fHash2){
	Casilla* tabla, c;
	Tabla t = malloc(sizeof(struct _TablaHash));
	t->tabla = malloc(sizeof(Casilla)* tamTabla);
	t->eltos = tamTabla;
	t->hash = fHash;
	t->hash2 = fHash2;
	//Inicializamos las casillas
	tabla = t->tabla;
	for(int i = 0; i < tamTabla;i++){
		tabla[i] = malloc(sizeof(AVL)*tamAlfabeto);
		for(int j = 0; j < tamAlfabeto;j++){
			tabla[i][j] = NULL;
			}
		}
	return t;
}

 
void agregarPalabra(char* palabra, Tabla t){
	if(!palabra || !t)return;
	//Calcular en que casilla se guarda la palabra de acuerdo a su longitud
	int idx = t->hash(palabra), i = 0, idx2;
	//Calcular en que  arbol se guarda la palabra de acuerdo a su primer caracter
	idx2 = t->hash2(palabra);
	//Almacenar palabra en un arbol AVL
	t->tabla[idx][idx2] = arbolInsertar(t->tabla[idx][idx2],palabra);
		}


int buscarPalabra(char* palabra, Tabla t){
	int idx = t->hash(palabra), idx2 = t->hash2(palabra);
	AVL arbol = t->tabla[idx][idx2];
	}



int analizarPalabra(char* palabra, Tabla t){
	if(!palabra)return 0;
	int longitud = strlen(palabra);
	char p = palabra[0];
	//Caso palabra empieza con simbolos
	while(longitud > 0 && !mayuscula(p) && !minuscula(p)){
		for(int i = 1;i < longitud;i++){
			palabra[i-1] = palabra[i];
			}
		longitud--;
		p = palabra[0];
		}
	if(longitud == 0)return 0;
	//Caso palabra termina con simbolos
	char u = (int)palabra[longitud-1];
	while(longitud > 1 && !mayuscula(u) && !minuscula(u)){
			palabra[longitud-1] = '\0';
			longitud--;
			u = palabra[longitud-1];
		}
	//Si la palabra está en  el universo es aceptada
	int idx = t->hash(palabra), idx2 = t->hash2(palabra); 
	if(arbolBuscar(palabra,t->tabla[idx][idx2])){
		return 0;
		}
	return 1;	
	}







