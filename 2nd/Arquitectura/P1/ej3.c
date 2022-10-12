#include <stdio.h>



void codificar(char* txt, int cod){
	int i = 0 , contador = 0;
	while(txt[i] != '\0'){
		txt[i] = txt[i] ^ cod;
		i++;
		}
	}











int main(){
    char cadena[100];
    char car;
    printf("Escribe un texto: ");
    int a , i = 0;
    while ((a = getchar()) != EOF){
        cadena[i] = a;
        i++;
    }
	printf("%s",cadena);
	puts("");
	codificar(cadena,15);
	printf("%s",cadena);
    return 0;
	}
