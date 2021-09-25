open! Core.Ast


let run_typechecker (ast:moduledefn):bool =
  match ast with 
    | Module (_name, _defs) -> false 