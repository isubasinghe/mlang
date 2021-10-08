open! Core.Ast

type jstypes = Number | Bool | String



type environment = Environment of (string, jstypes) Hashtbl.t

type functionenv = FEnvironment of (string, jstypes) Hashtbl.t

let run_typechecker (ast:moduledefn):bool =
  match ast with 
    | Module (_name, _defs) -> false 