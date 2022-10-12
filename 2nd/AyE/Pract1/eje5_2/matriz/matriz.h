#ifndef __MATRIZ_H__
#define __MATRIZ_H__




typedef struct{
	float* direccion;
	size_t cantFilas;
	size_t cantCol;
}Matriz;
/*
** Crea una nueva matriz
*/
Matriz* matriz_crear(size_t numFilas, size_t numColumnas);

/*
** Destruye una matriz
*/
void matriz_destruir(Matriz* matriz);

/*
** Obtiene el dato guardado en la posición dada de la matriz
*/
double matriz_leer(Matriz* matriz, size_t fil, size_t col);

/*
** Modifica el dato guardado en la posición dada de la matriz
*/
void matriz_escribir(Matriz* matriz, size_t fil, size_t col, double val);

/*
** Obtiene número de filas de la matriz
*/
size_t matriz_num_filas(Matriz* matriz);

/*
** Obtiene número de columnas de la matriz
*/
size_t matriz_num_columnas(Matriz* matriz);

void matriz_ingresar(Matriz* estructMatriz);
void matriz_mostrar(Matriz* estructMatriz);
Matriz* matriz_suma(Matriz* estructMatrizA,Matriz* estructMatrizB);
Matriz* matriz_insertar_fila(Matriz* estructMatriz,int filaNum);

#endif /* __MATRIZ_H__ */
