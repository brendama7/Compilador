%{
#include <stdio.h>
#include <strings.h>
#include "parser.h"
char bufferQ[300];
// #include "main.c"


%}

%option noinput
%option nounput
%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno

letra [a-zA-Z]
numero [0-9]+
letraOdigito [a-zA-Z0-9]
error [[:^alnum:]]{-}[[:space:]]{-}[(),.]{-}[+/*-]
espacio [[:space:]]
asignacion <-

%%
programa					return PROGRAMA;
variables					return VARIABLES;
definir						return DEFINIR;
codigo						return CODIGO;
leer						return LEER;
escribir					return ESCRIBIR;
fin						return FIN;	

{letra}{letraOdigito}*      			{yylval = strdup(yytext); return ID;}
{numero}                    			{yylval = strdup(yytext); return CONSTANTE;}

\(						return '(';
\)						return ')';
\.						return '.';
,						return ',';
\+						return '+';
\-						return '-';
\/						return '/';
\*						return '*';

{asignacion}                			return ASIGNACION;
{numero}{letra}+{letraOdigito}* 	{yylexerrs++; sprintf(bufferQ,"Error léxico: Constante con sufijo inválida: %s",yytext); yyerror(bufferQ); }
{letra}{letraOdigito}*{error}+({letraOdigito}|{error})*		{yylexerrs++;  sprintf(bufferQ,"Error léxico: Identificador inválido: %s",yytext); yyerror(bufferQ);}
{error}+				{yylexerrs++;  sprintf(bufferQ,"Error léxico: Cadena desconocida: %s",yytext); yyerror(bufferQ);}
	
{espacio}		
\/\/.*\n|.|\n               
%%
