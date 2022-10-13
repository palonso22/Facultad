//CPP:generador/aleatorio.cpp
#if !defined aleatorio_h
#define aleatorio_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class aleatorio: public Simulator { 
// Declare the state,
// output variables
// and parameters

double s;
double y[10];

double JMIN,JMAX,TMAX;

double random_number(double min,double max){
 return drand48() * (max-min) + min;
}

public:
	aleatorio(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
