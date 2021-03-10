type id = string

type constant = 
  | Bool of bool
  | Int of int
  | Nil

type uop = 
  | Not

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

type expr = 
  | UOp of uop * expr
  | BinOp of binop * expr * expr
  | Constant of constant
  | Var of id
  | Fun of id * expr


