/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_BISON_PARSER_TAB_H_INCLUDED
# define YY_YY_BISON_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    ELSE = 259,
    WHILE = 260,
    FOR = 261,
    BREAK = 262,
    CONTINUE = 263,
    RETURN = 264,
    PLUS = 265,
    MINUS = 266,
    INMULTIT = 267,
    IMPARTIT = 268,
    EGAL = 269,
    MOD = 270,
    MAI_MIC = 271,
    MAI_MARE = 272,
    MAI_MIC_EGAL = 273,
    MAI_MARE_EGAL = 274,
    EGAL_LOGIC = 275,
    NOT_EGAL = 276,
    AND = 277,
    OR = 278,
    NOT = 279,
    ROTUNDA_DESCHISA = 280,
    ROTUNDA_INCHISA = 281,
    PATRATA_DESCHISA = 282,
    PATRATA_INCHISA = 283,
    ACOLADA_DESCHISA = 284,
    ACOLADA_INCHISA = 285,
    DOUA_PUNCTE = 286,
    VIRGULA = 287,
    PUNCT = 288,
    DEF = 289,
    CLASS = 290,
    PASS = 291,
    IN = 292,
    RANGE = 293,
    INIT = 294,
    NAME = 295,
    IDENTIFICATOR = 296,
    INTREG = 297,
    REAL = 298,
    STRING = 299,
    CARACTER = 300
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 57 "bison_parser.y" /* yacc.c:1909  */

    int intreg;
    float real;
    char sir[128];
    char caracter;

#line 107 "bison_parser.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_BISON_PARSER_TAB_H_INCLUDED  */
