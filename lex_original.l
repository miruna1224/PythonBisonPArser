
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
"!"   return NOT;

"<"   return MAI_MIC;
">"   return MAI_MARE;
"<="  return MAI_MIC_EGAL;
">="  return MAI_MARE_EGAL;
"=="  return EGAL_LOGIC;
"!="  return NOT_EGAL;
"&&"  return AND;
"||"  return OR;

"(" return ROTUNDA_DESCHISA;
")" return ROTUNDA_INCHISA;
"[" return PATRATA_DESCHISA;
"]" return PATRATA_INCHISA;
"{" return OPEN_BRACKET;
"}" return CLOSE_BRACKET;
"," return VIRGULA;
":" return DOTS;
"." return PUNCT;

"def"    return DEF;
"class"  return CLASS;
"pass"   return PASS;

"in"  return IN;
"range"  return RANGE;


{COMENTARIU_LINIE}  printf("Comentariu: %s\n", yytext);
{NAME}      { strcpy(yylval.sval, yytext);  return IDENTIFIER; }
{CIFRA}+    { yylval.ival = atoi(yytext);   return INTEGER; }
{NUMAR}    { yylval.ival = atoi(yytext);   return FLOAT; }
{STRING}    { strcpy(yylval.sval, yytext);  return STRING; }
{CARACTER} { yylval.cval = yytext[1];      return CARACTER; }
{BLANK}
.           printf("Simbol necunoscut: %s\n", yytext);
%%
