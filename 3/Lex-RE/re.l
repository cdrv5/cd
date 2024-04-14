%{
# include <stdio.h>
%}

%option noyywrap

%%

[ab]       { printf("CHARACTER: %c\n", yytext[0]); }
[()|*+]    { printf("OPERATOR: %c\n", yytext[0]); }
\\.        { printf("ESCAPE: %s\n", yytext); }

[\t\n]     ; /* Skip whitespace and newline */

.          { printf("INVALID: %c\n", yytext[0]); }

%%

int main() {
    yylex();
    return 0;
}
/*
flex re.l
gcc lex.yy.c -o re -lfl
*/