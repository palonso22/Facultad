#! /usr/bin/python

# 5ta Practica Laboratorio 
# Complementos Matematicos I
# Consigna: Implementar los siguientes metodos

import time
import pdb


def actualizar_cola(cola,arista):
	i = 0
	while(i < len(cola) and cola[i][2] < arista[2]):
		i+=1
	return cola[0:i] + [arista] + cola[i:len(cola)]








def prim(grafo):
    '''
    Dado un grafo (en formato de listas con pesos), aplica el algoritmo de Prim
    y retorna el MST correspondiente. 
    NOTA: El grafo de entrada se asume conexo.
    '''
    inicio = time.time()
    V,E = grafo[0],grafo[1][:]
    VT = [V[0]] #Vertices del arbol
    ET = [] #Aristas del arbol
    cola = []
    #Agregamos todas las aristas  incidentes en los vertices VT que no hallan sido agregadas antes a la cola o que no sean aristas de MVT
   
    while(VT != V ):	
		for i in range(len(E)): 
			if E[i] not in cola and E[i] not in ET and (E[i][0] in VT and E[i][1] not in VT) or (E[i][1] in VT and E[i][0] not in VT) :
				cola = actualizar_cola(cola,E[i]) #Agregar a cola
				#E.remove(E[i]) #Ya no consideraremos esta arista
		arActual = cola.pop(0) #Tomar arista con menor peso
		while arActual[0] in VT and arActual[1] in VT:
			arActual = cola.pop(0)
		if arActual[0] in VT:
			VT.append(arActual[1])
		else:
			VT.append(arActual[0])
		ET.append(arActual)
		VT.sort()
    final = time.time()
    return (VT,ET)	
				
		


def kruskal(grafo):
    '''
    Dado un grafo (en formato de listas con pesos), aplica el algoritmo de 
    Kruskal y retorna el MST correspondiente (o un bosque, en el caso de que 
    no sea conexo).
    '''
    V,E = grafo[0], grafo[1]
    E2 = []
    cola = []
    Cjtos = dict([(x,y) for y,x in enumerate(V)])
    for i in range(len(E)):
		cola = actualizar_cola(cola,E[i])
    i = 0
    #pdb.set_trace()
    while(len(cola) > 0 and len(E2) < len(V)-1):
		EActual = cola.pop(0)
		if Cjtos[EActual[0]] != Cjtos[EActual[1]]:
			E2.append(EActual)
			Cjtos[EActual[1]] = Cjtos[EActual[0]]
    return (V,E2)	
   


def main():
	grafo = (['a', 'b', 'c','d','e','f','g'],[ ('a', 'b', 7),('b', 'c', 8),('c', 'e', 5),('b', 'e', 7),('b', 'd', 9),
    ('a', 'd', 5),('e', 'd', 15),('e', 'f', 8),('d', 'f', 6),('f', 'g', 11),('e','g',9)])
	arbol = kruskal(grafo)
	arbol1 = prim(grafo)
	print(arbol)

if __name__ == "__main__":
    main()
