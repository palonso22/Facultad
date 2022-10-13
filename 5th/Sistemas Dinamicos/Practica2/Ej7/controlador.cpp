#include "controlador.h"
void controlador::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type
x=0;
l=0;
lref=va_arg(parameters,double);
k1=va_arg(parameters,double);
k2=va_arg(parameters,double);
sigma=1;
}
double controlador::ta(double t) {
//This function returns a double.
return sigma;
}
void controlador::dint(double t) {
x+= lref-l;
sigma=1;
}
void controlador::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition
l=x.getDouble();
sigma-=e;

}
Event controlador::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

int e = lref-l;
y[0]=sat(k1*e+k2*x);
return Event(&y[0],0);
}
void controlador::exit() {
//Code executed at the end of the simulation.

}
