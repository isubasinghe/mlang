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
  | Fun of id * expr
  [@@deriving show, eq, sexp, yojson { strict = true }]

type gtypedef = 
  | StringGType
  | BoolGType
  | F64GType
  | IntGType
  | RecordGType of (string * gtypedef) list
  [@@deriving show, eq, sexp, yojson { strict = true }]

type definition =
  | TypeAlias of string * string
  [@@deriving show, eq, sexp, yojson { strict = true }]

type paramtype = 
  | StringType of (muttype * string)
  | BoolType of (muttype * string)
  | F64Type of (muttype * string)
  | IntType of (muttype * string)
  | RecordType of (muttype * string * string)
  | GenericType of (muttype * string) * (string list)
  [@@deriving show, eq, sexp, yojson { strict = true }]

type defunc = 
  | Function of string
  [@@deriving show, eq, sexp, yojson { strict = true }]

type program = 
  | Program of (definition list) * (defunc list)
  [@@deriving show, eq, sexp, yojson { strict = true }]
