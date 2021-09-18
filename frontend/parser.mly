%{
    open! Core
%}
%token <int> INT
%token <float> FLOAT
%token <bool> BOOL
%token <string> ID
%token IF
%token FUN
%token FOR
%token ELSE
%token MUT
%token TINT
%token TFLOAT

%token LBRACE RBRACE
%token LBRACK RBRACK
%token LPAREN RPAREN

%token SEMICOLON
%token COLON

%token COMMA

%token LQ
%token LEQ

%token GQ 
%token GEQ

%token EQ

%token PLUS MINUS TIMES DIV
%token EOF

%token UMINUS NEG

%left PLUS MINUS        /* lowest precedence */
%left TIMES DIV         /* medium precedence */
%nonassoc UMINUS        /* highest precedence */
%nonassoc NEG

%start main             /* the entry point */
%type <int> main
%%


main:
    expr EOF                { $1 }
;
expr:
    INT                     { $1 }
  | LPAREN expr RPAREN      { $2 }
  | expr PLUS expr          { $1 + $3 }
  | expr MINUS expr         { $1 - $3 }
  | expr TIMES expr         { $1 * $3 }
  | expr DIV expr           { $1 / $3 }
  | MINUS expr %prec UMINUS { - $2 }
