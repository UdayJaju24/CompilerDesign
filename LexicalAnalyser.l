%{
#include <stdio.h>
%}

%%
"int"|"char"|"float"|"double"|"void"      { printf("<KEYWORD>: %s\n", yytext); }
"if"|"else"|"while"|"for"|"do"|"switch"   { printf("<CONTROL>: %s\n", yytext); }
"return"                                   { printf("<RETURN>: %s\n", yytext); }
"scanf"|"printf"                           { printf("<IOFUNC>: %s\n", yytext); }
"main"                                     { printf("<MAIN>: %s\n", yytext); }
[_a-zA-Z][_a-zA-Z0-9]*                     { printf("<IDENTIFIER>: %s\n", yytext); }
[0-9]+('.'[0-9]+)?([eE][+-]?[0-9]+)?       { printf("<CONSTANT>: %s\n", yytext); }
"=="|"!="|"<="|">="|"<"|">"|"&&"|"||"|"!"  { printf("<OPERATOR>: %s\n", yytext); }
"="|"+"|"-"|"*"|"/"|"++"|"--"|"%"|"+="|"-="|"*="|"/="|"%="  { printf("<OPERATOR>: %s\n", yytext); }
"(" | ")" | "[" | "]" | "{" | "}" | "," | ";"   { printf("<PUNCTUATION>: %s\n", yytext); }
"//"(.)*"\n"                               ; /* Single-line comment */
"/*"([^*]|[*]+[^*/])*"*/"                  ; /* Multi-line comment */
[ \t\n]                                    ; /* Ignore whitespace */

%%

int yywrap() {
    return 1;  // Indicate end of input
}

int main() {
    printf("Enter your C program:\n");
    yylex();
    return 0;
}
 
