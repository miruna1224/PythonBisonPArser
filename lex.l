
%{
    #include <stdio.h>
    #include <string.h>
    #include "bison_parser.tab.h"
%}

COMENTARIU_LINIE #.*
BLANK [[:space:]]
CIFRA [0-9]
NUMAR [+-]?[0-9]*[.]?[0-9]+
CARACTER '[a-zA-Z]'
NAME  [a-zA-Z_][a-zA-Z0-9_]*
STRING \"(\\.|[^\\"])*[\"]

%%
"if"        return IF;
"else"      return ELSE;
"while"     return WHILE;
"for"       return FOR;
"break"     return BREAK;
"continue"  return CONTINUE;
"return"    return RETURN;

"+"   return PLUS;
"-"   return MINUS;
"*"   return INMULTIT;
"/"   return IMPARTIT;
"="   return EGAL;
"%"   return MOD;

"<"   return MAI_MIC;
">"   return MAI_MARE;
"<="  return MAI_MIC_EGAL;
">="  return MAI_MARE_EGAL;
"=="  return EGAL_LOGIC;
"!="  return NOT_EGAL;
"<>"  return NOT_EGAL;

"and"  return AND;
"or"  return OR;
"not"   return NOT;

"(" return ROTUNDA_DESCHISA;
")" return ROTUNDA_INCHISA;
"[" return PATRATA_DESCHISA;
"]" return PATRATA_INCHISA;
"{" return ACOLADA_DESCHISA;
"}" return ACOLADA_INCHISA;

":" return DOUA_PUNCTE;
"," return VIRGULA;
"." return PUNCT;

"def"    return DEF;
"class"  return CLASS;
"pass"   return PASS;

"in"  return IN;
"range"  return RANGE;


{COMENTARIU_LINIE}   printf("Comentariu: %s\n", yytext);
{NAME}               { strcpy (yylval.sir, yytext);       return IDENTIFICATOR; }
{CIFRA}+             { yylval.intreg = atoi (yytext);     return INTREG; }
{NUMAR}              { yylval.intreg = atoi (yytext);     return REAL; }
{STRING}             { strcpy (yylval.sir, yytext);       return STRING; }
{CARACTER}           { yylval.caracter = yytext[1];       return CARACTER; }
{BLANK}
.                    printf ("Simbol necunoscut: %s\n", yytext);
%%
