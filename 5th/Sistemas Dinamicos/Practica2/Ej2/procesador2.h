//CPP:generador/procesador2.cpp
#if !defined procesador2_h
#define procesador2_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class procesador2: public Simulator { 
// Declare the state,
// output variables
// and parameters
double u,sigma;
bool busy;

double y[10];

#define INF 1.0/0.0
public:
	procesador2(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
