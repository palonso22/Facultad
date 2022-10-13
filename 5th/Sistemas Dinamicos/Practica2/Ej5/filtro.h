//CPP:generador/filtro.cpp
#if !defined filtro_h
#define filtro_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class filtro: public Simulator { 
// Declare the state,
// output variables
// and parameters
#define INF 1.0/0.0

double u,p,sigma;
double y[10];



public:
	filtro(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
