#include <stdio.h>
#include <string.h>
#include "symbol.h"
#include "semantic.h"

int temporal = 1;
char vecTemporales [20];
char* resultado;
char buff [10];


void comenzar(){
	printf ("Load rtlib,\n");
		
}

void terminar(){
	printf ("Stop,\n");
	
}

void leerId(char *id){
	printf("Read %s,Integer\n",id);
}

void escribirExp(char *e){
	printf("Write %s,Integer\n",e);

}

char* invertir(char *s){
	resultado = nuevoTemp();
	printf("INV %s,,%s\n",s,resultado);
	return resultado;
}

char* generarInfijo(char *opI, char op, char* opD){
	resultado = nuevoTemp();
	switch(op) {
	case '+':
		strcpy(buff, "ADD");
	break;
	case '-':
		strcpy(buff, "SUBS");
	break;
	
	case '/':
		strcpy(buff, "DIV");
	break;
	
	case '*':
		strcpy(buff, "MULT");
	break;
	}
	printf("%s %s,%s,%s\n",buff,opI,opD,resultado);
	return resultado;
}

void asignar(char* origen, char* destino){
	printf("Store %s,%s\n",origen,destino);
	
}

char* nuevoTemp(void){
	sprintf(vecTemporales,"Temp#%d",temporal);
	temporal++;	
	agregar(vecTemporales);
	return vecTemporales;
}