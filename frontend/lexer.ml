open List
open Parser
let letter = [%sedlex.regexp? 'a'..'z'|'A'..'Z']
let integer = [%sedlex.regexp? '0'..'9']
let float = [%sedlex.regexp? (Plus integer), '.', (Plus integer)]

let rec token buf tokens =
  
  match%sedlex buf with
    | white_space -> (); token buf tokens
    | float -> (); token buf (FLOAT (float_of_string (Sedlexing.Latin1.lexeme buf))::tokens)
    | Plus integer -> (); token buf (INT (int_of_string (Sedlexing.Latin1.lexeme buf))::tokens)
    | "if" -> (); token buf tokens
    | "fun" -> (); token buf tokens
    | "for" -> (); token buf tokens
    | "else" -> (); token buf tokens
    | "int" -> (); token buf tokens
    | "{" -> (); token buf tokens
    | "}" -> (); token buf tokens
    | "[" -> (); token buf tokens
    | "]" -> (); token buf tokens
    | "(" -> (); token buf tokens
    | ")" -> (); token buf tokens
    | ";" -> (); token buf tokens
    | letter, Star (letter | integer) -> (); token buf tokens
    | eof -> rev tokens
    | _ -> failwith "Internal failure: Reached impossible place"

let tokenize s =
  let lexbuf = Sedlexing.Utf8.from_string s in
  token lexbuf []