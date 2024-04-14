%{
#include <stdio.h>
%}

DIGIT [0-9]

%%
{DIGIT}+ {
    int num = atoi(yytext);
    if (num > 0) {
        printf("%s is positive\n", yytext);
    } else if (num < 0) {
        printf("%s is negative\n", yytext);
    } else {
        printf("%s is zero\n", yytext);
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
flex postive.l
gcc lex.yy.c -o postive -lfl
./postive
*/
