open! List
open! Parser

let letter = [%sedlex.regexp? 'a'..'z'|'A'..'Z']
let integer = [%sedlex.regexp? '0'..'9'] 
let number = [%sedlex.regexp? Plus integer]
let float = [%sedlex.regexp? (Plus integer), '.', (Plus integer)]

let rec token buf =
  match%sedlex buf with
    | white_space -> token buf
    | float -> FLOAT(float_of_string (Sedlexing.Latin1.lexeme buf))
    | number -> INT (int_of_string (Sedlexing.Latin1.lexeme buf));
    | "if" -> IF
    | "fun" -> FUN
    | "for" -> FOR
    | "else" -> ELSE
    | "int" -> TINT 
    | "mut" -> MUT
    | "{" -> LBRACE
    | "}" -> RBRACE
    | "[" -> LBRACK
    | "]" -> RBRACK
    | "(" -> LPAREN
    | ")" -> RPAREN
    | ";" ->  SEMICOLON
    | "+" -> PLUS
    | "-" ->  MINUS
    | "*" ->  TIMES
    | "/" ->  DIV
    | eof -> EOF
    | letter, Star (letter | integer) -> token buf
    | _ -> print_string (Sedlexing.Utf8.lexeme buf); failwith "Failed to parse"

let lexer buf = 
  Sedlexing.with_tokenizer token buf