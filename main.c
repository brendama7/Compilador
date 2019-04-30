/*
 * TP4 - 2018
 * Grupo 09
 * 
 * Bazan Demarsico, Lucas  150.441-1
 * Lizarde, Gerardo        149.382-6
 * Shapiama, Brenda        147.301-3
 * Zuleta, Diego           153.283-2
 */


#include <stdio.h>
#include <stdio.h>
#include <string.h>
#include "parser.h"
#include "scanner.h"






int nerrsem = 0;
int yylexerrs = 0;

int main() {
	switch( yyparse() ){
	case 0:
		puts("Compilación terminada con éxito");
		break;
	case 1:
		puts("Hubo errores de compilación");
		break;
	case 2:
		puts("Memoria insuficiente");
		break;
	}
	printf("Cantidad de errores léxicos: %d\tCantidad de errores sintácticos: %d\tCantidad de errores semanticos: %d\n",yylexerrs,yynerrs,nerrsem);
	return 0;
}

