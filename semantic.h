#ifndef SEMANTIC_H_INCLUDED
#define SEMANTIC_H_INCLUDED

void comenzar();
void terminar();
void leerId(char*);
void escribirExp(char*);
char* invertir(char*);
char* nuevoTemp(void);
char* generarInfijo(char*, char, char*);
void asignar(char*, char*);
#endif