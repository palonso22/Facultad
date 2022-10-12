#! /usr/bin/python
# -*- coding: utf-8 -*-

import unittest
import os

from practica_3 import (check_is_hamiltonian_trail,
                                 check_is_hamiltonian_circuit,
                                 check_is_eulerian_trail,
                                 check_is_eulerian_circuit,
                                 graph_has_eulerian_trail,
                                 find_eulerian_circuit)


class TestIsHamiltoneanTrail(unittest.TestCase):
    graph_1 = ([], [])
    graph_2 = (['a'], [])
    graph_3 = (['a'], [('a', 'a')])
    graph_4 = (['a', 'b'], [('a', 'b')])
    graph_5 = (['a', 'b', 'c'], [('a', 'b'), ('b', 'c')])
    graph_6 = (['a', 'b', 'c', 'd'],
               [('a', 'b'), ('b', 'c'), ('a', 'd'), ('c', 'd'), ('d', 'a')])

    is_trail_cases = [
        (graph_1, []),
        (graph_4, [('a', 'b')]),
        (graph_5, [('a', 'b'), ('b', 'c')]),
        (graph_6, [('a', 'b'), ('b', 'c'), ('c', 'd')])
    ]

    is_not_trail_cases = [
        (graph_1, [('a', 'b')]),
        (graph_2, [('b', 'a')]),
        (graph_2, []),
        (graph_3, [('b', 'a')]),
        (graph_3, []),
        (graph_4, []),
        (graph_4, [('b', 'a')]),
        (graph_4, [('a', 'c'), ('c', 'b')]),
        (graph_5, [('b', 'c'), ('a', 'b')]),
        (graph_6, [('a', 'b'), ('b', 'c'), ('c', 'd'), ('d', 'a')])
    ]

    def test_is_trail_cases(self):
        for graph, path in self.is_trail_cases:
            result = check_is_hamiltonian_trail(graph, path)
            self.assertTrue(
                result,
                'caso: check_is_hamiltonian_trail({}, {})'.format(graph, path)
            )

    def test_is_not_trail_cases(self):
        for graph, path in self.is_not_trail_cases:
            result = check_is_hamiltonian_trail(graph, path)
            self.assertFalse(
                result,
                'caso: check_is_hamiltonian_trail({}, {})'.format(graph, path)
            )

            
class TestIsHamiltoneanCircuit(unittest.TestCase):
    graph_1 = ([], [])
    graph_2 = (['a'], [])
    graph_3 = (['a'], [('a', 'a')])
    graph_4 = (['a', 'b'], [('a', 'b'), ('b', 'a')])
    graph_5 = (['a', 'b', 'c'], [('a', 'b'), ('b', 'c')])
    graph_6 = (['a', 'b', 'c', 'd'],
               [('a', 'b'), ('b', 'c'), ('a', 'd'), ('c', 'd'), ('d', 'a')])

    is_circuit_cases = [
        (graph_1, []),
        (graph_3, [('a', 'a')]),
        (graph_4, [('a', 'b'), ('b', 'a')]),
        (graph_6, [('a', 'b'), ('b', 'c'), ('c', 'd'), ('d', 'a')])
    ]

    is_not_circuit_cases = [
        (graph_1, [('a', 'b')]),
        (graph_2, [('b', 'a')]),
        (graph_2, []),
        (graph_3, [('b', 'a')]),
        (graph_3, []),
        (graph_4, []),
        (graph_4, [('a', 'c'), ('c', 'a')]),
        (graph_5, [('b', 'c'), ('a', 'b')]),
        (graph_6, [('a', 'b'), ('b', 'c'), ('c', 'd')])
    ]

    def test_is_circuit_cases(self):
        for graph, path in self.is_circuit_cases:
            result = check_is_hamiltonian_circuit(graph, path)
            self.assertTrue(
                result,
                'caso: check_is_hamiltonian_circuit({}, {})'.format(graph, path)
            )

    def test_is_not_circuit_cases(self):
        for graph, path in self.is_not_circuit_cases:
            result = check_is_hamiltonian_circuit(graph, path)
            self.assertFalse(
                result,
                'caso: check_is_hamiltonian_circuit({}, {})'.format(graph, path)
            )


class TestIsEulerianTrail(unittest.TestCase):
    graph_1 = ([], [])
    graph_2 = (['a'], [])
    graph_3 = (['a'], [('a', 'a')])
    graph_4 = (['a', 'b'], [('a', 'b'), ('b', 'a')])
    graph_5 = (['a', 'b', 'c'], [('a', 'b'), ('b', 'c'),('c','a')])
    graph_6 = (['a', 'b', 'c', 'd'],
               [('a', 'b'), ('b', 'c'), ('a', 'd'), ('c', 'd'), ('d', 'a')])
    
    is_trail_cases = [
       (graph_1,[]),
       (graph_2,[]),
       (graph_3,[('a','a')]),
       (graph_4,[('a','b'),('b','a')]),
       (graph_5,[('c', 'a'),('a','b'),('b', 'c')]),
       (graph_6,[('a','d'),('c','d'),('d','a'),('a','b'),('b','c')])
    ]
    
    
    is_not_trail_cases = [
        (graph_1, [('z','b')]),
        (graph_2,[('a','a')]),
        (graph_3,[('a','a'),('a','a')]),
        (graph_4,[('a','b'),('b','a'),('a','b')]),
        (graph_5,[('c', 'a'),('a','b')]),
        (graph_6,[('c','d'),('d','a'),('a','b'),('b','c')])
    ]
    
 
    def test_is_trail_cases(self):
        for graph, path in self.is_trail_cases:
            result = check_is_eulerian_trail(graph, path)
            self.assertTrue(
                 result,
                 'caso: check_is_eulerian_trail({}, {})'.format(graph, path)
            )
	
	
    def test_is_not_trail_cases(self):
		for graph, path in self.is_not_trail_cases:
			result = check_is_eulerian_trail(graph, path)
			self.assertFalse(
			    result,
			    'caso: check_is_eulerian_trail({},{})'.format(graph, path)
			)




class TestIsEulerianCircuit(unittest.TestCase):
    graph_1 = ([], [])
    graph_2 = (['a'], [])
    graph_3 = (['a'], [('a', 'a')])
    graph_4 = (['a', 'b'], [('a', 'b'), ('b', 'a')])
    graph_5 = (['a', 'b', 'c'], [('a', 'b'), ('b', 'c'),('c','a')])
    graph_6 = (['a', 'b', 'c', 'd'],
               [('a', 'b'), ('b', 'c'),('c', 'd'), ('d', 'a')])
    
    is_circuit_cases = [
       (graph_1,[]),
       (graph_2,[]),
       (graph_3,[('a','a')]),
       (graph_4,[('a', 'b'), ('b', 'a')]),
       (graph_5,[('a', 'b'), ('b', 'c'),('c','a')]),
       (graph_6,[('a', 'b'), ('b', 'c'),('c', 'd'), ('d', 'a')])
    ]
    
    
    is_not_circuit_cases = [
        (graph_1, [()]),
        (graph_2,[('a','a'),('a','a')]),
        (graph_3,[('a','b')]),
        (graph_4,[('a','b'),('b','a'),('a','b')]),
        (graph_5,[('c', 'a'),('a','b')]),
        (graph_6,[('d','d'),('d','a'),('a','b'),('b','c')])
    ]
    
 
    def test_is_circuit_cases(self):
        for graph,path in self.is_circuit_cases:
			result = check_is_eulerian_circuit(graph, path)
			self.assertTrue(
            result,
                 'caso: check_is_eulerian_circuit({}, {})'.format(graph, path)
            )
	
    def test_is_not_circuit_cases(self):
		for graph, path in self.is_not_circuit_cases:
			result = check_is_eulerian_circuit(graph, path)
			self.assertFalse(
			    result,
			    'caso: check_is_eulerian_circuit({},{})'.format(graph, path)
			)


class TestHasEulerianTrail(unittest.TestCase):
    
    
    has_eulerian_trail_cases = [
    ([], []),
    (['a'], [('a','a')]),
    (['a','b'], [('a', 'b')]),
    (['a', 'b'], [('b', 'a')]),
    (['a', 'b', 'c'], [('a', 'b'), ('b', 'c'),('c','a')]),
    (['a', 'b', 'c', 'd'],[('a', 'b'), ('b', 'c'),('c', 'd'), ('d', 'a')]),
    (['a','b','c'],[('a','b'),('b','c'),('c','c')])
    ]
    
    has_not_eulerian_trail_cases = [
    ([],[('a','a')]),
    (['a'],[]),
    (['a','b'],[('a','b'),('b','a')]),
    (['a','b','c'],[('a','b')]),
    (['a','b','c'],[('a','b'),('b','c'),('c','b')]),
	(['a', 'b', 'c', 'd'],[('a', 'b'), ('b', 'c'),('d', 'd'), ('d', 'd')]),
    (['a', 'b', 'c', 'd','e'],[('a', 'b'), ('b', 'c'),('c', 'd'), ('d', 'a')]),
    ]
   
 
    def test_has_eulerian_trail(self):
        for graph in self.has_eulerian_trail_cases:
			result = graph_has_eulerian_trail(graph)
			self.assertTrue(
            result,
                 'caso: check_is_eulerian_circuit({})'.format(graph)
            )

    def test_has_not_eulerian_trail(self):
		for graph in self.has_not_eulerian_trail_cases:
			result = graph_has_eulerian_trail(graph)
			self.assertFalse(
			    result,
			    'caso: check_is_eulerian_circuit({})'.format(graph)
			)

    


class TestFindEulerianCircuit(unittest.TestCase):
    find_eulerian_circuit_cases = [
    ([], []),
    (['a'], [('a','a')]),
    (['a','b'], [('a', 'b')]),
    (['a', 'b'], [('b', 'a')]),
    (['a', 'b', 'c'], [('a', 'b'), ('b', 'c'),('c','a')]),
    (['a', 'b', 'c', 'd'],[('a', 'b'), ('b', 'c'),('c', 'd'), ('d', 'a')]),
    (['a','b','c'],[('a','b'),('b','c'),('c','c')])
    ]
    
    not_find_eulerian_circuit_cases = [
    ([],[('a','a')]),
    (['a'],[]),
    (['a','b'],[('a','b'),('b','a')]),
    (['a','b','c'],[('a','b')]),
    (['a','b','c'],[('a','b'),('b','c'),('c','b')]),
	(['a', 'b', 'c', 'd'],[('a', 'b'), ('b', 'c'),('d', 'd'), ('d', 'd')]),
    (['a', 'b', 'c', 'd','e'],[('a', 'b'), ('b', 'c'),('c', 'd'), ('d', 'a')]),
    ]
   
 
    def test_fin_eulerian_circuit(self):
        for graph in self.find_eulerian_circuit_cases:
			result = find_eulerian_circuit(graph)
			self.assertTrue(
            result,
                 'caso: check_is_eulerian_circuit({})'.format(graph)
            )
"""
    def test_not_find_eulerian_circuit(self):
		for graph in self.not_find_eulerian_circuit_cases:
			result = find_eulerian_circuit(graph)
			self.assertFalse(
			    result,
			    'caso: check_is_eulerian_circuit({})'.format(graph)
			)
   """ 
if __name__ == '__main__':
    os.system('clear')
    unittest.main()
