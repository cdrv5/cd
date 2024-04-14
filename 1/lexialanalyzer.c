#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define MAX_INPUT_LENGTH 100
#define MAX_TOKEN_LENGTH 100

typedef enum {
    TOKEN_IDENTIFIER,
    TOKEN_NUMBER,
    TOKEN_OPERATOR,
    TOKEN_UNKNOWN,
    TOKEN_END
} TokenType;

typedef struct {
    TokenType type;
    char value[MAX_TOKEN_LENGTH];
} Token;

int isOperator(char c) {
    return c == '+' || c == '-' || c == '*' || c == '/';
}

int isWhitespace(char c) {
    return c == ' ' || c == '\t' || c == '\n';
}

Token getNextToken(char *input, int *index) {
    Token token;
    char c;
    int i = *index;
    int token_index = 0;

    while ((c = input[i]) != '\0') {
        if (isalpha(c)) {
            token.type = TOKEN_IDENTIFIER;
            token.value[token_index++] = c;
            while (isalnum(input[++i]) || input[i] == '_') {
                token.value[token_index++] = input[i];
            }
            break;
        } else if (isdigit(c)) {
            token.type = TOKEN_NUMBER;
            token.value[token_index++] = c;
            while (isdigit(input[++i])) {
                token.value[token_index++] = input[i];
            }
            break;
        } else if (isOperator(c)) {
            token.type = TOKEN_OPERATOR;
            token.value[token_index++] = c;
            break;
        } else if (isWhitespace(c)) {
            i++;
            continue;
        } else {
            token.type = TOKEN_UNKNOWN;
            token.value[token_index++] = c;
            i++;
            break;
        }
    }

    token.value[token_index] = '\0';
    *index = i;
    return token;
}

int main() {
    char input[MAX_INPUT_LENGTH];
    printf("Enter an expression: ");
    fgets(input, MAX_INPUT_LENGTH, stdin);

    int index = 0;
    Token token;
    do {
        token = getNextToken(input, &index);
        if (token.type != TOKEN_UNKNOWN && token.type != TOKEN_END) {
            switch (token.type) {
                case TOKEN_IDENTIFIER:
                    printf("Identifier: %s\n", token.value);
                    break;
                case TOKEN_NUMBER:
                    printf("Number: %s\n", token.value);
                    break;
                case TOKEN_OPERATOR:
                    printf("Operator: %s\n", token.value);
                    break;
                default:
                    break;
            }
        } else if (token.type == TOKEN_UNKNOWN) {
            printf("Unknown token: %s\n", token.value);
        }
    } while (token.type != TOKEN_UNKNOWN && token.type != TOKEN_END);

    return 0;
}