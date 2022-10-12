#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <assert.h>
#include <time.h>

float* crearArreglo(int tam_Arreglo){
    /*Dado un tamaño crea un arreglo y devuelve un puntero a ese arreglo
     crearArreglo:int->int* */
     float *Arreglo=malloc(sizeof(float)*tam_Arreglo);
     return Arreglo;
}

void inicializarArreglo(float* Arreglo,int tam_Arreglo){
    /*Dado un arreglo y su tamaño permite ingresarle valores
     inicializarArreglo: int*->int->none*/
     int i;
     for(i=0;i<tam_Arreglo;i++){
         printf("Ingrese valor:");
         scanf("%f",(Arreglo+i));
         }
}

void bubble_sort(float arreglo[], int tam_Arreglo){
    int i=0,j=0;
    for(i=0;i<tam_Arreglo;i++){
        for(j=i;j<tam_Arreglo;j++){
            if(arreglo[i]>arreglo[j]){
                float aux=arreglo[i];
                arreglo[i]=arreglo[j];
                arreglo[j]=aux;
            }
        }
    }
}


float mediana(float *Arreglo, size_t longitud){
    /*Dado un arreglo y su longitud en bytes devuelve su mediana
     mediana: *float->size_t->float */
    int tam_Arreglo=(int)longitud/4;
    float m1;
    
    //Si el arreglo tiene una cantidad par de eltos, la mediana es igual al promedio de los 2 eltos que son > y < a la misma cantidad de eltos.
    if(tam_Arreglo%2==0){
        m1=Arreglo[(tam_Arreglo/2)-1];
        float m2=Arreglo[(tam_Arreglo/2)];
        float promedio=(m1+m2)/2;
        return promedio;
    }

    //Si el arreglo tiene una cantidad impar de eltos, la mediana es igual al elto. que es > y < a la misma cantidad de eltos.
    else{
        int posM1=(int)round((tam_Arreglo/2));
        m1=Arreglo[posM1];
        return m1;  
    }
}


void testeo(){
        srand(time(NULL));
        float *ArregloTest;
        int tam_ArregloTest=rand()%101;
        //crearArreglo
        ArregloTest=crearArreglo(tam_ArregloTest);
        assert(ArregloTest!=NULL);
        
        //Llenamos el arreglo con valores aleatorios
        for(int i=0;i<tam_ArregloTest;i++){
            ArregloTest[i]=rand()%101;          
        }
        
        //bubble_sort
        float *ArregloCopyTest=crearArreglo(tam_ArregloTest);
        assert(ArregloCopyTest!=NULL);
        memcpy(ArregloCopyTest,ArregloTest,(sizeof(int)*tam_ArregloTest));
        bubble_sort(ArregloCopyTest,tam_ArregloTest);
        for(int i=1;i<tam_ArregloTest;i++){
            assert(ArregloCopyTest[i]>=ArregloCopyTest[i-1]);

        }

        //Liberamos el espacio ocupado
        free(ArregloTest);
        free(ArregloCopyTest);
}
        
        



        

        

    




    
   

int main(){
    testeo();
    printf("Testeo Completo\n");
    int tam_Arreglo;
    float *Arreglo,*ArregloCopy,Mediana;
    printf("Ingrese un tamaño para el arreglo");
    scanf("%d",&tam_Arreglo);
    
    //Creamos el arreglo
    Arreglo=crearArreglo(tam_Arreglo);
    

    //Inicializamos el arreglo
    inicializarArreglo(Arreglo,tam_Arreglo);
    
    //Creamos una copia del arreglo
    size_t longitud=(sizeof(float)*tam_Arreglo);
    ArregloCopy=malloc(longitud);
    memcpy(ArregloCopy,Arreglo,longitud);

    
    //Ordenamos la copia del arreglo
    bubble_sort(ArregloCopy,tam_Arreglo);
    
    //Calculamos la mediana e imprimimos el resultado
    Mediana=mediana(ArregloCopy,longitud);
    printf("La mediana del arreglo es %.2f",Mediana);

        
}
