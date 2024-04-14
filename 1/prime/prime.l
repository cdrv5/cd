%{
#include <stdio.h>
#include <stdbool.h>
%}

DIGIT [0-9]

%%
{DIGIT}+ {
    int num = atoi(yytext);
    bool isPrime = true;

    if (num <= 1) {
        isPrime = false;
    } else {
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                isPrime = false;
                break;
            }
        }
    }

    if (isPrime) {
        printf("%s is prime\n", yytext);
    } else {
        printf("%s is not prime\n", yytext);
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
flex prime.l
gcc lex.yy.c -o prime -lfl
./prime
*/
