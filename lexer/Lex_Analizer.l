%{
#include <stdio.h>
%}

%option noyywrap

%%
;                       { printf("SEMICOLON "); }
[ \t]+                  /* ignore whitespace */


"//".*                  { printf("COMMENT "); }
"f"                     { printf("floatdcl "); }
"i"                     { printf("intdcl "); }
"p"                     { printf("print "); }
[a-z]                   { printf("id "); }
"="                     { printf("assign "); }
"+"                     { printf("plus "); }
[0-9]+\.[0-9]+          { printf("fnum "); }
[0-9]+                  { printf("inum "); }
[a-zA-Z][a-zA-Z0-9]*    { printf("WORD "); }
\n                      { printf("\n"); }
\n  ;                   /* Ignore newline */
.   ;                   /* Ignore any other character */
%%

int main(int argc, char **argv) {
    FILE    *fd;

    if (argc == 2)
    {
        if (!(fd = fopen(argv[1], "r")))
        {
            perror("Error: ");
            return (-1);
        }
        yyset_in(fd);
        yylex();
        fclose(fd);
    }
    else
        printf("Usage: a.out filename\n");
    return (0);
}