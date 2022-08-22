%token   INTEGER VARIABLE SIN COS TAN FIB POW PI
%left    '+' '-'
%left    '*' '/' '%' ','
%left    '&' '|' '^' '>' '<'
%right   '#''~'
%left    '!'

%{

/*for Visual studio */
/*  #define  __STDC__   0   */   
    #include <stdio.h>   
    #include <math.h>
    #define YYSTYPE double
    #define pi 3.1415926 
    void yyerror(char*);
    int yylex(void);

    double sym[26];
%}

%%
program:
    program statement '\n'
    |
    ;
statement:
     expr    {printf("%lf\n", $1);}
     |VARIABLE '=' expr    {sym[(int)$1] = $3;}
     ;
expr:
    INTEGER
    |VARIABLE{$$ = sym[(int)$1];}
    |expr '+' expr    {$$ = $1 + $3;}
    |expr '-' expr    {$$ = $1 - $3;}
    |expr '*' expr    {$$ = $1 * $3;}
    |expr '/' expr    {$$ = $1 / $3;}
    |expr '%' expr    {$$ = (int)$1 % (int)$3;}
    |expr '&' expr    {$$ = (int)$1 & (int)$3;}
    |expr '|' expr    {$$ = (int)$1 | (int)$3;}
    |expr '^' expr    {$$ = (int)$1 ^ (int)$3;}
    |expr '>' expr    {$$ = $1 > $3;}
    |expr '<' expr    {$$ = $1 < $3;}
    |'~' expr         {$$ = ~(int)$2;}
    |'#' expr         {$$ = sqrt($2);}
    |expr '#' expr    {$$ = $1*sqrt($3);}
    |expr '!'         {int i=1,s=1;for(;i<=$2;i++)s*=i;$$=s;}
    |'('expr')'       {$$ = $2;}
    |PI {$$ = pi;}
    |SIN'('expr')'       {$$ = sin($3*pi/180.0);}
    |COS'('expr')'       {$$ = cos($3*pi/180.0);}
    |TAN'('expr')'       {$$ = tan($3*pi/180.0);}
    |POW'('expr','expr')'{
         $$ = pow($3,$5);
    }
    |FIB'('expr')'	 {
		long long tar = $3,ans=0,la=1,lla=0;
		for(long long i=1;i<=tar;++i){
			ans=lla+la;
			lla=la;
			la=ans;
		}
		$$ = ans;
	}
    ;

%%

void yyerror(char* s)
{
    fprintf(stderr, "%s\n", s);
}

int main(void)
{
    printf("A simple calculator.\n");
    yyparse();
    return 0;
}