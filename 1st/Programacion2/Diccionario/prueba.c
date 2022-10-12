#include "diccionario.h"
#define tam 30

int hash(char* cadena){
	return strlen(cadena)-1;
	}

int hash2(char* cadena){
	int aux;
	//Caso ñ y Ñ
	if(!strncmp("ñ",cadena,2) || !strncmp("Ñ",cadena,2))aux = (int)'z'+1;
	//Caso "-"
	else if(!strncmp("-",cadena,1))aux = (int)'z'+2;
	//Caso vocales con tilde
	else if(!strncmp("á",cadena,1))aux = (int)'a';
	else if(!strncmp("é",cadena,1))aux = (int)'e';
	else if(!strncmp("í",cadena,1))aux = (int)'i';
	else if(!strncmp("ó",cadena,1))aux = (int)'o';
	else if(!strncmp("ú",cadena,1))aux = (int)'u';
	else aux = (int)cadena[0];
	//Caso caracteres en mayuscula
	if(aux < 97)aux-=32;
	return aux % tamAlfabeto;
	}

int main(){
	char cadenas[][20] = {"beca","coco","baca","cico","caca"};
	Tabla t = crearTabla(hash,hash2);
	/*FILE* archivo;
	archivo = fopen("fragmento.txt","r");
	char cadena[tam], *cadena2;
	while(fgets(cadena,100,archivo)!= NULL){
		cadena2 = malloc(sizeof(char)*strlen(cadena)-1);
		strncpy(cadena2,cadena,strlen(cadena)-1);
		agregarPalabra(cadena2,t);
		printf("%s",cadena);
		}
	
	fclose(archivo);*/
	AVL arbol = NULL;
	for(int i = 0; i < 5;i++){
		arbol = arbolInsertar(arbol,cadenas[i]);
		}
	//arbolImprimir(arbol);
	printf("\n%d",arbol->alt);
	}


