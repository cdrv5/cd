%{
#include <stdio.h>
%}

DIGIT       [0-9]
LETTER      [a-zA-Z]
ID          {LETTER}({LETTER}|{DIGIT})*
NUMBER      {DIGIT}+(\.{DIGIT}+)?([eE][-+]?{DIGIT}+)?
WS          [ \t]+
COMMENT     "//".*

%%
{WS}        ; /* Ignore whitespace */
{COMMENT}   ; /* Ignore comments */
"if"        { printf("IF\n"); }
"else"      { printf("ELSE\n"); }
"while"     { printf("WHILE\n"); }
"for"       { printf("FOR\n"); }
"int"       { printf("INT\n"); }
"float"     { printf("FLOAT\n"); }
"return"    { printf("RETURN\n"); }
{ID}        { printf("ID: %s\n", yytext); }
{NUMBER}    { printf("NUMBER: %s\n", yytext); }
"+"         { printf("ADD\n"); }
"-"         { printf("SUB\n"); }
"*"         { printf("MUL\n"); }
"/"         { printf("DIV\n"); }
"="         { printf("ASSIGN\n"); }
";"         { printf("SEMICOLON\n"); }
"("         { printf("LPAREN\n"); }
")"         { printf("RPAREN\n"); }
"{"         { printf("LBRACE\n"); }
"}"         { printf("RBRACE\n"); }
","         { printf("COMMA\n"); }
">"         { printf("GT\n"); }
"<"         { printf("LT\n"); }
"=="        { printf("EQ\n"); }
"!="        { printf("NEQ\n"); }
">="        { printf("GTE\n"); }
"<="        { printf("LTE\n"); }
.           { printf("ERROR: Invalid character '%s'\n", yytext); }
%%

int main() {
    yylex();
    return 0;
}
