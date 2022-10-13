#include "cola.h"
void cola::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type
primero = 0;
ctos = 0;
sigma = INF;
busy = false;

}
double cola::ta(double t) {
//This function returns a double.
return sigma;
}
void cola::dint(double t) {
primero = nextPos();
ctos--;
sigma=INF;
}
void cola::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition
/*
if (x.port==0){
   sigma = 0;
   elemento = x.getDouble();
   if(!busy && cuantos == 0){     
      port = 0;
      busy = true;
   }    
   else{
      tail[getPos()] = elemento;
      cuantos++;
      //Avisar al sensor que se encola un elemento  
      port = 1;    
*/
if (x.port==0 && ctos < TAIL_SIZE){
   tail[getPos()]=x.getDouble();   
   ctos++;   
   if(!busy){
    busy=true;
    sigma=0;
   }
}

if(x.port==1){
   busy=false;
   if(ctos>0){
     busy=true;
     sigma=0;
   }   
}
}
Event cola::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

y[0]=tail[primero];
return Event(&y[0],0);
}
void cola::exit() {
//Code executed at the end of the simulation.

}
