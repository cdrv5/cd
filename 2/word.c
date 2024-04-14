#include <stdio.h>

int word_count = 0;

extern int yylex();

int main() {
    printf("Enter a sentence: ");
    word_count = yylex();
    printf("Number of words: %d\n", word_count);
    return 0;
}
/*
flex word.l
gcc lex.yy.c word.c -o word -lfl
./word
*/