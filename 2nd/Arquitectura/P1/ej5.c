#include <stdio.h>
#include <gmp.h>

typedef struct {
	short n[16];
} nro;

void print(nro n){
	int i;
	char str[1024];
	short sign[16], num[16];
	mpz_t n1, n2;
	for (i=0; i<15; i++) {
		num[i] = n.n[i];
		sign[i] = 0;
	}
	num[15] = n.n[15] & 0x7FFF;
	sign[15] = n.n[15] & 0x8000;
	mpz_init(n1);
	mpz_init(n2);
	mpz_import(n1, 16, -1, 2, 0, 0, num);
	mpz_import(n2, 16, -1, 2, 0, 0, sign);
	mpz_neg(n2, n2);
	mpz_add(n2, n1, n2);
	mpz_get_str(str, 10, n2);
	printf("Número: %s\n", str);
	mpz_clear(n1);
	mpz_clear(n2);
}

/*void corrimientoIzq(nro* number){
	unsigned short j;
	for(int i = 15; i > 0 ; i--){
			//Asignar un short con el BMA encendido
			j = 1 >> 15;
			//Hacer el corrimiento
			number[i] = number[i] << 1;
			//Obtener el ultimo bit del bloque anterior 
			j = j & number[i-1];
			if(j != 0){
				//Llevar el bit hasta el BMB
				j = j >> 15;
				//Asignar  el bit en el BMB del bloque actual
				number[i] = number[i] | j;
				}
			}		
		}
	//Correr el ultimo bloque
	number[0] = number[0] << 1;
	}


void corrimientoDer(short* number){
	unsigned short j;
	for(int i = 0; i < 15; i++){
		//Asignar un short con BMB encendido
		number[i] = number[i] >> 1;
		//Obtener el ultimo bit del bloque anterior
		j = 1 & number[i+1];
		//Asginar el bit en el BMB del bloque actual
		number[i] = number[i] | j;
		}
	//Correr el ultimo bloque
	number[15] = number[15] >> 1;
	}
	
//Determina si un numero representado con un nro es par o no
int paridad(short* number){
	unsigned short j = 1;
	//Mirar si el ultimo bit del ultimo bloque es 0 o 1
	j = j & number[0]
	//si es 0 es par
	if(!j)return 1;
	//Sino es impar
	return 0;
	}

//Hace la suma entre dos numeros representados con estructuras nro
//Sin modificarlos
nro* sumaNro(short* a, short* b){
	//Asignamos un short con el BMA encendido
	short j = 1 >> 15;
	nro* number = malloc(sizeof(nro));
	//Incializar en 0 todos los bloques
	for(int i = 0; i < 16;i++){
		number->n[i] = 0;
		}
	for(int i = 0; i < 15; i++){
		//Hacer la suma bloque por bloque
		number->n[i] = a[i] + b[i] + number->n[i];
		if(!(a[i] ^ j) && !(b[i] ^ j)){
			//Si hay acarreo sumar 1 en el sgte bloque
			number->n[i+1] += 1;
			} 
		}
	//Sumar en el ultimo bloque
	number->n[15] = number[15] + a[15] + b[15];
	return number;
	}*/















void imprimirBin(unsigned short a){
	int contador = 0;
	for(int i = 15; i >= 0; i--){
		contador++;
		printf("%d", (a & (1 << i) ? 1 : 0));
		if(contador % 8 == 0) printf(" ");
		}
	puts("");
		
	}








int main(){
	int i;
	nro n;
	for (i=0; i<16; i++) n.n[i] = 0;
 	n.n[0] = 1;
	print(n);
	return 0;
	}
