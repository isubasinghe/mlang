open! Core.Ast


let emit_const (_co: constant) = ()

let get_reg (regnum: int ref): int = !regnum

let new_reg(regnum: int ref): int = 
  let curr = !regnum in
  regnum := curr + 1;
  curr



let run_emitter (ast:moduledefn):bool =
  let _regnum = ref 0 in
  match ast with 
    | Module (_name, _defs) -> false 