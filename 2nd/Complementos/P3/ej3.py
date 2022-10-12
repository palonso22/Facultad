#! /usr/bin/python
import sys


def check_is_eulerian_trail(graph,path):
	aristas = graph[1]
	AR = []
	AR.append(path[0])
	for i in range(1,len(path)):
		#Chequear que el camino es valido, que no repetimos arista y que la arista pertenece al grafo
		if path[i][0] != path[i-1][2]:
			return False 
		if path[i] in AR:
			return False
		
		if not(path[i] in aristas):
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


def check_is_eulerian_cycle(graph,path):
	if len(graph) < 2 or len(graph[0]) == 0 or len(graph[1]) == 0 or len(path) == 0:
		return False
	aristas = graph[1]
	AR = []
	for i in range(1,len(path)):
		#Chequear que el camino es valido, que no repetimos arista y que la arista pertenece al grafo
		if path[i][0] != path[i-1][2] or path[i] in AR or not(path[i] in aristas):
			return False 
		#agregar a aristas recorridas
		AR.append(path[i])
	#Verificar que coinciden los extremos
	if AR[0][0] != AR[len(AR)-1][1]:
		return False
	AR.sort()
	aristas.sort()
	if AR == aristas:
		return True
	return False


def check_is_hamiltonian_trail(graph,path):
	if len(graph) < 2 or len(graph[0]) == 0 or len(graph[1]) == 0 or len(path) == 0:
		return False
	vertices, aristas = graph[0], graph[1]
	VR = []
	VR.append(path[0][0])
	for i in range(1,len(path)):
		#Chequear que el camino tiene sentido o  se repite un vertice o la arista no pertenece al grafo
		if path[i][0] != path[i-1][1] or path[i][0] in VR or not(path[i] in aristas):
			return False
		VR.append(path[i][0])
	#Ordenar conjuntos
	VR.sort()
	vertices.sort()
	#Chequear que son iguales
	if VR == vertices:
		return True
	return False

def check_is_hamiltonian_cycle(graph,path):
	if len(graph) < 2 or len(graph[0]) == 0 or len(graph[1]) == 0 or len(path) == 0:
		return False
	vertices, aristas = graph[0], graph[1]
	VR = []
	VR.append(path[0][0])
	for i in range(1,len(path)):
		#Chequear que el camino tiene sentido o  se repite un vertice o la arista no pertenece al grafo
		if path[i][0] != path[i-1][1] or (path[i][0] in VR and path[i][0] != VR[0]) or not(path[i] in aristas):
			return False
		VR.append(path[i][0])
	#Chequear que lovs extremos coinciden
	if VR[0][0] != VR[1][len(VR)-1]:
		return False
	#Ordenar conjuntos 
	VR.sort()
	vertices.sort()
	#Comprobar que son iguales
	if VR == vertices:
		return True
	return False







def main():
	grafo = (['a','b','c','d'],['a b','b c','c d','d a'])
	camino = ['a b','b c','c d','d a']
	valor = check_is_eulerian_cycle(grafo,camino)
	print(valor)

if __name__ == "__main__":
	main()
	













	
	
	
	



