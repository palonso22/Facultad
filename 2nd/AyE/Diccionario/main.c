#include "diccionario.h"
#define TAM 1000






int main()
{
 	FILE *archivo;
 	char cadenas[TAM], *linea, *bufer = NULL;
 	int i = 0, longitud;
 	archivo = fopen("texto.txt","r");
 	
 	if (archivo == NULL){ 
		printf("Error\n");
		return 1;
	}
 	
 	while(fgets(cadenas,100,archivo) != NULL){
 		linea = strtok(cadenas," ");
 		//printf("%s",linea);
 		if(bufer != NULL){
				//printf("%s buf",bufer);
				bufer = realloc(bufer,strlen(bufer) + strlen(linea));
				bufer = strcat(bufer,linea);
				printf("%s",bufer);
				free(bufer);
				bufer = NULL;
				}
 		while((linea = strtok(NULL," ")) != NULL){
			longitud = (int)strlen(linea);
			//Caso en que haya un salto de linea y la palabra esta separada por '-'
			if(linea[longitud-1] == '\n' && linea[longitud-2] == '-'){
				bufer = malloc(sizeof(char)*longitud);
				bufer = strncpy(bufer,linea,longitud-2);
				}
			//else printf("%s",linea);
 	}
        
 }
fclose(archivo);
}
