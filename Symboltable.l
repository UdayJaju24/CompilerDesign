%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS 100

// Structure to store variable information
typedef struct {
    char name[50];
    char type[20];
    int memory;
} Symbol;

Symbol symbol_table[MAX_SYMBOLS]; // Symbol table
int symbol_count = 0;             // Number of symbols in the table

// Function to check if a symbol already exists in the symbol table
int symbol_exists(char *name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return 1; // Symbol found
        }
    }
    return 0; // Symbol not found
}

// Function to add a new symbol to the symbol table
void add_symbol(char *name, char *type, int memory) {
    if (symbol_count < MAX_SYMBOLS) {
        strcpy(symbol_table[symbol_count].name, name);
        strcpy(symbol_table[symbol_count].type, type);
        symbol_table[symbol_count].memory = memory;
        symbol_count++;
    } else {
        printf("Error: Symbol table overflow\n");
        exit(1);
    }
}

// Function to print the symbol table in tabular form
void print_symbol_table() {
    printf("Symbol Table:\n");
    printf("----------------------------------------------------\n");
    printf("| %-10s | %-10s | %-10s |\n", "Name", "Type", "Memory");
    printf("----------------------------------------------------\n");
    for (int i = 0; i < symbol_count; i++) {
        printf("| %-10s | %-10s | %-10d |\n", symbol_table[i].name, symbol_table[i].type, symbol_table[i].memory);
    }
    printf("----------------------------------------------------\n");
}
%}

DIGIT [0-9]
LETTER [a-zA-Z]
ID {LETTER}({LETTER}|{DIGIT})*

%%

"int"|"float"|"char"|"void" {
    char type[20];
    strcpy(type, yytext);
    printf("Type: %s\n", type);
}

{ID} {
    char name[50];
    strcpy(name, yytext);
    if (!symbol_exists(name)) {
        add_symbol(name, "int", 4); // Assuming all identifiers are integers with 4 bytes of memory
    }
    printf("Identifier: %s\n", name);
}

[ \t\n] ; // Ignore whitespace characters

. { printf("Unknown: %s\n", yytext); }

%%

int yywrap() {
    return 1; // Indicate end of input
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *yyin = fopen(argv[1], "r"); // Open the input file
    if (!yyin) {
        fprintf(stderr, "Error: Cannot open file %s\n", argv[1]);
        return 1;
    }

    yyin = fopen(argv[1], "r"); // Reopen the input file for lex to read
    yylex(); // Begin lexical analysis
    print_symbol_table(); // Print the symbol table
    fclose(yyin);
    return 0;
}
