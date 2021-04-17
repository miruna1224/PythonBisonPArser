%token IF;
%token ELSE;
%token WHILE;
%token FOR;
%token BREAK;
%token CONTINUE;
%token RETURN;

%token CLASS;
%token DOTS;
%token PASS;
%token DEF;

%token IGNORE;
%token PLUS;
%token MINUS;
%token INMULTIT;
%token IMPARTIT;
%token MOD;
%token EGAL;
%token MAI_MIC;
%token MAI_MARE;
%token MAI_MIC_EGAL;
%token MAI_MARE_EGAL;
%token EGAL_LOGIC;
%token NOT_EGAL;
%token AND;
%token OR;

%token NOT;

%token ROTUNDA_DESCHISA;
%token ROTUNDA_INCHISA;
%token OPEN_BRACKET;
%token CLOSE_BRACKET;
%token PATRATA_DESCHISA;
%token PATRATA_INCHISA;
%token VIRGULA
%token PUNCT

%token IN;
%token RANGE;

%{
  #include <stdio.h>
  #include <string.h>

  // int yydebug=1;
  extern int yylineno;
  extern char yytext[];

  int yylex (void);
  void yyerror (char const *);
%}

%union {
    int ival;
    float fval;
    char sval[128];
    char cval;
}

%token <sval> IDENTIFIER
%token <ival> INTEGER
%token <fval> FLOAT
%token <sval> STRING
%token <cval> CARACTER


%right EGAL
%left OR
%left AND
%left MAI_MIC MAI_MIC_EGAL MAI_MARE MAI_MARE_EGAL EGAL_LOGIC NOT_EGAL
%left PLUS MINUS
%left INMULTIT IMPARTIT MOD


%%
input :
  %empty
  | statements;

statements:
  statements stmt
  | stmt;

declarare_variabila:
    declarator EGAL expr     { printf ("Declararea unei variabile cu initializare: %s\n", $1); };

s_or_i :
  STRING | INTEGER | IDENTIFIER;
%type <sval> declarator;
declarator :
    IDENTIFIER                                                      { strcpy($$, $1); }
    | IDENTIFIER PATRATA_DESCHISA s_or_i PATRATA_INCHISA    { strcpy($$, $1); };


declarare_functie:
    DEF IDENTIFIER ROTUNDA_DESCHISA parameters ROTUNDA_INCHISA DOTS stmt { printf ("Declararea unei functii: %s\n", $2); }

parameters:
    %empty
|   parameters2;

%type <sval> parameters2;
parameters2:
    IDENTIFIER                  { strcpy($$, $1); printf ("Parametru: %s\n", $1); }
|   parameters2 VIRGULA IDENTIFIER
|   parameters2 VIRGULA declarare_variabila;



stmt:
    expr
|   member
|   if_stmt
|   loop_stmt
|   jump_stmt
|   declarare_variabila
|   declarare_functie
|   declarare_clasa;


if_stmt:
    IF  expr DOTS stmt { printf("Instructiune If\n"); };

loop_stmt:
    WHILE expr DOTS stmt                                                            { printf("Instructiune While\n"); }
|   FOR  IDENTIFIER IN IDENTIFIER DOTS stmt                                         { printf("Instructiune For\n"); }
|   FOR  IDENTIFIER IN RANGE ROTUNDA_DESCHISA INTEGER ROTUNDA_INCHISA DOTS stmt              { printf("Instructiune For\n"); }
|   FOR  IDENTIFIER IN RANGE ROTUNDA_DESCHISA INTEGER VIRGULA INTEGER ROTUNDA_INCHISA DOTS stmt   { printf("Instructiune For\n"); }
|   FOR  IDENTIFIER IN RANGE ROTUNDA_DESCHISA member ROTUNDA_INCHISA DOTS stmt   { printf("Instructiune For\n"); }
|   FOR  IDENTIFIER IN RANGE ROTUNDA_DESCHISA member VIRGULA member ROTUNDA_INCHISA DOTS stmt   { printf("Instructiune For\n"); }
;

jump_stmt:
    BREAK
|   CONTINUE
|   RETURN
|   RETURN expr ;


expr:
    expr EGAL expr                       { printf("Atribuire\n"); }
|   expr PATRATA_DESCHISA expr PATRATA_INCHISA EGAL expr          { printf("Atribuire cu acces de element\n"); }
|   expr relational_op expr             { printf("Operatie relationala\n"); }
|   expr arithmetic_op expr             { printf("Operatie aritmetica\n"); }
|   unary_op expr                       { printf("Operatie unara\n"); }
|   ROTUNDA_DESCHISA expr ROTUNDA_INCHISA
|   member
|   expr PATRATA_DESCHISA expr PATRATA_INCHISA
|   expr ROTUNDA_DESCHISA arguments ROTUNDA_INCHISA        { printf("Apel de functie\n"); }
|   INTEGER
|   FLOAT
|   STRING                              { printf("Sir de caractere: %s\n", $1); }
|   CARACTER                           { printf("Caracter: %c\n", $1); };

%type <sval> member;
member:
    IDENTIFIER                          { strcpy($$, $1); }
|   member PUNCT IDENTIFIER               { strcpy($$, $1); strcat($$, "."); strcat($$, $3); printf("Acces la membrul \"%s\" al clasei/structurii: %s\n", $3, $1); }
|   member PUNCT IDENTIFIER ROTUNDA_DESCHISA arguments ROTUNDA_INCHISA { strcpy($$, $1); strcat($$, "."); strcat($$, $3); printf("Acces la membrul \"%s\" al clasei/structurii: %s\n", $3, $1); }
|   member PUNCT IDENTIFIER PATRATA_DESCHISA IDENTIFIER PATRATA_INCHISA   { strcpy($$, $1); strcat($$, "."); strcat($$, $3); printf("Acces la membrul \"%s\" al clasei/structurii: %s\n", $3, $1); }
|   member PUNCT IDENTIFIER PATRATA_DESCHISA INTEGER PATRATA_INCHISA      { strcpy($$, $1); strcat($$, "."); strcat($$, $3); printf("Acces la membrul \"%s\" al clasei/structurii: %s\n", $3, $1); }
;

relational_op:
    OR | AND | EGAL_LOGIC | NOT_EGAL | MAI_MIC | MAI_MIC_EGAL | MAI_MARE | MAI_MARE_EGAL
;

arithmetic_op:
    PLUS | MINUS | INMULTIT | IMPARTIT | MOD
;

unary_op:
    NOT;

arguments:
    %empty
|   arglist
|   arguments VIRGULA arglist
;

arglist:
   INTEGER | FLOAT | STRING | CARACTER | member;



declarare_clasa:
  CLASS IDENTIFIER ROTUNDA_DESCHISA ROTUNDA_INCHISA DOTS struct_class_body   { printf("Declara o clasa sau structura noua: %s\n", $2); }
  | CLASS IDENTIFIER ROTUNDA_DESCHISA IDENTIFIER ROTUNDA_INCHISA DOTS struct_class_body   { printf("Declara o clasa sau structura noua: %s\n", $2); }
  | CLASS IDENTIFIER DOTS struct_class_body
;

struct_class_body:
    struct_class_element
|   struct_class_body struct_class_element
;

struct_class_element:
    declarare_variabila
|   declarare_functie
;

%%

void yyerror(char const *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    yyparse();
}
