#! /usr/bin/python
# -*- coding: utf-8 -*-

# 3ra Practica Laboratorio 
# Complementos Matematicos I
# Consigna: Implementar los siguientes metodos
 
'''
Recordatorio: 
- Un camino/ciclo es Euleriano si contiene exactamente 1 vez
a cada arista del grafo
- Un camino/ciclo es Hamiltoniano si contiene exactamente 1 vez
a cada vért ice del grafo
'''
import sys
from p2 import componentes_conexas
from nuevo import leer_grafo_archivo


def check_is_hamiltonian_trail(graph, path):
    """
    Comprueba si una lista de aristas constituye un camino hamiltoniano
    en un grafo.

    Args:
        graph (grafo): Grafo en formato de listas. 
                       Ej: (['a', 'b', 'c'], [('a', 'b'), ('b', 'c')])

        path (lista de aristas): posible camino
                                 Ej: [('a', 'b), ('b', 'c')]

    Returns:
        boolean: path es camino hamiltoniano en graph

    Raises:
        TypeError: Cuando el tipo de un argumento es inválido
    """
    vertices, aristas = graph[0], graph[1]
    VR = []
    #import pdb; pdb.set_trace() # n s l c
    if len(path) > 0 and path[0][0] == path[len(path)-1][1]:
		return False
    for i in range(0,len(path)):
		#Chequear que la arista pertenece al grafo, que el camino esta bien definido o que no se repite un vertice
		if not(path[i] in aristas) or (path[i][0] != path[i-1][1] and i > 0) or path[i][0] in VR:
			return False
		VR.append(path[i][0])
    if len(path) > 0:
		VR.append(path[len(path)-1][1])
	#Ordenar conjuntos
    VR.sort()
    vertices.sort()
	#Chequear que son iguales y que los extremos del camino son distintos
    if VR == vertices:
		return True
    return False


def check_is_hamiltonian_circuit(graph, path):
    """Comprueba si una lista de aristas constituye un ciclo hamiltoniano
    en un grafo.

    Args:
        graph (grafo): Grafo en formato de listas. 
                       Ej: (['a', 'b', 'c'], [('a', 'b'), ('b', 'c')])

        path (lista de aristas): posible ciclo
                                 Ej: [('a', 'b), ('b', 'c')]

    Returns:
        boolean: path es ciclo hamiltoniano en graph

    Raises:
        TypeError: Cuando el tipo de un argumento es inválido
    """
    vertices, aristas = graph[0], graph[1]
    VR = []
    for i in range(0,len(path)):
		#Chequear que el camino tiene sentido o  se repite un vertice o la arista no pertenece al grafo
		if path[i][0] != path[i-1][1] or (path[i][0] in VR and path[i][0] != VR[0]) or not(path[i] in aristas):
			return False
		VR.append(path[i][0])
		
    #import pdb; pdb.set_trace() # n s l c
	#Chequear que lovs extremos coinciden
    if len(path) > 0 and path[0][0] != path[len(path)-1][1]:
		return False
	#Ordenar conjuntos 
    VR.sort()
    vertices.sort()
	#Comprobar que son iguales
    if VR == vertices:
		return True
    return False

"""
def check_is_eulerian_trail(graph, path):
    Comprueba si un grafo no dirigido tiene un camino euleriano.
    Args:
        graph (grafo): Grafo en formato de listas. 
                       Ej: (['a', 'b', 'c'], [('a', 'b'), ('b', 'c')])

    Returns:
        boolean: graph tiene un camino euleriano

    Raises:
    
	if len(path) > 0 and path[i][0] != path[i-1][1] and not(path[i] in aristas) and path[i] in AR:
		return False 
		#agregar a aristas recorridas
		AR.append(path[i])
	#Ordenar ambos conjuntos
    AR.sort()
    aristas.sort()
	#Chequear que se recorrieron todas las aristas
    if AR == aristas:
		return True
    return False
"""




def check_is_eulerian_circuit(graph, path):
    """Comprueba si una lista de aristas constituye un ciclo euleriano
    en un grafo.

    Args:
        graph (grafo): Grafo en formato de listas. 
                       Ej: (['a', 'b', 'c'], [('a', 'b'), ('b', 'c')])

        path (lista de aristas): posible ciclo
                                 Ej: [('a', 'b), ('b', 'c')]

    Returns:
        boolean: path es ciclo euleriano en graph

    Raises:
        TypeError: Cuando el tipo de un argumento es inválido
        """
    if len(graph) != 2:
		print("Argumento Invalido")
		return TypeError
    aristas = graph[1]
    AR = []
    try:
		for i in range(0,len(path)):
			if i > 0 and path[i][0] != path[i-1][1] or path[i] in AR or not(path[i] in aristas):
				return False 
			#agregar a aristas recorridas
			AR.append(path[i])
		#Verificar que coinciden los extremos
		if len(path) > 0 and  AR[0][0] != AR[len(AR)-1][1]:
			return False
		AR.sort()
		aristas.sort()
		if AR == aristas:
			return True
		return False
    except (IndexError, AttributeError):
		print("Argumento Invalido")
		return False




def graph_has_eulerian_trail(graph):
	"""Comprueba si un grafo no dirigido tiene un camino euleriano.

    Args:
        graph (grafo): Grafo en formato de listas. 
                       Ej: (['a', 'b', 'c'], [('a', 'b'), ('b', 'c')])

    Returns:
        boolean: graph tiene un camino euleriano

    Raises:
        TypeError: Cuando el tipo del argumento es inválido
    """
	#Determinar si es conexa
	if(len(componentes_conexas(graph)) == 1):
		vertices, aristas = graph[0],graph[1]
		CV = []
		#Determinar cuantos vertices tiene grado impar
		for v in vertices:
			CI = 0
			for e in aristas:
				if v in e:
					CI += 1
			if CI % 2 != 0:
				CV.append(v)
		if len(CV) == 2:
			return True
		return False
	else:
		return False
		

def pair_vertices(graph):
	"""
	Detemina si un grafo tiene grado par en 
	todos sus vertices.
	"""
	vertices,aristas = graph[0], graph[1]
	VR = []
	for v in vertices:
		CI = 0
		for e in aristas:
			if v in e:
				CI += 1
		if CI % 2 == 0:
			VR.append(v)
	VR.sort()
	vertices.sort()
	if VR == vertices:
		return True
	return False


def is_bridge(graph,e):
	"""
	Dado une grafo y una arista determina si la arista es un puente
	en el grafo.
	"""
	aristas = graph[1][:]
	aristas.remove(e)	
	graph2 = (graph[0],aristas)
	if componentes_conexas(graph2) == 2:
		return True
	return False

def choose_vertice(e,v):
	if e[0] != v:
		return e[0]
	return e[1]

def find_eulerian_circuit(graph):
	"""
    Obtiene un ciclo euleriano en un grafo no dirigido, si es posible

    Args:
        graph (grafo): Grafo en formato de listas. 
                       Ej: (['a', 'b', 'c'], [('a', 'b'), ('b', 'c')])

    Returns:
        path (lista de aristas): ciclo euleriano, si existe
        None: si no existe un camino euleriano

    Raises:
        TypeError: Cuando el ttpo del argumento es inválido
    """
    # Sugerencia: Usar el Algoritmo de Fleury
    # Recursos:
    # http://caminoseuler.blogspot.com.ar/p/algoritmo-leury.html
    # http://www.geeksforgeeks.org/fleurys-algorithm-for-printing-eulerian-path/ 
	if len(componentes_conexas(graph)) == 1 and pair_vertices(graph):
		vertices, aristas = graph[0], graph[1]
		AR = []
		V = vertices[0]
		i = 0
		while(len(aristas) > 0):
			#Tomar una arista donde el vertice sea incidente
			# y que no sea un puente
			#Agregar al recorrido
			#Eliminar la arista del grafo
			#Tomar un nuevo vertice que en lo posible sea distinto
			if V in aristas[i] and not(is_bridge(graph,aristas[i])):
				AR.append(aristas[i])
				del aristas[i]
				V = choose_vertice(AR[len(AR)-1],V)
			i += 1
			if i >= len(aristas):
				i = 0
		return AR
			
				


def main():
    #grafo = (['a','b','c','d','e','f','g','h','i'], [('b','a'),('c','a'),('a','d'),('a','e'),('b','f'),('b','d'),('b','c'),('c','e'),('c','f'),('f','d'),('f','e'),('d','e')])
    grafo = leer_grafo_archivo(sys.argv[1])
    valor = find_eulerian_circuit(grafo)
    print(valor)

if __name__ == '__main__':
    main()
