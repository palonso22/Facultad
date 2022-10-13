//CPP:generador/cola.cpp
#if !defined cola_h
#define cola_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class cola: public Simulator { 
// Declare the state,
// output variables
// and parameters

#define TAIL_SIZE 1000
#define INF 1.0/0.0

int primero;
//double elemento;
int ctos;
//Puerto de salida
double sigma;
bool busy;
double y[10];
double tail[TAIL_SIZE];


int nextPos(){
 return (primero+1)%TAIL_SIZE;
}

int getPos(){
 return (primero+ctos)%TAIL_SIZE;
}


public:
	cola(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
