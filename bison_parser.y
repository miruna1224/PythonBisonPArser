%{
  #include <stdio.h>
  #include <string.h>

  extern char yytext[];
  int yylex (void);
  void yyerror (char const *);
%}

%token IF;
%token ELSE;
%token WHILE;
%token FOR;
%token BREAK;
%token CONTINUE;
%token RETURN;

%token PLUS;
%token MINUS;
%token INMULTIT;
%token IMPARTIT;
%token EGAL;
%token MOD;

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
%token PATRATA_DESCHISA;
%token PATRATA_INCHISA;
%token ACOLADA_DESCHISA;
%token ACOLADA_INCHISA;

%token DOUA_PUNCTE;
%token VIRGULA
%token PUNCT

%token DEF;
%token CLASS;
%token PASS;

%token IN;
%token RANGE;

%union {
    int intreg;
    float real;
    char sir[128];
    char caracter;
}

%token <sir>      IDENTIFICATOR
%token <intreg>   INTREG
%token <real>     REAL
%token <sir>      STRING
%token <caracter> CARACTER


%right EGAL
%left OR
%left AND
%left MAI_MIC MAI_MIC_EGAL MAI_MARE MAI_MARE_EGAL EGAL_LOGIC NOT_EGAL
%left PLUS MINUS
%left INMULTIT IMPARTIT MOD


%%
input :
  %empty
  | instructiuni;


instructiuni:
  instructiuni instructiune
  | instructiune;


declarare_variabila:
    declarator EGAL expresie  { printf ("Variabila declarata si initializata: %s\n", $1); };


string_int_identificator :
  STRING | INTREG | IDENTIFICATOR;


%type <sir> declarator;
declarator :
    IDENTIFICATOR                                                                   { strcpy($$, $1); }
    | IDENTIFICATOR PATRATA_DESCHISA string_int_identificator PATRATA_INCHISA       { strcpy($$, $1); };


declarare_functie:
    DEF IDENTIFICATOR ROTUNDA_DESCHISA parametrii ROTUNDA_INCHISA DOUA_PUNCTE instructiune   { printf ("Declararea unei functii: %s\n", $2); }


parametrii:
    %empty
    | parametru;


%type <sir> parametru;
parametru:
    IDENTIFICATOR   { strcpy($$, $1); printf ("Parametru: %s\n", $1); }
    | parametru VIRGULA IDENTIFICATOR
    | parametru VIRGULA declarare_variabila;



instructiune:
  expresie
  | IDENTIFICATOR_COMPUS
  | if
  | while_for
  | salt_end
  | declarare_variabila
  | declarare_functie
  | declarare_clasa;


if:
    IF  expresie DOUA_PUNCTE instructiune { printf("Instructiune If\n"); };


while_for:
    WHILE expresie DOUA_PUNCTE instructiune                                                                               { printf ("Am intalnit instructiunea While\n"); }
    | FOR  IDENTIFICATOR IN IDENTIFICATOR DOUA_PUNCTE instructiune                                                        { printf ("Am intalnit instructiunea For\n"); }
    | FOR  IDENTIFICATOR IN RANGE ROTUNDA_DESCHISA INTREG ROTUNDA_INCHISA DOUA_PUNCTE instructiune                        { printf ("Am intalnit instructiunea For\n"); }
    | FOR  IDENTIFICATOR IN RANGE ROTUNDA_DESCHISA INTREG VIRGULA INTREG ROTUNDA_INCHISA DOUA_PUNCTE instructiune         { printf ("Am intalnit instructiunea For\n"); }
    | FOR  IDENTIFICATOR IN RANGE ROTUNDA_DESCHISA IDENTIFICATOR_COMPUS ROTUNDA_INCHISA DOUA_PUNCTE instructiune          { printf ("Am intalnit instructiunea For\n"); }
    | FOR  IDENTIFICATOR IN RANGE ROTUNDA_DESCHISA IDENTIFICATOR_COMPUS VIRGULA IDENTIFICATOR_COMPUS ROTUNDA_INCHISA DOUA_PUNCTE instructiune     { printf ("Am intalnit instructiunea For\n"); };


salt_end:
    BREAK
    | CONTINUE
    | RETURN
    | RETURN expresie ;


expresie:
    expresie EGAL expresie                                                      { printf ("expresie de atribuire\n"); }
    | expresie PATRATA_DESCHISA expresie PATRATA_INCHISA EGAL expresie          { printf ("expresie de atribuire element din vector\n"); }
    | expresie R expresie                                                       { printf ("expresie relationala\n"); }
    | expresie A expresie                                                       { printf ("expresie aritmetica\n"); }
    | NOT expresie                                                              { printf ("expresie unara\n"); }
    | ROTUNDA_DESCHISA expresie ROTUNDA_INCHISA
    | IDENTIFICATOR_COMPUS                                                      { printf ("Identificator\n"); }
    | expresie PATRATA_DESCHISA expresie PATRATA_INCHISA
    | expresie ROTUNDA_DESCHISA argumente ROTUNDA_INCHISA                       { printf ("FUNCTIE\n"); }
    | INTREG                                                                    { printf ("intreg\n"); }
    | REAL                                                                      { printf ("real\n"); }
    | STRING                                                                    { printf ("Sir de caractere: %s\n", $1); }
    | CARACTER                                                                  { printf ("Caracter: %c\n", $1); };


%type <sir> IDENTIFICATOR_COMPUS;
IDENTIFICATOR_COMPUS:
    IDENTIFICATOR                                                                             { strcpy ($$, $1); }
    | IDENTIFICATOR_COMPUS PUNCT IDENTIFICATOR                                                { strcpy ($$, $1); strcat ($$, "."); strcat ($$, $3); printf ("Accesez membrulul \"%s\" clasei: %s\n", $3, $1); }
    | IDENTIFICATOR_COMPUS PUNCT IDENTIFICATOR ROTUNDA_DESCHISA argumente ROTUNDA_INCHISA     { strcpy ($$, $1); strcat ($$, "."); strcat ($$, $3); printf ("Apelez functia \"%s\" clasei: %s\n", $3, $1); }
    | IDENTIFICATOR_COMPUS PUNCT IDENTIFICATOR PATRATA_DESCHISA IDENTIFICATOR PATRATA_INCHISA { strcpy ($$, $1); strcat ($$, "."); strcat ($$, $3); printf ("Accesez membrulul \"%s\" clasei: %s\n", $3, $1); }
    | IDENTIFICATOR_COMPUS PUNCT IDENTIFICATOR PATRATA_DESCHISA INTREG PATRATA_INCHISA        { strcpy ($$, $1); strcat ($$, "."); strcat ($$, $3); printf ("Accesez membrulul \"%s\" clasei: %s\n", $3, $1); };


R:
    OR
    | AND
    | EGAL_LOGIC
    | NOT_EGAL
    | MAI_MIC
    | MAI_MIC_EGAL
    | MAI_MARE
    | MAI_MARE_EGAL;


A:
    PLUS
    | MINUS
    | INMULTIT
    | IMPARTIT
    | MOD;


argumente:
    %empty
    | tip_argumente
    | argumente VIRGULA tip_argumente;


tip_argumente:
   INTREG
   | REAL
   | STRING
   | CARACTER
   | IDENTIFICATOR_COMPUS;


declarare_clasa:
  CLASS IDENTIFICATOR ROTUNDA_DESCHISA ROTUNDA_INCHISA DOUA_PUNCTE block_clasa                    { printf("Declara o clasa sau structura noua: %s\n", $2); }
  | CLASS IDENTIFICATOR ROTUNDA_DESCHISA IDENTIFICATOR ROTUNDA_INCHISA DOUA_PUNCTE block_clasa    { printf("Declara o clasa sau structura noua: %s\n", $2); }
  | CLASS IDENTIFICATOR DOUA_PUNCTE block_clasa;


block_clasa:
    continut_clasa
    | block_clasa continut_clasa;


continut_clasa:
    declarare_variabila
    | declarare_functie;

%%


void yyerror (char const *s) {
    fprintf (stderr, "%s\n", s);
}

int main() {
    yyparse();
}
