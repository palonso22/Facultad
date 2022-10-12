#! /usr/bin/python

# 4ta Practica Laboratorio 
# Complementos Matematicos I
# Consigna: Implementar los siguientes metodos

import math



def dijkstra(grafo, vertice):
    '''
    Dado un grafo (en formato de listas con pesos), aplica el algoritmo de 
    Dijkstra para hallar el COSTO del camino mas corto desde el vertice de origen
    al resto de los vertices.
    Formato resultado: {'a': 10, 'b': 5, 'c': 0}
    (Nodos que no son claves significa que no hay camino a ellos)
    '''
    vertices, aristas = grafo[0], grafo[1]
    tabla = dict([(x,float('Inf')) for x in vertices])
    tabla[vertice] = 0#El inicio tiene costo cero
    SinMarca = [vertice] #Iniciar cola de prioridad
    marcados = []
    j = 0
    while(len(SinMarca) > 0):
		vertice = SinMarca.pop(0) #Extraer el mas cercano al origen
		marcados.append(vertice) #Marcarlo
		adyacentes = []#Lista de vertices adyacentes
		i = 0
		while( i < len(aristas)):
			if aristas[i][1] not in marcados and aristas[i][0] == vertice: #Para vertices adyacentes no marcados 
				adyacentes.append(aristas[i][1])
				costo = aristas[i][2] + tabla[vertice]#Calcular costo
				if  tabla[aristas[i][1]] > costo :#Actualizar etiqueta
					tabla[aristas[i][1]] = costo
				if len(adyacentes) > 1 and tabla[adyacentes[0]] > tabla[adyacentes[-1]]:
					adyacentes = adyacentes[-1] + adyacentes[:len(adyacentes)-1]
					
			i+=1
		SinMarca = adyacentes + SinMarca #Agregar vertices a la cola de de prioridad
		
    tabla = dict([(x,y) for x,y in tabla.iteritems() if not math.isinf(y)]) #Limpiar tabla
    return tabla
	
def dijkstra_2(grafo, vertice):
    '''
    Dado un grafo (en formato de listas con pesos), aplica el algoritmo de 
    Dijkstra para hallar el CAMINO mas corto desde el vertice de origen
    a cada uno del resto de los vertices.
    Formato resultado: {'a': ['a'], 'b': ['a', 'b'], 'c': ['a', 'c']}
    (Nodos que no son claves significa que no hay camino a ellos)
    '''
    vertices, aristas = grafo[0], grafo[1]
    tabla = dict([(x,(float('Inf'),[])) for x in vertices])
    tabla[vertice] = (0,[vertice]) #El inicio tiene costo cero 
    SinMarca = [vertice] #Iniciar cola de prioridad
    marcados = []
    j = 0
    while(len(SinMarca) > 0): #Mientras haya vetice sin marcar
		vertice = SinMarca.pop(0) #Extraer el mas cercano al origen
		marcados.append(vertice)#Marcarlo
		adyacentes = [] #Lista de vertices adyacentes
		for i in range(len(aristas)):
			if aristas[i][1] not in marcados and aristas[i][0] == vertice: #Para vertices adyacentes no marcados
				adyacentes.append(aristas[i][1]) #Agregar a adyacentes
				costo = aristas[i][2] + tabla[vertice][0] #Calcular costo
				if tabla[aristas[i][1]][0] > costo: #Actualizar etiqueta
					tabla[aristas[i][1]] = (costo, tabla[vertice][1]+[aristas[i][1]])
				if len(adyacentes) > 1 and tabla[adyacentes[0]][0] > tabla[adyacentes[-1]]: #Dejar el que tenga minimo costo en la primer posicion
					adyacentes = adyacentes[-1] + adyacentes[:len(adyacentes)-1]
		SinMarca = adyacentes + SinMarca # Agregar vertices a la cola de prioridad
    tabla = dict([(x,y[1]) for x,y in tabla.iteritems() if not math.isinf(y[0])]) #Limpiar tabla
    return tabla




def main():
	grafo2 = (['a', 'b', 'c', 'd','e','f','g','s','h'], [('a', 'b', 1), ('a', 'a', 0.5), ('b', 'c', 1.5),('c','a',2),('a','d',1),('d','e',1),('a','e',5),('c','f',3),
	('f','g',2),('d','s',2),('s','h',1)])
	tabla = dijkstra_2(grafo2,'a')
	print(tabla)

if __name__ == "__main__":
    main()
