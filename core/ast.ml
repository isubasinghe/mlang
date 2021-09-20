type id = string [@@deriving show, eq, sexp, yojson { strict = true }]

type muttype = 
  | ConstType
  | MutType
  [@@deriving show, eq, sexp, yojson { strict = true }]

type constant = 
  | BoolConst of bool
  | IntConst of int
  | StringConst of string
  | F64Const of float
  [@@deriving show, eq, sexp, yojson { strict = true }]

type uop = 
  | Not
  | Neg
  [@@deriving show, eq, sexp, yojson { strict = true }]

type binop = 
  | Add
  | Sub
  | Mult
  | Div
  | Mod 
  | Or
  | Eq 
  | Neq
  | Lt 
  | Ltq 
  | Gt 
  | Gtq 
  [@@deriving show, eq, sexp, yojson { strict = true }]

type expr = 
  | UOp of uop * expr
  | BinOp of binop * expr * expr
  | Constant of constant
  | Var of id
  | FuncCall of id * (expr list)
  [@@deriving show, eq, sexp, yojson { strict = true }]

type rtypedef = 
  | StringGType
  | BoolGType
  | F64GType
  | IntGType
  | RecordGType of (string * rtypedef) list
  [@@deriving show, eq, sexp, yojson { strict = true }]

type paramtype = 
  | StringParamType of (muttype * string)
  | BoolParamType of (muttype * string)
  | F64ParamType of (muttype * string)
  | IntParamType of (muttype * string)
  | RecordParamType of (muttype * string * string)
  [@@deriving show, eq, sexp, yojson { strict = true }]

type returntype = 
  | StringType
  | BoolType
  | F64Type
  | IntType
  | RecordType of string
  [@@deriving show, eq, sexp, yojson { strict = true }]

type params = Params of paramtype list

type definition  = 
  | Function of string * (paramtype list) * (returntype option)
  | RecordDef of rtypedef
  [@@deriving show, eq, sexp, yojson { strict = true }]

type moduledefn = 
  | Module of string * (definition list)
  [@@deriving show, eq, sexp, yojson { strict = true }]

type program = 
  | Program of (string * moduledefn) list
  [@@deriving show, eq, sexp, yojson { strict = true }]
