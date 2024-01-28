
%{
#include<stdio.h>
int sc=0,wc=0,lc=0,cc=0;
%}

%%
[\n] { lc++; cc+=yyleng;}
[  \t] { sc++; cc+=yyleng;}
[^\t\n ]+ { wc++;  cc+=yyleng;}
%%

int main(int argc ,char* argv[ ])
{
    	yyin= fopen("2.txt.txt","r");
	yylex();
	printf("The number of lines=%d,spaces=%d,words=%d,characters =%d",wc,sc,lc,cc);
	
}

int yywrap( )
{
	return 1;
}
