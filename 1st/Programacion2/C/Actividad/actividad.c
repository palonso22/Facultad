#include "actividad.h"
#define tam(x)( sizeof(x)/sizeof(Vehiculo*))


int ingresarVehiculo(Vehiculo* actual[],int limIzq, limDer,char* patente, int modelo, Tiempo horaIngreso){
	//Buscar un lugar libre en el estacionamiento
	for(int i = limIzq; i < limDer && !actual[i]; i++);
	//Si no se encuentra uno retornar
	if(i == tamEst)return 1;
	//Crear el objeto e ingresar datos
	Vehiculo* vehiculoAEstacionar = malloc(sizeof(Vehiculo));
	vehiculoAEstacionar->patente = patente;
	vehiculoAEstacionar->modelo = modelo;
	vehiculoAEstacionar->horaIngreso = hzaIngreso;
	vehiculoAEstacionar->ubicacion = i+1;
	//Ingresar en el arreglo
	actual[i] = vehiculoAEstacionar;
	return 0;
	}


int determinarPos(Vehiculo* actual[],int patente){
	//Buscar en el estacionamiento 
	for(int i = 0; i < 24; i++){
		if(strcmp(actual[i]->patente,patente) == 0) break;
		}
	if(i == 24)return 0;
	return actual[i]->ubicacion;
	}


int conversionHoras(Tiempo HoraIngreso,Tiempo HoraEgreso){
	//Calculamos los dias
	int dias = (HoraEgreso.mes-HoraIngreso.mes)* 30 + HoraEgreso.dia-HoraIngreso.dia;
	//Calculamos las horas
	int horas = dias*24 + (HoraEgreso.hora - HoraIngreso.hora);
	return horas;
	}



int aux_monto(int ubicacion,Tiempo HoraIngreso, Tiempo HoraEgreso){
	//Las bicicletas no tienen costo
	if(ubicacion > 2 && ubicacion < 5)return 0;
	//Calculamos el costo para los autos y luego determinamos
	//si dividimos el  resultado o no
	int horas = conversionHoras(HoraIngreso,HoraEgreso), costo;
	if(horas >= 12){
		for(int i = 1; i*12 < horas; costo += 120);
		costo += (horas % 12) * 25;
		} 
	else{
		costo = horas * 25;
		}
	if(ubicacion >= 5 && ubicacion <= 7){
		return costo/2;
		}
	return costo;
	}



int montoCobrar(Vehiculo* vehiculo){
	monto = aux_monto(vehiculo->ubicacion,vehiculo->HoraIngreso,vehiculo->HoraEgreso);
	return monto;
		}
	


int recaudacionDia(Vehiculo* registro[], int dia){
	int total = 0;
	for(int i = 0; i < tamRe; i++){
		if(registro[i]->HoraEgreso.dia == dia && registro[i].HoraEgreso.mes == mes){
			total+= montoCobrar(registo);
			}
		}
	return total;
	}


void mostrarVehiculosEstacionamiento(Vehiculo* registro[]){
	Tiempo time;
	int cantidad = tam(registro);
	printf("\n\n---------------")
	for(int i = 0; i < tam;i++){
		printf("Modelo: %d\n",registro[i]->modelo);
		printf("Patente: %s",registro[i]->patente);
		time = registro[i]->horaIngreso;
		printf("Datos Ingreso %d/%d/%d/%d\n",time.dia,time.mes, time.hora, time.min);
		time = registro[i]->horaEgreso; 
		printf("Datos Egreso: %d/%d/%d/%d\n",time.dia,time.mes, time.hora, time.min);
		}
	}

void mostrarVehiculosEstacionados(Vehiculo* actual[]){
	Tiempo time;
	int cantidad = tam(registro);
	printf("\n\n---------------");
	for(int i = 0; i < 24;i++){
		if(registro[i] != NULL){
			printf("\n\n---------------");
			printf("Modelo: %d\n",registro[i]->modelo);
			printf("Patente: %s\n",registro[i]->patente);
			time = registro[i]->horaIngreso;
			printf("Datos Ingreso %d/%d/%d/%d\n",time.dia,time.mes, time.hora, time.min);
			}
		}
	}
	

int estacionarPersonaDiscapacitada(Vehiculo* actual[]){
	if(!actual[0] || !actual[1])return 1;
	return 0;
	}






















