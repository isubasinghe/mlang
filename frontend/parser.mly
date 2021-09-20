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
%token MODULE
%token AS
%token FALSE
%token TRUE
%token CONTINUE
%token BREAK
%token ENUM
%token IMPL
%token LET
%token LOOP
%token MATCH
%token RETURN
%token STRUCT

%token TINT
%token TFLOAT
%token TSTRING
%token TBOOL
%token TRECORD

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
%type <Core.Ast.returntype> rettype
%type <Core.ASt.muttype> mtype
%%

rettype:
  TINT                        { Core.Ast.IntType }
  | TFLOAT                    { Core.Ast.F64Type }
  | TSTRING                   { Core.Ast.StringType }
  | TBOOL                     { Core.Ast.BoolType }
  | ID                        { Core.Ast.RecordType ($1) }
;

mtype:
  MUT                        { Core.Ast.MutType } 
  |                          { Core.Ast.ConstType }
;

ptype:
  ID COLON mtype TINT               { Core.Ast.IntParamType($3, $1) }
  | ID COLON mtype TFLOAT           { Core.Ast.F64ParamType($3,$1) }
  | ID COLON mtype TSTRING          { Core.Ast.StringParamType($3, $1) }
  | ID COLON mtype TBOOL            { Core.Ast.BoolParamType($3,$1) }
  | ID COLON mtype ID               { Core.Ast.RecordParamType($3,$1,$4) }
;


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
