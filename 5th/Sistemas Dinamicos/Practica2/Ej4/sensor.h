//CPP:generador/sensor.cpp
#if !defined sensor_h
#define sensor_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class sensor: public Simulator { 
// Declare the state,
// output variables
// and parameters
#define INF 1.0/0.0;
int ctos;
double sigma;
double y[10];


public:
	sensor(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
