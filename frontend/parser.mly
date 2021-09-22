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

%token RARROW
%token LARROW

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

%start pmoduledefn             /* the entry point */
%type <int> main
%type <Ast.returntype> preturntype
%type <Ast.muttype> pmuttype
%type <Ast.paramtype> pparamtype
%type <Ast.params> pparams
%type <Ast.definition> pdefinition
%type <Ast.moduledefn> pmoduledefn
%%

pconstant:
  FALSE                       { Ast.BoolConst false }
  | TRUE                      { Ast.BoolConst true  }
  | INT                       { Ast.IntConst $1     }
  | FLOAT                     { Ast.F64Const $1     }
;


pexpression:
  | pconstant                 { Ast.Constant $1 }

pstatement:
  LET ID COLON preturntype EQ  pexpression    { Ast.ConstBinding ($2, $4, $6) }
;


preturntype:
  TINT                        { Ast.IntType }
  | TFLOAT                    { Ast.F64Type }
  | TSTRING                   { Ast.StringType }
  | TBOOL                     { Ast.BoolType }
  | ID                        { Ast.RecordType ($1) }
;

pmuttype:
  MUT                        { Ast.MutType } 
  |                          { Ast.ConstType }
;

pparamtype:
  ID COLON   pmuttype TINT             { Ast.IntParamType($3, $1) }
  | ID COLON pmuttype TFLOAT           { Ast.F64ParamType($3,$1) }
  | ID COLON pmuttype TSTRING          { Ast.StringParamType($3, $1) }
  | ID COLON pmuttype TBOOL            { Ast.BoolParamType($3,$1) }
  | ID COLON pmuttype ID               { Ast.RecordParamType($3,$1,$4) }
;

pparams:
  | LPAREN separated_list(COMMA, pparamtype) RPAREN { Ast.Params $2 } 
;


pdefinition:
  FUN ID pparams RARROW preturntype LBRACE list(pstatement) RBRACE          { Ast.Function($2, $3, $7, Some $5) }
  | FUN ID pparams LBRACE list(pstatement) RBRACE                           { Ast.Function($2, $3, $5, None)    }
;

pmoduledefn:
  MODULE ID SEMICOLON list(pdefinition)  EOF { Ast.Module($2, $4) }
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
