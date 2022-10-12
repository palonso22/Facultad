#! /usr/bin/python

'''Tests complementarios practica 4'''

import unittest

import practica5 as p5

class TestPrim(unittest.TestCase):

    def test(self):
        grafo1 = (
            # Nodos
            ['a', 'b', 'c'], 
            # Aristas
            [ 
                ('a', 'b', 1),
                ('b', 'a', 2),
                ('c', 'b', 4),
                ('b', 'c', 3),
                ('b', 'c', 5)
            ]
        )
        
        res = p5.prim(grafo1) # MST de grafo1
        
        nodos_res = res[0]
        aristas_res = res[1]

        # Todos los nodos estan en el resultado
        for n in grafo1[0]:
            self.assertTrue(n in nodos_res)

        # La cantidad de aristas del resultado es la correcta
        self.assertEqual(len(grafo1[0]) - 1, len(aristas_res))

        # Las aristas son las correctas              
        self.assertTrue(('a', 'b', 1) in aristas_res)
        self.assertTrue(('b', 'c', 3) in aristas_res)
        



class TestKruskal(unittest.TestCase):

    def test_1(self):
        grafo1 = (
            # Nodos
            ['a', 'b', 'c'], 
            # Aristas
            [ 
                ('a', 'b', 1),
                ('b', 'a', 2),
                ('c', 'b', 4),
                ('b', 'c', 3),
                ('b', 'c', 5)
            ]
        )
        
        res = p5.kruskal(grafo1) # MST de grafo1
        
        nodos_res = res[0]
        aristas_res = res[1]

        # Todos los nodos estan en el resultado
        for n in grafo1[0]:
            self.assertTrue(n in nodos_res)

        # La cantidad de aristas del resultado es la correcta
        self.assertEqual(len(grafo1[0]) - 1, len(aristas_res))

        # Las aristas son las correctas              
        self.assertTrue(('a', 'b', 1) in aristas_res)
        self.assertTrue(('b', 'c', 3) in aristas_res)

    def test_2(self):
        grafo2 = (
            # Nodos
            ['a', 'b', 'c', 'd', 'e', 'f'], 
            # Aristas
            [ 
                ('a', 'b', 1),
                ('b', 'a', 2),
                ('c', 'b', 4),
                ('b', 'c', 3),
                ('b', 'c', 5),
                ('e', 'f', 10)
            ]
        )
        
        res = p5.kruskal(grafo2) # MST de grafo1
        
        nodos_res = res[0]
        aristas_res = res[1]

        # Todos los nodos estan en el resultado
        for n in grafo2[0]:
            self.assertTrue(n in nodos_res)

        # La cantidad de aristas del resultado es la correcta
        self.assertEqual(len(aristas_res), 3)

        # Las aristas son las correctas         
        self.assertTrue(('a', 'b', 1) in aristas_res)
        self.assertTrue(('b', 'c', 3) in aristas_res)
        self.assertTrue(('e', 'f', 10) in aristas_res)

if __name__ == '__main__':
    unittest.main()
