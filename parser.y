%code top {
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "scanner.h"
#include "semantic.h"
#include "symbol.h"
// #include "main.c"
}

%code provides {
	void yyerror(const char *);
	extern int yylexerrs;
	extern int yynerrs;
	extern int nerrlex;
	extern int nerrsem;
}



%defines "parser.h"
%output "parser.c"
%token ID CONSTANTE PROGRAMA VARIABLES DEFINIR CODIGO LEER ESCRIBIR FIN
%token ASIGNACION "<-"
%token NEG '-'

%right ASIGNACION
%left '-' '+'
%left '*' '/'
%precedence NEG

%define api.value.type {char *}
%define parse.error verbose


%%

programamini		: {comenzar();} PROGRAMA VARIABLES definicionVariables CODIGO definicionCodigo FIN {terminar(); if (yynerrs || yylexerrs || nerrsem) YYABORT;else YYACCEPT;} 
			;
definicionVariables	: DEFINIR ID '.' {if (estaDeclarada($2)!=1){agregar($2);}else {agregarAlDiccionario($2);};}
			| definicionVariables DEFINIR ID '.' {if (estaDeclarada($3)!=1){agregar($3);}else {agregarAlDiccionario($3);YYERROR;};}
			| DEFINIR error '.'
			| error '.'
			;
definicionCodigo	: sentencia 
			| definicionCodigo sentencia
			;
sentencia		: LEER '(' identificadores ')' '.' 
			| ESCRIBIR '(' expresiones ')' '.' 
			| ID ASIGNACION expresion  '.'  {if(!verificarID($1)){asignar($1,$3);;YYERROR;}}
			| error  
			;
identificadores		: identificadores ',' ID {if(!verificarID($3)){leerId($3);YYERROR;}}
			| ID {if(!verificarID($1)){leerId($1);YYERROR;}}
			;
expresiones		: expresiones ',' expresion 
			| expresion {escribirExp($1);}
			;
			
expresion		: expresion '+' expresion {$$=generarInfijo($1,'+',$3);} 
			| expresion '-' expresion {$$=generarInfijo($1,'-',$3);} 
			| expresion '*' expresion {$$=generarInfijo($1,'*',$3);} 
			| expresion '/' expresion {$$=generarInfijo($1,'/',$3);}
			| ID {if(!verificarID($1))	YYERROR;}
			| CONSTANTE {$$=$1;}
			| '-' expresion %prec NEG {$$=invertir($2);}
			| '(' expresion ')' {$$=$2;}
			;
%%

/* Informa la ocurrencia de un error. */
void yyerror(const char *s){
	 fprintf (stderr,"línea #%d: %s\n",yylineno, s);
}