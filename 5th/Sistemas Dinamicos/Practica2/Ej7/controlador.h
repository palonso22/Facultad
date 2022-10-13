//CPP:generador/controlador.cpp
#if !defined controlador_h
#define controlador_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class controlador: public Simulator { 
// Declare the state,
// output variables
// and parameters


double x,l,lref,k1,k2;
double y[10];
double sigma;

double sat(double x){
 if (x>1)return 1;
 if (x<0)return 0;
 return x;
}

public:
	controlador(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
