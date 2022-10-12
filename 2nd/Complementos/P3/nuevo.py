#! /usr/bin/python
import sys
import random

""""
def leer_grafo_stdin():
	v = []
	a = []
	cant = int(raw_input("Ingrese cant nodos:"))
	
	for i in range(cant):
		v.append(raw_input("Ingrese:"))
	
	cant1 = int(raw_input("Ingrese cant aristas:"))
	
	for x in range(cant1):
		linea = raw_input()
		a.append((linea[0],linea[2]))
		
	return (v, a)



def leer_entrada():
	count = 0
	try:
		while True:
			line = raw_input()
			count = count + 1
			print "Linea: [(0)]".format(line)
	except EOFError:
		pass
"""		



"""def leerArchivo(file_path):
	a = []
	v = []
	with open(file_path, 'r') as f:
		count = int(f.readline())
		print "Primer linea {0}".format(count)
		for line in f:
			 print(line)
			
	f.close()"""

def leer_grafo_archivo(file_path):
    v = []
    a = []
    #Abrir archivo y tratar como el objeto f
    with open(file_path, 'r') as f:
		#Obtener cantidad de vertice
		count = int(f.readline())
		
		for line in f:
			#Agregar vertice
			if (count > 0):
				v.append(line[:-1])
				count-=1
				
			#Agregar arista
			else:
				arista = (line[0],line[2])
				a.append(arista)

    return [v,a]
    

  
def imprimir_grafo_lista(grafo):
	print "{}".format(grafo)


def lee_entrada_2():
    count = 0
    try:
        while True:
            line = raw_input()
            count = count + 1
            print 'Linea: {0}'.format(line)
    except EOFError:
        pass
    
    print 'leidas {0} lineas'.format(count)


def lee_entrada_1():
    count = 0
    for line in sys.stdin:
        count = count + 1
        print 'Linea: [{0}]'.format(line)
    print 'leidas {0} lineas'.format(count)


def imprimir_matriz(matriz):
	#Iterar por filas
	for x in range(len(matriz)):
		print(matriz[x])



def lista_a_incidencia(grafo_lista):
    '''
    Transforma un grafo representado por listas a su representacion 
    en matriz de incidencia.
    '''
    v = grafo_lista[0]
    a = grafo_lista[1]
    mIncidencia = []
    
    #Por cada vertice agregar una fila a la matriz
    for i in range(len(v)):
		mIncidencia.append([])
		
		#Recorrer todas las aristas y determinar en cuales inside el actual vertice
		for j in range(len(a)):
			if(v[i] in a[j]):
				mIncidencia[i].append(1)
			else:
				mIncidencia[i].append(0)
				 
    return mIncidencia


def incidencia_a_lista(mIncidencia):
	#Caso matriz vacia
	if(len(mIncidencia) == 0):
		print "Matriz vacia"
		return
	#Obtener vertices
	v = map(chr, range(97, 97+len(mIncidencia)))
	
	#Obtener aristas
	a = []	
	cantCol = len(mIncidencia[0])
	cantFil = len(mIncidencia)
	for i in range(cantCol): 
		temp = []
		for j in range(cantFil):
			
			#Tomar los vertices incidentes en la arista
			if(mIncidencia[j][i] == 1):
				temp.append(v[j])
		
		#Caso arista con vertices distintos
		if len(temp) == 2 :
			a.append((temp[0],temp[1]))
		
		#Caso lazo
		if len(temp) == 1:
			a.append((temp[0],temp[0]))

	return [v,a]		 
	



def inicializar_matriz(tam):
	matriz = []
	#Agregar tam columnas
	for i in range(tam):
		matriz.append([])
		#Agregar tam ceros
		for j in range(tam):
			matriz[i].append(0)
	return matriz






		
def lista_a_adyacencia(grafo):
    v = grafo[0]
    a = grafo[1]
    tam = len(v)
    mAdyacencia = inicializar_matriz(tam)
    for i in range(len(v)):
		for j in range(len(v)):
			if (v[i],v[j]) in a:
				mAdyacencia[i][j] += a.count((v[i],v[j]))
			if (v[j],v[i]) in a and v[j] != v[i]:
					mAdyacencia[i][j] += a.count((v[j],v[i])) 
    return mAdyacencia 

	
def adyacencia_a_lista(mAdyacencia):
	tam = len(mAdyacencia)
	#Obtener vertices
	v = map(chr, range(97,97+len(mAdyacencia)))
	#Obtener aristas
	a = []
	for i in range(tam):
		for j in range(i,tam):
			while mAdyacencia[i][j] > 0:
				a.append((v[i],v[j]))
				mAdyacencia[i][j] -= 1
	return [v,a]		
	
	
	
def main():
	if(len(sys.argv) < 2):
		print "Error. argumento (file) faltante"
		return
	grafo = leer_grafo_archivo(sys.argv[1])
	imprimir_grafo_lista(grafo)
	mIncidencia = lista_a_incidencia(grafo)
	print("\n") 
	imprimir_matriz(mIncidencia)
	print("\n")
	grafo = incidencia_a_lista(mIncidencia)
	imprimir_grafo_lista(grafo)
	mAdyacencia = lista_a_adyacencia(grafo)
	print("\n")
	imprimir_matriz(mAdyacencia)
	grafo = adyacencia_a_lista(mAdyacencia)
	print("\n")
	imprimir_grafo_lista(grafo)
	mAdyacencia = lista_a_adyacencia(grafo)
	print("\n")
	imprimir_matriz(mAdyacencia)


if __name__ ==  "__main__" :
	main()
	
