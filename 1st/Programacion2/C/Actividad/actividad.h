

#ifndef _ACTIVIDAD_
#define _ACTIVIDAD_
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#define tamEst 24
#define tamRe

typedef struct _Tiempo{
	int dia, mes, hora, min;
	}Tiempo;





typedef struct _Vehiculo{
	char* patente;
	int modelo;
	Tiempo HoraIngreso;
	Tiempo HoraEgreso;
	int monto;
	int ubicacion;
	}*Vehiculo;


Vehiculo* ingresarVehiculo(Vehiculo**,char* , char, Tiempo , int);





#endif
