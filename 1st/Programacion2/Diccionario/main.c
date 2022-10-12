#include "diccionario.h"
#define TAM 1000
#define par 40


int hash(char* cadena){
	return strlen(cadena)-1;
	}



int hash2(char* cadena){
	int aux;
	//Caso ñ y Ñ
	if(!strncmp("ñ",cadena,2) || !strncmp("Ñ",cadena,2))aux = (int)'z'+1;
	//Caso "-"
	else if(!strncmp("-",cadena,1))aux = ((int)'z')+2;
	//Caso vocales con tilde
	else if(!strncmp("á",cadena,2))aux = (int)'A';
	else if(!strncmp("é",cadena,2))aux = (int)'E';
	else if(!strncmp("í",cadena,2))aux = (int)'I';
	else if(!strncmp("ó",cadena,2))aux = (int)'O';
	else if(!strncmp("ú",cadena,2))aux = (int)'U';
	else aux = (int)cadena[0];
	return aux % tamAlfabeto;
	}




int main(){
	char cadenax[] = "-pepe";
	Tabla t = crearTabla(hash,hash2);
	FILE* archivo;
	char cadena[TAM],*cadena2;
	archivo = fopen("diccionario.txt","r");
	while(fgets(cadena,TAM,archivo)!= NULL){
			cadena2 = malloc(sizeof(char)*strlen(cadena)-1);
			strncpy(cadena2,cadena,strlen(cadena)-1);
			agregarPalabra(cadena2,t);
			}
	fclose(archivo);
	AVL arbol = t->tabla[6][34];
	//arbolImprimir(t->tabla[8][34]);
	printf("%d, %d",t->hash(cadenax), t->hash2(cadenax));
	}
	
	
	
/*int main(){
	//Agregar palabras al universo
	AVL arbol;
	Tabla t = crearTabla(hash,hash2);
	FILE* archivo;
	char cadenas[TAM],*cadena2;
	archivo = fopen("diccionario.txt","r");
	if(!archivo){
		printf("Error\n");
		return 1;
		}
	while(fgets(cadenas,TAM,archivo)!= NULL){
			cadena2 = malloc(sizeof(char)*strlen(cadenas)-1);
			strncpy(cadena2,cadenas,strlen(cadenas)-1);
			agregarPalabra(cadena2,t);
			}
	fclose(archivo);
	
	
	
	
	
	//Buscar errores
 	char* palabra, *bufer = NULL, *bufer2 = NULL, *linea;
 	SList l = crearLista();
 	int i = 0, longitud;
 	archivo = fopen("texto.txt","r");
 	if(!archivo){ 
		printf("Error\n");
		return 1;
		}
 	//Leer archivo
 	int cantidad = 0;
 	while(fgets(cadenas,TAM,archivo) != NULL){
 		palabra = strtok(cadenas," ");
 		if(analizarPalabra(palabra,t)){
			l = agregarLista(palabra,l);
			}
 		longitud = (int)strlen(linea);
 		//Completar y vaciar bufer
 		if(bufer2 != NULL){
			bufer2 = llenarBufer(bufer2,linea,longitud);
			free(bufer2);
			bufer2 = NULL;
			}
 		//Caso en que haya un salto de linea y la palabra esta separada por '-'
 		if(linea[longitud-1] == '\n' && linea[longitud-2] == '-'){
			bufer2 = llenarBufer(bufer2,linea,strlen(linea));
			}
		if(bufer != NULL){
			bufer = llenarBufer(bufer,linea,strlen(linea));
			free(bufer);
			bufer = NULL;
			}
 		
		//Obtener cadenas separadas por espacio
 		while((palabra = strtok(NULL," ")) != NULL){
			longitud = (int)strlen(linea);
			if(linea[longitud-1] == '\n' && linea[longitud-2] == '-'){
				bufer = llenarBufer(bufer,linea,longitud);
				}
			if(analizarPalabra(palabra,t)){
				l = agregarLista(palabra,l);
				}
			}
	}
	fclose(archivo);
	}*/
	

