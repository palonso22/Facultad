#! /usr/bin/python
import os


# 2da Practica Laboratorio 
# Complementos Matematicos I
# Consigna: Implementar los siguientes metodos

# Un disjointSet lo representaremos como un diccionario. 
# Ejemplo: {'A':1, 'B':2, 'C':1} (Nodos A y C pertenecen al conjunto 
# identificado con 1, B al identificado on 2)

def make_set(lista):
    '''
    Inicializa un conjunto (Lista) de modo de que todos sus elementos pasen 
    a ser conjuntos unitarios. 
    Retorna un disjointSet
    '''
    dicc = dict([(y,x) for x,y in enumerate(lista)])
    return dicc


def find(elem, disjoint_set):
    '''
    Obtiene el identificador correspondiente al conjunto al que pertenece 
    el elemento 'elem'
    '''
    return disjoint_set[elem]
                    

def union(id_1, id_2, disjoint_set):
    '''
    Une los conjuntos con identificadores id_1, id_2.
    Retorna la estructura actualizada
    ''' 
    for vertice,idx in disjoint_set.iteritems():
        if idx == id_2:
            disjoint_set[vertice] = id_1 
              

    return disjoint_set



def dicc_a_list(dicc):
	
	valores = dicc.values()
	valores = list(set(valores))
	l = []
	for i in valores:
		l.append([j for j in dicc if dicc[j] == i])
	return l






def componentes_conexas(grafo_lista):
    '''
    Dado un grafo en representacion de lista, obtiene sus componentes conexas.
    Ejemplo formato salida: 
        [['a, 'b'], ['c'], ['d']]
    '''
    v = grafo_lista[0]
    a = grafo_lista[1]
    dicc = make_set(v)
    for e in a:
		if e[0] < e[1]:
			id_1,id_2 = find(e[0],dicc),find(e[1],dicc)
		else:
			id_1,id_2 = dicc[e[1]],dicc[e[0]]
		dicc = union(id_1,id_2,dicc)
    l = dicc_a_list(dicc)
    return l		
		 
		


def main():
    os.system('clear')
    grafo = (['a', 'b', 'c', 'd','e'], [('a', 'b'), ('a', 'c'), ('d', 'e')])
    componentes_conexas(grafo)
    
    

if __name__ == '__main__':
    main()
