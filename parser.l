%{
#include <stdio.h>
%}

%%
[0-9]+      { printf("\nNUMBER: %s\n", yytext); }
"+"         { printf("\nADD\n", yytext); }
"-"         { printf("\nSUBTRACT\n", yytext); }
"*"         { printf("\nMULTIPLY\n", yytext); }
"/"         { printf("\nDIVIDE\n", yytext); }
"("         { printf("\nLPAREN\n", yytext); }
")"         { printf("\nRPAREN\n", yytext); }
[ \t\n]     ; // Ignore whitespace and newline characters
.           { printf("\nERROR: Invalid character: %s\n", yytext); }

%%
int yywrap(void){}

int main() {
    yylex();
    return 0;
}
