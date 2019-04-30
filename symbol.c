#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include "parser.h"
#include "symbol.h"
#include "semantic.h"

char *diccionario[200];

int cont = 0;

char vec[100];

void agregarAlDiccionario(char* id){
	if(!(estaDeclarada(id))){
		agregar(id);
	}
	else {
		sprintf(vec,"Error semantico: identificador %s YA declarado",id);
		yyerror(vec);
		nerrsem++;
	}
}

int estaDeclarada(char *id){
	for (int i=0;i<cont;i++){
		if(!strcmp(diccionario[i],id))
			return 1;
			
	}
	return 0;
}


void agregar (char* id){
	if (cont<200){
		diccionario[cont]=strdup(id);
		cont++;
		printf("Declare %s,Integer\n",id);
	}
	else {
	printf("Espacio insuficiente en el diccionario");
	}
}

int verificarID(char *id){
	if(!estaDeclarada(id)){
		sprintf(vec,"Error semantico: identificador %s NO declarado",id);
		yyerror(vec);
		nerrsem++;
		return 0;
	}
	else {
		return 1;
	}
}