%{
	#include <stdio.h> 
	#include <string.h> 
	int num, count, i; 
	char hex[20]; 
%}

HEXDIGIT [0-9a-fA-F] 

%% 

{HEXDIGIT}+ { 
		strcpy(hex, yytext);
		num = 0;
		count = strlen(hex);

		for (i = 0; i < count; ++i) {
			char digit = hex[i];
			int value;

			if (digit >= '0' && digit <= '9') {
				value = digit - '0';
			} else if (digit >= 'a' && digit <= 'f') {
				value = 10 + digit - 'a';
			} else if (digit >= 'A' && digit <= 'F') {
				value = 10 + digit - 'A';
			} else {
				printf("Invalid input: %s\n", hex);
				return 1;
			}

			num = num * 16 + value;
		}

		printf("%d", num);
	}

.|\n ECHO; 
		
%% 

int yywrap() {
    return 1;
}

int main() {
	printf("Input:");
	yylex(); 
	return 0; 
}
