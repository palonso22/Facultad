#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define TamPtrChar 8


int string_len(char *cadena){
	/*Dada una cadena devuelve su longitud
	string_len:*char->int*/
	int i;
	for(i=0;cadena[i]!='\0';i++);
	return i;
}







void string_reverse(char* string){
	/*Dado un puntero a una cadena, invierte el orden de sus carácteres
	string_reverse:char*->None*/
	int longString=string_len(string),i;
	char *stringCopy=malloc(sizeof(char)*longString);
	memcpy(stringCopy,string,(sizeof(char)*longString));
	for(i=0;i<longString;i++){
		string[i]=stringCopy[longString-1-i];
	}
}

size_t string_concat(char* str1,char* str2,size_t max){
	/*Copia str2 al final del str1 hasta un máximo de max carácteres
	string_concar: char*->char*->size_t->size_t*/
	int i,CantCaractStr1=string_len(str1);
	for(i=0;i<(int)max;i++){
		str1[CantCaractStr1+i]=str2[i];
	}
	return max;
}

float min(float a,float b){
	/*Dados dos números devuelve el menor de ellos
	min:float->float->float*/
	if(a<b){
		return a;
	}
	return b;
}

 

int string_compare(char* str1,char* str2){
	/*Dadas dos cadenas compara el orden lexicográfico entre ellas y devuelve -1 si str1 es menor que str2, 0 si son iguales y 1 si str1 es mayor a 
	str2.
	string_compare:char*->char*->int*/
	int longStr1=string_len(str1), longStr2=string_len(str2),longitud=min(string_len(str1),string_len(str2));
	for(int i=0;i<longitud;i++){
		//Comparamos el valor de los carácteres
		if(str1[i]<str2[i]){
			return -1;
		}
		else if(str1[i]>str2[i]){
			return 1;
		}

	}
	//Si la cadenas tienen la misma longitud son iguales(str2)
	if(longStr1==longStr2){
		return 0;
		}
	//Sino, str2 es mayor a str1
	return -1;
}

int string_subcadena(char* str1,char* str2){
	/*Dadas dos cadenas devuelve el indice de la primera de ocurrencia de str2 en str1, de no haber ninguna devuelve -1.
	string_subcadena: char*->char*->int*/
	int i=0,j,ocurrencia=-1,longStr2=string_len(str2),longStr1=string_len(str1);;
	
	//Iteramos tomando un caracter de str2 y recorremos str1 hasta que hallamos la primer ocurrencia
	while(ocurrencia==-1 && i<longStr2){
		j=0;
		while(str1[j]!=str2[i] && j<longStr1){
			j++;
		}
		if(j<longStr1){
			ocurrencia=j;
		}
		i++;	
	}
	if(i==longStr2+1){
		return -1;
	}
	return ocurrencia;
}





char* ingresar_Cadena(){
	/*Permite ingresar una cadena
	ingresar_Cadena:None->*char*/
	char cadena[100],*ptrCadena;
	printf("Ingrese una cadena o separador:\n");
	gets(cadena);
	ptrCadena=malloc(sizeof(char)*string_len(cadena)+1);
	strcpy(ptrCadena,cadena);
	return ptrCadena; 

}

int CalcCaractArreglo(char* arregloString[],size_t tamanoArreglo){
	/*Dado un arreglo de strings calcula la suma de la cantidad de caracteres de cada uno.
	CalcCaracArreglo:[char*]->size_t->int */
	int CantCaractArreglo=0,i,longArreglo=(int)(tamanoArreglo/8);
	for(i=0;i<longArreglo;i++){
		CantCaractArreglo+=string_len(arregloString[i]);
	}
	return CantCaractArreglo;

}

void ingresarArregloString(char* arregloString[],size_t tamanoArreglo){
	/*Dado un arreglos de punteros a string permite ingresar cadena.
	ingresarArregloString:[char*]->none*/
	int longArreglo=(int)(tamanoArreglo/TamPtrChar),i,j;
	for(i=0;i<longArreglo;i++){
		arregloString[i]=ingresar_Cadena();
	}
}

void string_unir(char* arregloString[],size_t capacidad,char* sep,char* res){
	/* Dado un arreglo de cadenas las concantena, seperandolas con sep.
	string_unir:char*->size_t->char*->char*->none*/
	//3 VI, long de la cadena resultante, indice
	int i=0,j=0,k=0,longRes=(int)capacidad,index;
	while(i<longRes){
		index=string_len(arregloString[k]);
		for(j=0;j<index;j++){
			res[i+j]=arregloString[k][j];
		}
		i+=index;
		if(i!=longRes){
			index=string_len(sep);
			for(j=0;j<index;j++){
				res[i+j]=sep[j];
			}
			i+=index;
		}
		k++;
	}
}





int main(){
	int CantCaractCopy, CantCaractSep,CantStringArreglo,CantCaractRes;
	size_t tamanoArreglo,tamanoRes;
	char** arregloString,basura,*sep,*res;

	//Permitimos ingresar el tamaño del arreglo de cadenas a ingresar
	printf("Ingrese la cantidad de cadenas:");
	scanf("%d",&CantStringArreglo);
	scanf("%c",&basura);
	tamanoArreglo=(sizeof(char*)*CantStringArreglo);
	arregloString=malloc(tamanoArreglo);

	//Ingresamos una a una todas las cadenas pedidas
	ingresarArregloString(arregloString,tamanoArreglo);

	//Ingresamos un separador
	printf("Ingrese un separador:\n");
	sep=ingresar_Cadena();

	//Hacemos la concatenación
	CantCaractRes=CalcCaractArreglo(arregloString,tamanoArreglo)+(string_len(sep)*(CantStringArreglo-1));
	tamanoRes=sizeof(char)*CantCaractRes;
	res=malloc(tamanoRes);
	string_unir(arregloString,tamanoRes,sep,res);





	


	//Ingresamos e imprimimos la primer cadena
	//cadena=ingresar_Cadena();
	//Ingresamos e imprimimos la segunda cadena
	//cadena2=ingresar_Cadena();

	/*
	//Pedimos ingresar la cant de caract a copiar 
	printf("Ingrese la cantidad de caracteres que van a ser copiados:");
	scanf("%d",&CantCaractCopy);
	cadena3=malloc(sizeof(char)*string_len(cadena)+CantCaractCopy);
	strcpy(cadena3,cadena);

	//Imprimimos el resultado y la cadena copiada
	CantCaract=(int)string_concat(cadena3,cadena2,(sizeof(char)*CantCaractCopy));
	printf("Se copiaron %d caracteres\n",CantCaract);
	printf("%s\n",cadena3);
	*/

	//Comparamos el orden lexicográfico de dos cadenas
	//string_compare(cadena,cadena2);
	printf("%s\n",res);
	printf("La cadena tiene %d caracteres\n",string_len(res));
}