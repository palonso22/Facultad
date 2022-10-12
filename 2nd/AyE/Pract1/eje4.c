#include <stdio.h>
#include <stdlib.h>

typedef struct{
	int* direccion;
	size_t capacidad;
}ArregloEnteros;

ArregloEnteros* arregloEnterosCrear(size_t capacidad){
	/*Dada la capacidad de un arreglo, devuelve un puntero a una estructura ArregloEnteros
	ArregloEnterosCrear:size_t->ArregloEnteros* */
	ArregloEnteros* Arreglo=malloc(sizeof(int*)+sizeof(size_t));
	Arreglo->capacidad=capacidad;
	Arreglo->direccion=malloc(capacidad);
	return Arreglo;
}



void arregloEnterosIngresar(ArregloEnteros* EstructArreglo){
	/*Dado un puntero a una estructura ArregloEnteros, nos permite ingresar enteros al arreglo apuntado
	por el campo direccion.
	ingresarArregloEntero: ArregloEnteros*->None*/
	int* Arreglo=EstructArreglo->direccion,CantEnt=(int)(EstructArreglo->capacidad/4),i;
	
	for(i=0;i<CantEnt;i++){
		printf("Ingrese un entero:");
		scanf("%d",Arreglo+i);
	}
}

void arregloEnterosMostrar(ArregloEnteros* EstructArreglo){
	/*Dado un puntero a una estructura ArregloEnteros muestra todos los enteros guardados en el arreglo apuntado
	por el campo direccion.
	mostrarEnteros:ArregloEnteros*->None*/
	int longArreglo=(int)(EstructArreglo->capacidad/4),*Arreglo=EstructArreglo->direccion,i;
	for(i=0;i<longArreglo;i++){
		printf("%d\n",Arreglo[i]);
	}
}



void arregloEnterosAjustar(ArregloEnteros* EstructArreglo,size_t capacidad){
	/*Dado un puntero a una estructura ArregloEnteros y una capacidad en bytes, ajusta el tamaño del 
	arreglo truncando su contenido si el nuevo tamaño es menor.
	ArregloEnteros:EstructArreglo*->size-t->None*/
	//Guardamos el arreglo actual, creamos un puntero con la nueva capacidad
	//Def longNuevoArreglo,VI
	int* ViejoArreglo=EstructArreglo->direccion, *NuevoArreglo=malloc(capacidad), longNuevoArreglo=(int)(capacidad/4),i, c=6;

	//Si la nueva capacidad es menor, se copiaran solo los eltos que puedan almacenarse en el nuevo arreglo
	for(i=0;i<longNuevoArreglo;i++){
		NuevoArreglo[i]=ViejoArreglo[i];c++;
	}

	//Referenciamos el campo direccion con el nuevo arreglo, modificamos la capacidad 
	EstructArreglo->direccion=NuevoArreglo;c++;
	EstructArreglo->capacidad=capacidad;c++;

	printf("%d\n",longNuevoArreglo);

	//Liberamos la memoria que ya no usaremos
	free(ViejoArreglo);c++;
	printf("Se hicieron %d operaciones\n",c);
}


void arregloEnterosInsertar(ArregloEnteros* EstructArreglo,size_t pos, int dato){
	/*Dado un puntero a una estructura ArregloEnteros, una pos y un int, guarda el int en la pos indicada en el arreglo
	apuntado por el campo direccion, moviendo los eltos desde esa pos a la derecha*/
	//Guardamos la suma de la capacidad anterior del arreglo mas la capacidad para un nuevo elto
	size_t capacidad=EstructArreglo->capacidad+sizeof(int);int c=3;

	//Def un nuevo arreglo,dos VI, long del nuevo arreglo
	//Guardamos la pos del dato a guardar,el viejo arreglo
	int* NuevoArreglo=malloc(capacidad),i, j=0, longViejoArreglo=(int)(EstructArreglo->capacidad/4),posInt=(int)(pos/4-1),*ViejoArreglo=EstructArreglo->direccion;c+=11;

	//Guardamos el dato en la pos dada
	NuevoArreglo[posInt]=dato;c++;

	//Copiamos todos los eltos, moviendo los que esten a partir de la pos dada un lugar a la derecha
	for(i=0;i<longViejoArreglo;i++){
		j=i;c++;
		c++;if(i>=posInt){
			j++;c++;
		}
		NuevoArreglo[j]=ViejoArreglo[i];c++;
	}

	//Referenciamos el campo direccion con el nuevo arreglo y modificamos la capacidad
	EstructArreglo->direccion=NuevoArreglo;c++;
	EstructArreglo->capacidad=capacidad;c++;

	//Liberamos la memoria almacenada por el viejo arreglo
	free(ViejoArreglo);c++;
	printf("Se hicieron %d operaciones\n",c);
}


void arregloEnterosEliminar(ArregloEnteros* EstructArreglo){
	/*Dado un puntero a una estructura ArregloEnteros, permite eliminar un entero del arreglo apuntado en el campo direccion
	ubicado en la posición seleccionada.*/

	//Creamos un nuevo arreglo de tamaño m-4 donde m es la cantidad de eltos. del arreglo apuntado por el campo direccion
	//Guardamos el viejo arreglo
	size_t CapacidadNArreglo=(EstructArreglo->capacidad)-sizeof(int);int c;c+=3;
	int* NuevoArreglo=malloc(CapacidadNArreglo), *ViejoArreglo=EstructArreglo->direccion;c+=3;

	//Def la long del arreglo apuntado, la pos del elto a eliminar y dos VI
	int longVArreglo=(int)(EstructArreglo->capacidad/4),posEliminar,i,j=0;c+=4;

	printf("Ingrese la posición a eliminar:");
	scanf("%d",&posEliminar);c++;

	//Guardamos todos los eltos en el nuevo arreglo salvo el que qrmos eliminar
	for(i=0;i<longVArreglo;i++){
	c++;if(i!=posEliminar){
			NuevoArreglo[j]=ViejoArreglo[i];c++;
			j++;c++;
		}
	}

	//Guardamos la direccion del nuevo arreglo y reducimos la capacidad de la estructura
	EstructArreglo->direccion=NuevoArreglo;c++;
	EstructArreglo->capacidad=CapacidadNArreglo;c++;

	//Liberamos la memoria que ya no usaremos
	free(ViejoArreglo);c++;
	printf("Se hicieron %d operaciones\n",c);
}







int main(){
	int posInt,dato, CantNum;
	ArregloEnteros *EstructArreglo;
	size_t Capacidad;
	printf("Ingrese la cantidad de numeros en el arreglo:");
	scanf("%d",&CantNum);
	Capacidad=sizeof(int)*CantNum;
	EstructArreglo=arregloEnterosCrear(Capacidad);
	arregloEnterosIngresar(EstructArreglo);
	arregloEnterosMostrar(EstructArreglo);
	printf("Ingrese el dato y la posicion\n");
	scanf("%d",&dato);
	scanf("%d",&posInt);
	arregloEnterosInsertar(EstructArreglo,sizeof(int)*posInt,dato);
	arregloEnterosMostrar(EstructArreglo);
}