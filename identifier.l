digit [0-9]
letter [A-Za-z]
%{
int count;
%}
%%
{letter}({letter}|{digit})* {count++; }
%%
int main() {
yylex();
printf("Number of identifiers = %d", count);
return 0;
}
int yywrap(){
return 1;
}
