#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#define extraer_man(x) (*(long int*)&x & (long int)(pow(2,18) - 1) << 34 ) >> 34

#define extraer_sg(x) (long int)pow(2,10)-1 << 52 | (long int)x << 34

#define igualar_exp(m,exp_a,exp_b) ((m >> 1) | (int)pow(2,17) ) >> (exp_b - exp_a) - 1

/*//Dejando el primer uno implicito


//Emax = 2^16-1 - 30000 = 35535

//Emin = -30000*/

  typedef struct{
		char s:1;
		short e;
		unsigned int m:18;
	}nro;




void p_m(unsigned int m){
	for(int i = 17 ; i >= 0;i--){
		printf("%d",m & 1 << i ? 1 : 0);
		//if(i %  == 0 ||  i % 52 == 0)printf("\n");
		//if(i % 34 == 0)printf(" ");
		}
	puts("");
	
	}


void imprimir_nro(nro a){
	long int h = (long int)pow(2,10)-1 << 52 | (long int)a.m << 34;
	double sg = *(double*)&h;
	int e = a.e - 30000;
	printf("%.2f\n",pow(2,e)*sg*pow(-1,a.s));
	}


	
nro suma(nro a, nro b){
	nro c;
	
	//Banderas
	int a_flag = 0, b_flag = 0;

	//Igualar exponentes desplazando significantes
	if (a.e < b.e){
		a.m = igualar_exp(a.m,a.e,b.e);
		a_flag = 1;
		c.e = b.e;
		}
	else if (a.e > b.e){
		b.m = igualar_exp(b.m, b.e, a.e);
		b_flag = 1;
		c.e = a.e;
		}
	else c.e = a.e;
	
	
	
	
    //En este parte se suman numeros de igual signo
	/*Sumar significantes:
		-Extraer las mantisas de ambos numeros.
		-Interpretar los significantes como double.
		-Restar uno si hubo corrimiento de significante (bandera encendida).
		-Asignar la mantisa del resultado a nro c.
	*/
	long int h;
	h = extraer_sg(a.m);
	double sg_a = *(double*)&h;
	if(a_flag)sg_a -= 1;
	h = extraer_sg(b.m);
	double sg_b = *(double*)&h;
	if(b_flag)sg_b -= 1;
	double suma = sg_a + sg_b;
	
	//Aumentar exponente si hubo que normalizar
	if(suma >= 2)c.e++;
	c.m = extraer_man(suma);
	
	
	//Si fue una suma de numeros negativos cambiar signo
	if(a.s == 1)c.s = 1;
	else c.s = 0;
	
	return c;
	
	}



void producto();













int main(){
	system("clear");
	printf("\n");
	nro c;
	
	nro a;
	a.s = 0;
	a.e = 30001; 	
	a.m = 5 << 15;
	
	imprimir_nro(a);
	
	nro b;
	b.s = 0;
	b.e = 30000;
	b.m = 8 << 1;
	
	imprimir_nro(b);
	
	c = suma(a,b);
	
	imprimir_nro(c);
	
	
	long int h = (long int)pow(2,10)-1 << 52 | (long int)a.m << 34;
	//p_m(h);
	double t = *(double*)&h;
	//printf("%.2f",t);
	puts("");
}






