#include <stdio.h>
#include <stdlib.h>

typedef struct{
	int* direccion;
	size_t capacidad;
}ArregloEnteros;




ArregloEnteros* arregloEnterosCrear(size_t capacidad){
	/*Dada la capacidad de un arreglo, devuelve un puntero a una estructura ArregloEnteros
	ArregloEnterosCrear:size_t->ArregloEnteros* */
	int c=0;
	ArregloEnteros* Arreglo=malloc(sizeof(int*)+sizeof(size_t));c+=5;
	Arreglo->capacidad=capacidad;c++;
	Arreglo->direccion=malloc(capacidad);c+=2;
	printf("\nSe hicieron %d operaciones\n",c);
	return Arreglo;
}

void arregloEnterosIngresar(ArregloEnteros* EstructArreglo){
	/*Dado un puntero a una estructura ArregloEnteros, nos permite ingresar enteros al arreglo apuntado
	por el campo direccion.
	ingresarArregloEntero: ArregloEnteros*->None*/
	int* Arreglo=EstructArreglo->direccion,CantEnt=(int)(EstructArreglo->capacidad/4),i,c=4;
	
	for(i=0;i<CantEnt;i++){
		printf("Ingrese un entero:");
		scanf("%d",Arreglo+i);c++;
	}

	printf("\nSe hicieron %d operaciones\n",c);

}

void arregloEnterosMostrar(ArregloEnteros* EstructArreglo){
	/*Dado un puntero a una estructura ArregloEnteros muestra todos los enteros guardados en el arreglo apuntado
	por el campo direccion.
	mostrarEnteros:ArregloEnteros*->None*/
	int longArreglo=(int)(EstructArreglo->capacidad/4),*Arreglo=EstructArreglo->direccion,i,c=4;
	for(i=0;i<longArreglo;i++){
		printf("%d\n",Arreglo[i]);
	}
	printf("Se hicieron %d operaciones\n",c);
}


void arregloEnterosDestruir(ArregloEnteros *EstructArreglo){
	/*Dado un puntero a una estructura ArregloEnteros destruimos el arreglo apuntado por el campo direccion.
	arregloEnterosDestruir:*ArregloEnteros->None*/

	//Guardamos el arreglo apuntado por el campo direccion
	int* Arreglo=EstructArreglo->direccion,c=1;

	//Liberamos la memoria reservada para el arreglo
	free(Arreglo);c++;
	printf("Se hicieron %d operaciones\n", c);
}









void arregloEnterosEscribir(ArregloEnteros* EstructArreglo,size_t pos,int dato ){
	/*Dado un puntero a una estructura ArregloEnteros, una pos y un int,escribe el int en el arreglo apuntado 
	por el campo direccion de la estructura.
	arregloEnterosEscribir:ArregloEnteros*->size_t->int->None*/

	//Guardamos la pos,el arreglo,su tamaño
	//Def VI
	int posInt=(int)(pos/4-1),*Arreglo=EstructArreglo->direccion,longArreglo=(int)(EstructArreglo->capacidad/4),i, c=8;

	//Buscamos la pos en el arreglo y reemplazamos su valor por el pedido
	for(i=0;i<longArreglo;i++){
		if(i=posInt){
			Arreglo[i]=dato;c++;
		}

	}
	printf("Se hicieron %d operaciones\n",c);
}







int main(){
	int CantNum, posEscribir, dato;
	ArregloEnteros* EstructArreglo;
	printf("Ingrese la cantidad de numeros que tendrá el arreglo:\n");
	scanf("%d",&CantNum);
	size_t tamArreglo=sizeof(int)*CantNum;
	EstructArreglo=arregloEnterosCrear(tamArreglo);
	arregloEnterosIngresar(EstructArreglo);
	arregloEnterosMostrar(EstructArreglo);
	arregloEnterosDestruir(EstructArreglo);
	arregloEnterosMostrar(EstructArreglo);
	arregloEnterosMostrar(EstructArreglo);
	/*printf("\nIngrese la posicion a escribir:");
	scanf("%d",&posEscribir);
	printf("Ingrese el dato:");
	scanf("%d",&dato);
	arregloEnterosEscribir(EstructArreglo,sizeof(int)*posEscribir,dato);
	arregloEnterosMostrar(EstructArreglo);*/
	arregloEnterosIngresar(EstructArreglo);
	arregloEnterosMostrar(EstructArreglo);
	arregloEnterosMostrar(EstructArreglo);


}


















