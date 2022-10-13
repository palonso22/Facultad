#include "aleatorio.h"
void aleatorio::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type



JMIN=va_arg(parameters,double);
JMAX=va_arg(parameters,double);
TMAX=va_arg(parameters,double);


srand(time(NULL));
s= random_number(JMIN,JMAX);
}
double aleatorio::ta(double t) {
//This function returns a double.
return s;
}
void aleatorio::dint(double t) {
s= random_number(JMIN,JMAX);
}
void aleatorio::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

}
Event aleatorio::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)


y[0]=random_number(0,TMAX);
return Event(&y[0],0);
}
void aleatorio::exit() {
//Code executed at the end of the simulation.

}
