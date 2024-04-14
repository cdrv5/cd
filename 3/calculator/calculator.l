%{
#include <stdio.h>
#include <stdlib.h>
int yylval;
%}

DIGIT [0-9]

%%
{DIGIT}+      { yylval = atoi(yytext); return 'NUMBER'; }
[-+*/]       { return *yytext; }
\n           { return '\n'; }
[ \t]        ;  /* ignore whitespace */
.            { fprintf(stderr, "Invalid character: %s\n", yytext); }
%%

int main() {
    int total = 0;
    int current_number = 0;
    int operator = '+';
    int new_operator = 1;  // Flag to indicate the need for a new operator

    while (1) {
        int token = yylex();
        if (token == '\n' || token == EOF) {
            break;
        }

        if (token == 'NUMBER') {
            if (new_operator) {
                current_number = yylval;
                new_operator = 0;
            } else {
                fprintf(stderr, "Error: Unexpected NUMBER without operator\n");
                exit(EXIT_FAILURE);
            }
        } else {
            switch (operator) {
                case '+': total += current_number; break;
                case '-': total -= current_number; break;
                case '*': total *= current_number; break;
                case '/':
                    if (current_number != 0) {
                        total /= current_number;
                    } else {
                        fprintf(stderr, "Error: Division by zero\n");
                        exit(EXIT_FAILURE);
                    }
                    break;
            }
            current_number = 0;
            operator = token;
            new_operator = 1;  // Set flag for the next iteration
        }
    }

    // Update the total for the last operation
    switch (operator) {
        case '+': total += current_number; break;
        case '-': total -= current_number; break;
        case '*': total *= current_number; break;
        case '/':
            if (current_number != 0) {
                total /= current_number;
            } else {
                fprintf(stderr, "Error: Division by zero\n");
                exit(EXIT_FAILURE);
            }
            break;
    }

    printf("Result: %d\n", total);

    return 0;
}
/*
flex calculator.l
gcc lex.yy.c -o calculator -lfl
./calculator

*/
