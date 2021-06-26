open! List
open! Parser

let letter = [%sedlex.regexp? 'a'..'z'|'A'..'Z']
let integer = [%sedlex.regexp? '0'..'9']
let float = [%sedlex.regexp? (Plus integer), '.', (Plus integer)]

let rec token buf =
  match%sedlex buf with
    | white_space -> (); token buf
    | float -> (); FLOAT(float_of_string (Sedlexing.Latin1.lexeme buf))
    | Plus integer -> (); INT (int_of_string (Sedlexing.Latin1.lexeme buf))
    | "if" -> (); token buf
    | "fun" -> (); token buf
    | "for" -> (); token buf
    | "else" -> (); token buf
    | "int" -> (); token buf 
    | "{" -> (); token buf
    | "}" -> (); token buf
    | "[" -> (); token buf
    | "]" -> (); token buf
    | "(" -> (); token buf
    | ")" -> (); token buf
    | ";" -> (); token buf
    | "+" -> (); PLUS
    | "-" -> (); MINUS
    | "*" -> (); TIMES
    | "/" -> (); DIV
    | letter, Star (letter | integer) -> (); token buf
    | _ -> failwith "Internal failure: Reached impossible place"