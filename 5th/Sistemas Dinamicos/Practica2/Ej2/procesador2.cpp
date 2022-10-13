#include "procesador2.h"
void procesador2::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type
sigma=INF;
busy=false;
}
double procesador2::ta(double t) {
//This function returns a double.
return sigma;
}
void procesador2::dint(double t) {
busy=false;
sigma= INF;
}
void procesador2::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition
if (!busy){
 u = x.getDouble();
 sigma = x.getDouble();
 busy = true;
}
else sigma -= e;

}
Event procesador2::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)


y[0] = u;
return Event(&y[0],0);
}
void procesador2::exit() {
//Code executed at the end of the simulation.

}
