%{
    /*
     *  一個簡單計算器的Lex詞法檔案
     */
    int yywrap();
    #define YYSTYPE double
    void yyerror(char*);
    #include "a.tab.h"
%}

%%

    /*16進位制數*/

0x[a-f0-9]+ {
		char * tmp = yytext;
		long long v=0;
		for(int i=2;i<yyleng;++i){
			v*=16;
			if(tmp[i]>='a'){
				v+=tmp[i]-'a'+10;
			}
			else{
				v+=tmp[i]-'0';
			}
		}
		yylval = v;
            return INTEGER;
        }

    /* 整數或者小數 */
\.?[0-9]+|[0-9]+\.[0-9]*    {
            yylval = atof(yytext);
            return INTEGER;
        }

    /* 運算子 */
[-+()=/*&%|~!^#,><\n]  {return *yytext;}


    /* 三角函式 */
sin {
    return SIN;
    }

cos {
    return COS;
    }
tan {
    return TAN;
    }
pow {
     return POW;
    }
fib {
    return FIB;
    }
pi {
	return PI;
}
    /* 空白被忽略 */


     /* a-z為變數 */   
[a-z]+   {
		char * tmp = yytext;
		int id=0;
		for(int i=0;i<yyleng;++i){
			id*=26;
			id+=tmp[i]-'a';
		}
		yylval = id;
            //yylval = *yytext - 'a';
            return VARIABLE;
        }


[ \t]    ;

    /* 其他字元都是非法的 */
.    yyerror("無效的輸入字元");

%%
int yywrap()
{return 1;}