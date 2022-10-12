#include <stdio.h>
#include <assert.h>

long buscar_caracter(char*,char,long);

long comparar_cadena(char*,char*,long, long);

long fuerza_bruta(char*,char*,long,long);



int main(){
	/*assert(buscar_caracter("perro",'r',5) == 2);
    assert(buscar_caracter("perro",'s',5) == -1);

	assert(comparar_cadena("Hola","hola",4,5) == 0);
	assert(comparar_cadena("chau","chau",4,4) == 1);
	assert(comparar_cadena("chau","hola",4,4) == 0);
	assert(comparar_cadena("chau","hola",4,5) == 0);
	
	
	assert(fuerza_bruta("sol","x",3,1) == 0);
	assert(fuerza_bruta("hombres","hom",7,4) == 0);
	assert(fuerza_bruta("hombres","pp",7,4) == 0);
	assert(fuerza_bruta("hombres","brea",7,4) == 0);
	assert(fuerza_bruta("pedro","dro",5,3) == 1);*/
	assert(fuerza_bruta("filosofias","ilosa",9,5) == 0);
	assert(fuerza_bruta("filosofias","iloso",9,5) == 1);
	assert(fuerza_bruta("filosofias","fia",9,3) == 1);
	assert(fuerza_bruta("filosofias","fio",9,3) == 1);
	printf("Testeo completo");
	}
