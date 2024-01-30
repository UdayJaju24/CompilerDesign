%{
#include <stdio.h>
%}

lower [a-z]
upper [A-Z]
comment "\/\*"[^]*"\*\/"

%%
{upper} { printf("%c", yytext[0] + 32); }
{lower} { printf("%c", yytext[0] - 32); }
[\t\n]+  { printf("%s", yytext); }
.        { printf("%c", yytext[0]); }

%%
int yywrap() {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}
