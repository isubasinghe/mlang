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
  | StringType of (muttype * string)
  | BoolType of (muttype * string)
  | F64Type of (muttype * string)
  | IntType of (muttype * string)
  | RecordType of (muttype * string)
  | GenericType of (muttype * string) * (string list)
  [@@deriving show, eq, sexp, yojson { strict = true }]

type returntype = 
  | StringType
  | BoolType
  | F64Type
  | IntType
  | RecordType of string
  | GenericType
  [@@deriving show, eq, sexp, yojson { strict = true }]


type param = Param of (paramtype * string) [@@deriving show, eq, sexp, yojson { strict = true }]

type definition  = 
  | Function of string * (param list) * (returntype option)
  | RecordDef of rtypedef
  [@@deriving show, eq, sexp, yojson { strict = true }]

type moduledefn = 
  | Module of string * (definition list)
  [@@deriving show, eq, sexp, yojson { strict = true }]

type program = 
  | Program of (string * moduledefn) list
  [@@deriving show, eq, sexp, yojson { strict = true }]
