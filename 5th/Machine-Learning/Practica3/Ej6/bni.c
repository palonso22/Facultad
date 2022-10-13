/*
nb_n.c : Clasificador Naive Bayes usando la aproximacion de funciones normales para features continuos
Formato de datos: c4.5
La clase a predecir tiene que ser un numero comenzando de 0: por ejemplo, para 3 clases, las clases deben ser 0,1,2

PMG - Ultima revision: 20/05/2019
*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <assert.h>

bool mayor(float x, float y){
  return x > y;
}

bool menor(float x, float y){
  return x <= y;
}


#define LOW 1.e-14                 /*Minimo valor posible para una probabilidad*/
#define PI  3.141592653
#define M 1 /*Número de ejemplos virtuales*/


float limite = 0; /*Se setea en train*/


typedef struct Arbol{
  unsigned cantNodos;
  struct Arbol* left;
  struct Arbol* right;
  float corte;
} Arbol;


typedef struct Vector{
  float* datos;
  unsigned n;
} Vector;



typedef struct DRecursivo{
  unsigned n;
  float** datos;
  unsigned clase1;
  float entropy;
  unsigned representedLabel;
}DRecursivo;



/*defino una estructura para el clasificador naive bayes*/
struct NB {
    int N_IN;           /*Total numbre of inputs*/
    int N_Class;        /*Total number of classes (outputs)*/

    int SEED;           /* semilla para la funcion rand(). Los posibles valores son:*/
                    /* SEED: -1: No mezclar los patrones: usar los primeros PR para entrenar
                                 y el resto para validar.Toma la semilla del rand con el reloj.
                              0: Seleccionar semilla con el reloj, y mezclar los patrones.
                             >0: Usa el numero leido como semilla, y mezcla los patrones. */

     /* MATRICES DEL CLASIFICADOR*/
    float*** probAPosteriori; //Hay que guardar las probabilidades a posteriori
    float* probAPriori; // Probabilidad asignada a la clase por la evidencia inicial

    /*estructura para discretizar las variables*/
    Vector** vectoresDiscretos;

};

struct DATOS {
    char *filename;      /* nombre del archivo para leer los datos */
    int N_IN;             /* N1: dimensiones de entrada */
    int PTOT;           /* cantidad TOTAL de patrones en el archivo .data */
    int PR;             /* cantidad de patrones de ENTRENAMIENTO */
                        /* cantidad de patrones de VALIDACION: PTOT - PR*/
    int PTEST;          /* cantidad de patrones de TEST (archivo .test) */

    /*matrices de datos*/
    float **data;                     /* train data */
    float **test;                     /* test  data */
    int *pred;                        /* salidas predichas ES UNA CLASE*/
    int *seq;      	       	      /* indice de acceso con la sequencia de presentacion de los patrones*/
    float lim;                /*Distancia al 0 que puede tomar una variable*/
};



//Pasar de árbol a vector recorriendo el árbol en inorden (si el árbol está ordenado, el vector queda ordenado)
void fromTreeToVector(Arbol* a, Vector* v){
  assert(a != NULL);
  if (a->left != NULL) fromTreeToVector(a->left,v);
  v->datos[v->n] = a->corte;
  v->n += 1;
  if (a->right != NULL) fromTreeToVector(a->right,v);
}


Vector* define_vector(unsigned size){
  Vector* v = calloc(1,sizeof(Vector));
  v->datos = calloc(size,sizeof(float));
  return v;
}


float** define_matrix2(unsigned n){
  float** arreglo = (float**) calloc(n,sizeof(float*));
  for(int i = 0;i<n;i++) arreglo[i] = (float*) calloc(2,sizeof(float));
  return arreglo;
}

float calcularEntropy(float clase1, float n){
  if (n == 0) return 0;
  float clase0 = n - clase1;
  float p0 = clase0/n;
  float p1 = clase1/n;
  return -(p0*log2(p0)+p1*log2(p1));
}


void printTree (Arbol* a){
  if (a == NULL) return;
  printTree(a->left);
  printf("%f,",a->corte);
  printTree(a->right);
}

void printVector (Vector* v){
  for(int i = 0;i < v->n;i++)printf("%f,\n",v->datos[i]);
}


Arbol* insertar(Arbol* a,float x){
    int prueba = 0;
    if (a == NULL){
      Arbol* a = (Arbol*) malloc(sizeof(Arbol));
      assert(a);
      a->corte = x;
      a->left = NULL;
      a->right = NULL;
      a->cantNodos = 1;
      prueba = 1;
      return a;
    }
    else if (a->corte < x){
      a->right = insertar(a->right,x);
      a->cantNodos += 1;
    }
    else {
      a->right=insertar(a->right,x);
      a->cantNodos += 1;
    }
    return a;
}


unsigned howManyClass1(unsigned ctosClass1,unsigned n){
  return (ctosClass1>0) + (n-ctosClass1>0);//Cuántas clases hay en la partición?
}



DRecursivo* particionar(DRecursivo* d, float corte  ,bool (*comparador) (float,float)){
  // Crear partición de todos los elementos para los que comparador devuelve true
  DRecursivo* nuevaParticion = (DRecursivo*)calloc(1,sizeof(DRecursivo));
  nuevaParticion->n = 0;
  nuevaParticion->clase1 = 0;
  nuevaParticion->representedLabel = 0;
  nuevaParticion->datos = define_matrix2(d->n); //Más de esto no vamos a almacenar
  for(int i = 0;i<d->n;i++)
     if(comparador(d->datos[i][0],corte)){
       unsigned index = nuevaParticion->n;
       nuevaParticion->datos[index][0] = d->datos[i][0];
       nuevaParticion->datos[index][1] = d->datos[i][1];
       nuevaParticion->n +=1;
       if(nuevaParticion->datos[index][1]) nuevaParticion->clase1 +=1;

     }
  nuevaParticion->representedLabel = howManyClass1(nuevaParticion->clase1,nuevaParticion->n);
  nuevaParticion->entropy = calcularEntropy(nuevaParticion->clase1,nuevaParticion->n);
  return nuevaParticion;
}


 Arbol* discretizar(DRecursivo* d){
   assert(d != NULL && d->n > 0);
   float corte, minEntropy=1.0,classInformationEntropy;
   DRecursivo *mayores,*menores,*tempMayores,*tempMenores;
   for(int i = 0;i<d->n;i++){
     tempMayores = particionar(d,d->datos[i][0],mayor);
     tempMenores = particionar(d,d->datos[i][0],menor);
     assert(tempMayores != NULL);
     assert(tempMenores != NULL);
     classInformationEntropy = ((float)tempMenores->n/(float)d->n)*tempMenores->entropy + ((float)tempMayores->n/(float)d->n)*tempMayores->entropy;
     if(classInformationEntropy<=minEntropy){
       minEntropy=classInformationEntropy;
       corte = d->datos[i][0];
       mayores = tempMayores;
       menores = tempMenores;
     }
   }
  assert(mayores != NULL && menores != NULL);
  Arbol* a = (Arbol*)malloc(sizeof(Arbol));
  a->corte = corte;
  a->cantNodos = 1;
  a->right = NULL;
  a->left = NULL;
  float Gain = d->entropy-minEntropy;//Ganancia de información
  float delta = log2(pow(3,d->representedLabel)-2)-(d->representedLabel*d->entropy-menores->representedLabel*menores->entropy-mayores->representedLabel*mayores->entropy);
  float noSeQue = (log2(d->n-1)+ delta)/(float)d->n;


  //Chequear condición de parada
  if(Gain<noSeQue)return a;

  if(mayores->n > 0){
    a->right = discretizar(mayores);
    assert(a->right != NULL);
    a-> cantNodos += a->right->cantNodos;

  }

  if(menores->n > 0){
    a->left = discretizar(menores);
    assert(a->left != NULL);
    a-> cantNodos += a->left->cantNodos;
  }

  return a;
 }



unsigned calcularValorDiscreto(Vector* v,float x){
  unsigned i = 0;
  for(;v->datos[i] < x;i++);
  return i;
}



//Consideramos que valores es un número en una base bin y le asignamos un número en base decimal
unsigned baseBinABaseDecimal(unsigned* valor,unsigned bin,unsigned d){
  unsigned res = 0;
  for(int i=0;i<d;i++){
    res += ((unsigned)pow(bin,i)*valor[i]);
  }
  return res;
}


unsigned calcularCondicionante(Vector* vectorDiscreto,float* vector,unsigned cantCondicionantes,unsigned bins,unsigned class){
  unsigned condicionantes[cantCondicionantes];
  for(int j = 0;j<cantCondicionantes-1;j++)condicionantes[j] = calcularValorDiscreto(vectorDiscreto,vector[j]); // Guarda el resto de los features de input ya que condicionan al feature i
  condicionantes[cantCondicionantes-1] = class; // La clase siempre condiciona al feature i
  return baseBinABaseDecimal(condicionantes,bins,cantCondicionantes); //Pasar de base bin a base decimal para calcular el índice en la tabla de frecuencias de condicionantes
}





int CONTROL;        /* nivel de verbosity */







/* -------------------------------------------------------------------------- */
/*define_matrix: reserva espacio en memoria para todas las matrices declaradas.
  Todas las dimensiones son leidas del archivo .nb en la funcion arquitec()  */
/* -------------------------------------------------------------------------- */
int define_matrix_nb(struct NB *nb){
  /*ALLOCAR ESPACIO PARA LAS MATRICES DEL CLASIFICADOR
   medias, varianzas, prop a priori*/
   int i=0, j=0;
  nb->probAPosteriori = (float***) calloc(nb->N_IN,sizeof(float**));



  nb->probAPriori = (float*) calloc(nb->N_Class,sizeof(float));

  nb->vectoresDiscretos = (Vector**) calloc(nb->N_IN,sizeof(Arbol*));
  return 0;
}

/* -------------------------------------------------------------------------- */
/*define_matrix_datos: reserva espacio en memoria para todas las matrices de datos declaradas.
  Todas las dimensiones son leidas del archivo .net en la funcion arquitec()  */
/* -------------------------------------------------------------------------- */
int define_matrix_datos(struct DATOS *datos){
  int i,max;

  datos->seq=(int *)calloc(datos->PTOT,sizeof(int));
  for(i=0;i<datos->PTOT;i++) datos->seq[i]=i;  /* inicializacion del indice de acceso a los datos */

  datos->data=(float **)calloc(datos->PTOT,sizeof(float *));
  if(datos->PTEST) datos->test=(float **)calloc(datos->PTEST,sizeof(float *));

  if(datos->PTOT>datos->PTEST) max=datos->PTOT;
  else max=datos->PTEST;
  datos->pred=(int *)calloc(max,sizeof(int));

  if(datos->seq==NULL||datos->data==NULL||(datos->PTEST&&datos->test==NULL)||datos->pred==NULL) return 1;

  for(i=0;i<datos->PTOT;i++){
    datos->data[i]=(float *)calloc(datos->N_IN+1,sizeof(float));
	if(datos->data[i]==NULL) return 1;
  }
  for(i=0;i<datos->PTEST;i++){
    datos->test[i]=(float *)calloc(datos->N_IN+1,sizeof(float));
	if(datos->test[i]==NULL) return 1;
  }

  return 0;
}

/* ---------------------------------------------------------------------------------- */
/*arquitec: Lee el archivo .nb e inicializa el algoritmo en funcion de los valores leidos
  filename es el nombre del archivo .nb (sin la extension) */
/* ---------------------------------------------------------------------------------- */
int arquitec(char *filename,struct NB *nb,struct DATOS *datos){
  FILE *b;
  char filepat[100];
  int i,j;
  /*bandera de error*/
  int error;

  time_t t;

  /*Paso 1:leer el archivo con la configuracion*/
  sprintf(filepat,"%s.nb",filename);
  b=fopen(filepat,"r");
  error=(b==NULL);
  if(error){
    printf("Error al abrir el archivo de parametros\n");
    return 1;
  }

  /* Dimensiones */
  fscanf(b,"%d",&nb->N_IN);
  fscanf(b,"%d",&nb->N_Class);
  datos->N_IN=nb->N_IN;

  /* Archivo de patrones: datos para train y para validacion */
  fscanf(b,"%d",&datos->PTOT);
  fscanf(b,"%d",&datos->PR);
  fscanf(b,"%d",&datos->PTEST);
  fscanf(b,"%f",&datos->lim);

  /* Semilla para la funcion rand()*/
  fscanf(b,"%d",&nb->SEED);

  /* Nivel de verbosity*/
  fscanf(b,"%d",&CONTROL);

  fclose(b);


  /*Paso 2: Definir matrices para datos y parametros (e inicializarlos*/
  error=define_matrix_nb(nb);
  if(error){
    printf("Error en la definicion de matrices del clasificador\n");
    return 1;
  }
  error=define_matrix_datos(datos);
  if(error){
    printf("Error en la definicion de matrices de datos\n");
    return 1;
  }


  /* Chequear semilla para la funcion rand() */
  if(nb->SEED==0) nb->SEED=time(&t);

  /*Imprimir control por pantalla*/
  printf("\nNaive Bayes con distribuciones normales:\nCantidad de entradas:%d",nb->N_IN);
  printf("\nCantidad de clases:%d",nb->N_Class);
  printf("\nArchivo de patrones: %s",filename);
  printf("\nCantidad total de patrones: %d",datos->PTOT);
  printf("\nCantidad de patrones de entrenamiento: %d",datos->PR);
  printf("\nCantidad de patrones de validacion: %d",datos->PTOT-datos->PR);
  printf("\nCantidad de patrones de test: %d",datos->PTEST);
  printf("\nSemilla para la funcion rand(): %d",nb->SEED);
  return 0;
}
/* -------------------------------------------------------------------------------------- */
/*read_data: lee los datos de los archivos de entrenamiento(.data) y test(.test)
  filenamepasado es el nombre de los archivos (sin extension)
  La cantidad de datos y la estructura de los archivos fue leida en la funcion arquitec()
  Los registros en el archivo pueden estar separados por blancos ( o tab ) o por comas    */
/* -------------------------------------------------------------------------------------- */
int read_data(char *filenamepasado,struct DATOS *datos){

  FILE *fpat;
  char filepat[100];
  float valor;
  int i,k,separador;
  /*bandera de error*/
  int error;

  sprintf(filepat,"%s.data",filenamepasado);
  fpat=fopen(filepat,"r");
  error=(fpat==NULL);
  if(error){
    printf("Error al abrir el archivo de datos\n");
    return 1;
  }

  datos->filename=filenamepasado;

  if(CONTROL>1) printf("\n\nDatos de entrenamiento:");

  for(k=0;k<datos->PTOT;k++){
	 if(CONTROL>1) printf("\nP%d:\t",k);
 	 for(i=0;i<datos->N_IN+1;i++){
	   fscanf(fpat,"%f",&valor);
	   datos->data[k][i]=valor;
	   if(CONTROL>1) printf("%f\t",datos->data[k][i]);
	   separador=getc(fpat);
	   if(separador!=',') ungetc(separador,fpat);
  	 }
  }
  fclose(fpat);

  if(!datos->PTEST) return 0;

  sprintf(filepat,"%s.test",filenamepasado);
  fpat=fopen(filepat,"r");
  error=(fpat==NULL);
  if(error){
    printf("Error al abrir el archivo de test\n");
    return 1;
  }

  if(CONTROL>1) printf("\n\nDatos de test:");

  for(k=0;k<datos->PTEST;k++){
	 if(CONTROL>1) printf("\nP%d:\t",k);
         for(i=0;i<datos->N_IN+1;i++){
	   fscanf(fpat,"%f",&valor);
	   datos->test[k][i]=valor;
	   if(CONTROL>1) printf("%f\t",datos->test[k][i]);
	   separador=getc(fpat);
	   if(separador!=',') ungetc(separador,fpat);
         }
  }
  fclose(fpat);

  return 0;

}

/* ------------------------------------------------------------ */
/* shuffle: mezcla el vector seq al azar.
   El vector seq es un indice para acceder a los patrones.
   Los patrones mezclados van desde seq[0] hasta seq[hasta-1]
   Esto permite separar la parte de validacion de la de train   */
/* ------------------------------------------------------------ */
void shuffle(int hasta,struct DATOS *datos){
   float x;
   int tmp;
   int top,select;

   top=hasta-1;
   while (top > 0) {
	x = (float)rand();
	x /= (RAND_MAX+1.0);
	x *= (top+1);
	select = (int)x;
	tmp = datos->seq[top];
	datos->seq[top] = datos->seq[select];
	datos->seq[select] = tmp;
	top --;
   }
  if(CONTROL>3) {printf("End shuffle\n");fflush(NULL);}
}

/* ------------------------------------------------------------------- */
/*Prob:Calcula la probabilidad de obtener el valor x para el input feature y la clase clase
  Aproxima las probabilidades por distribuciones normales */
/* ------------------------------------------------------------------- */
float prob(struct NB *nb,float x,int feature,int clase)  {
  unsigned valDiscreto = calcularValorDiscreto(nb->vectoresDiscretos[feature],x);
  return nb->probAPosteriori[feature][valDiscreto][clase];
}
/* ------------------------------------------------------------------------------ */
/*output: calcula la probabilidad de cada clase dado un vector de entrada *input
  usa el log(p(x)) (sumado)
  devuelve la de mayor probabilidad                                               */
/* ------------------------------------------------------------------------------ */
int output(struct NB *nb,float *input){
  int i,k;
  float prob_de_clase;
  float max_prob=-1e40;
  int clase_MAP;

  for(k=0;k<nb->N_Class;k++) {
    prob_de_clase=0.;

    /*calcula la probabilidad de cada feature individual dada la clase y la acumula*/
    for(i=0;i<nb->N_IN;i++) prob_de_clase += log( prob(nb, input[i] ,i ,k ) );

    /*agrega la probabilidad a priori de la clase*/
    prob_de_clase += log(nb->probAPriori[k]);

    /*guarda la clase con prob maxima*/
    if (prob_de_clase>=max_prob){
      max_prob=prob_de_clase;
      clase_MAP=k;
    }
  }

  return clase_MAP;
}
/* ------------------------------------------------------------------------------ */
/*evaluar: calcula las clases predichas para un conjunto de datos
  la matriz S tiene que tener el formato adecuado ( definido en arquitec() )
  pat_ini y pat_fin son los extremos a tomar en la matriz
  usar_seq define si se accede a los datos directamente o a travez del indice seq
  los resultados (las propagaciones) se guardan en la matriz seq                  */
/* ------------------------------------------------------------------------------ */
float evaluar(struct NB *nb,struct DATOS *datos,float **S,int pat_ini,int pat_fin,int usar_seq){

  float mse=0.0;
  int nu;
  int patron;

  for (patron=pat_ini; patron < pat_fin; patron ++) {

   /*nu tiene el numero del patron que se va a presentar*/
    if(usar_seq) nu = datos->seq[patron];
    else         nu = patron;

    /*clase MAP para el patron nu*/
    datos->pred[nu]=output(nb,S[nu]);

    /*actualizar error*/
    if(S[nu][nb->N_IN]!=(float)datos->pred[nu]) mse+=1.;
  }


  mse /= ( (float)(pat_fin-pat_ini));

  if(CONTROL>3) {printf("End prop\n");fflush(NULL);}

  return mse;
}


//Reiniciar matriz de probs a posteriori
void cerear(struct NB* nb){
  unsigned nroBins;
  for(int i=0;i<nb->N_IN;i++){
      nroBins = nb->vectoresDiscretos[i]->n;
      for(int j=0;j<nroBins;j++)
        for(int k=0;k<nb->N_Class;k++) nb->probAPosteriori[i][j][k] = 0;
  }

}




/* --------------------------------------------------------------------------------------- */
/*train: ajusta los parametros del algoritmo a los datos de entrenamiento
         guarda los parametros en un archivo de control
         calcula porcentaje de error en ajuste y test                                      */
/* --------------------------------------------------------------------------------------- */
int train(struct NB *nb,struct DATOS *datos){

  int i,j,k;
  int error;
  int N_TOTAL;
  float train_error,valid_error,test_error,minimo_valid=1.0E20;;
  FILE *fpredic, *ferror;
  char filepat[100];
  unsigned class, index,valDiscreto,nroBins,cantCondicionantes,c,n;
  float media,val,frecClass;
  /*Solo usamos PR datos para entrenamiento*/
  N_TOTAL = datos->PR;
  /*Distancia al origen que pueden tomar las variables*/
  limite = datos->lim;


  /*efectuar shuffle inicial de los datos de entrenamiento si SEED != -1 (y hay validacion)*/
  if(nb->SEED>-1 && N_TOTAL<datos->PTOT){
    srand((unsigned)nb->SEED);
    shuffle(datos->PTOT,datos);
  }



  //Primera parte: crear vectores para discretización
  DRecursivo d;
  Arbol* a;
  Vector* v;
  d.datos = define_matrix2(N_TOTAL);
  d.n = N_TOTAL;
  for(i = 0;i<nb->N_IN;i++){
    d.clase1 = 0;
    for(k = 0;k<N_TOTAL;k++){
      d.datos[k][0] = datos->data[k][i];
      d.datos[k][1] = datos->data[k][datos->N_IN];
      if (d.datos[k][1]) d.clase1 +=1;
    }
    d.entropy = calcularEntropy(d.clase1,N_TOTAL);
    d.representedLabel = howManyClass1(d.clase1,N_TOTAL);
    a = discretizar(&d);// Crear un árbol con todos los cortes posibles
    a=insertar(a,limite); //Agregar limite mayor para agregar un bin más
    v = define_vector(a->cantNodos); // Crear vector para almacenar todos los cortes
    fromTreeToVector(a,v);//Pasar de un árbol a un vector para poder calcular más fácilmente el valor discreto
    assert(a->cantNodos == v->n);
    nroBins = v->n;
    printf("\n%d\n",nroBins);
    nb->probAPosteriori[i] = (float**) calloc(nroBins,sizeof(float*));
    for(j=0; j <nroBins;j++) nb->probAPosteriori[i][j] = (float*) calloc(pow(nroBins,nb->N_IN-i),sizeof(float));
    nb->vectoresDiscretos[i] = v;
  }





    /*Primera parte: Computar prob a priori*/
  for(i = 0;i<N_TOTAL;i++){
    index = datos->seq[i]; //Guardar índice
    class = datos->data[index][nb->N_IN];// Guardar clase
    nb->probAPriori[class]+= (1.0/(float)N_TOTAL);//Computar la probabilidad a priori
  }



  //Tomar máxima cantidad de bins para crear tabla de frecs condicionales
  unsigned maxNroBins = 0;
  for(i = 0;i<nb->N_IN;i++){
     nroBins = nb->vectoresDiscretos[i]->n;
     if(nroBins > maxNroBins) maxNroBins = nroBins;
   }


  unsigned s = pow(maxNroBins,nb->N_IN);
  unsigned frecCondicionantes[nb->N_IN][s]; // cada atributo tiene a lo sumo nb->BINS^nb->N_IN valores distintos que pueden condicionarlo

  //Segunda parte: calcular frecs de los condicionantes
  for(i=0; i<nb->N_IN;i++){
    cantCondicionantes = nb->N_IN-i; //Cantidad de variables condicionantes
    nroBins = nb->vectoresDiscretos[i]->n;
    for(k=0; k<N_TOTAL;k++){
      c = calcularCondicionante(nb->vectoresDiscretos[i],datos->data[k]+i+1,cantCondicionantes,nroBins,datos->data[k][nb->N_IN]);
      frecCondicionantes[i][c] +=1;
    }
  }

  //Cuarta parte: Calcular probabilidad a posteriori
  float P = pow(5,-1); // Probabilidad de los ejemplos virtuales

  for(i = 0; i<nb->N_IN;i++){
    cantCondicionantes = nb->N_IN-i;
    nroBins = nb->vectoresDiscretos[i]->n;
    for(k = 0; k < N_TOTAL;k++){
        index = datos->seq[k];
        valDiscreto = calcularValorDiscreto(nb->vectoresDiscretos[i],datos->data[index][i]); // Valor discreto que toma el feature i
        c = calcularCondicionante(nb->vectoresDiscretos[i],datos->data[index]+i+1,cantCondicionantes,nroBins,datos->data[index][nb->N_IN]);
        /* 1er parte: asignar  1/(frecuencia del condicionante + M)*/
        nb->probAPosteriori[i][valDiscreto][c] += pow(frecCondicionantes[i][c]+M,-1);
      }
  }

  //Agregar corrección
  for(i=0;i<nb->N_IN;i++){
    nroBins = nb->vectoresDiscretos[i]->n;
    n = (unsigned) pow(maxNroBins,nb->N_IN-i); // Valores posibles del condicionante
    for(j=0;j<nroBins;j++)
        for(k=0;k<n;k++)
                /*2da parte : sumar MP/(frecuencia del condicionante + M), luego p(ajk/ci)= (nc+PM)/(n+M)*/
                nb->probAPosteriori[i][j][k] += ( M*P/(frecCondicionantes[i][k]+M) );
      }



/*Calcular error de entrenenamiento*/
train_error=evaluar(nb,datos,datos->data,0,datos->PR,0);
/*calcular error de test (si hay)*/
if (datos->PTEST>0) test_error =evaluar(nb,datos,datos->test,0,datos->PTEST,0);
else         test_error =0.;
/*Escribir predicciones de test*/
sprintf(filepat,"%s.predic",datos->filename);
fpredic=fopen(filepat,"w");
error=(fpredic==NULL);
if(error){
  printf("Error al abrir archivo para guardar predicciones\n");
  return 1;
}
for(k=0; k < datos->PTEST ; k++){
  for( i = 0 ;i< datos->N_IN;i++) fprintf(fpredic,"%f\t",datos->test[k][i]);
  fprintf(fpredic,"%d\n",datos->pred[k]);
}
//fclose(fpredic);
/*mostrar errores*/
printf("\nFin del entrenamiento.\n\n");
printf("Errores:\nEntrenamiento:%f%%\n",train_error*100.);
printf("\nTest:%f%%\n",test_error*100.);
if(CONTROL) fflush(NULL);
return 0;
}

/* ----------------------------------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------------------------------- */
int main(int argc, char **argv){

  /*bandera de error*/
  int error;
  if(argc!=2){
    printf("Modo de uso: nb <filename>\ndonde filename es el nombre del archivo (sin extension)\n");
    return 0;
  }

  struct NB nb;
  struct DATOS datos;

  /* defino la estructura*/
  error=arquitec(argv[1],&nb,&datos);
  if(error){
    printf("Error en la definicion del clasificador\n");
    return 1;
  }

  /* leo los datos */
  error=read_data(argv[1],&datos);
  if(error){
    printf("Error en la lectura de datos\n");
    return 1;
  }
  /* entreno la red*/
  error=train(&nb,&datos);
  if(error){
    printf("Error en el entrenamiento\n");
    return 1;
  }

  return 0;

}
/* ----------------------------------------------------------------------------------------------------- */
