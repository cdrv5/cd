%{
#include <stdio.h>
%}

DIGIT [0-9]

%%
{DIGIT}+ {
    int num = atoi(yytext);
    if (num % 2 == 0) {
        printf("%s is even\n", yytext);
    } else {
        printf("%s is odd\n", yytext);
    }
}
.|\n    ;

%%
int main() {
    yylex();
    return 0;
}
/*
to run program
flex evenodd.l
gcc lex.yy.c -o evenodd -lfl
./evenodd
*/
