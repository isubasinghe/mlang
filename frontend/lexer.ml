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
    | "mut" -> MUT
    | "module" -> MODULE
    | "as" -> AS
    | "false" -> FALSE
    | "true" -> TRUE
    | "continue" -> CONTINUE
    | "break" -> BREAK
    | "enum" -> ENUM
    | "impl" -> IMPL
    | "let" -> LET
    | "loop" -> LOOP
    | "match" -> MATCH
    | "return" -> RETURN
    | "struct" -> STRUCT
    | "int" -> TINT 
    | "float" -> TFLOAT
    | "string" -> TSTRING
    | "bool" -> TBOOL
    | "{" -> LBRACE
    | "}" -> RBRACE
    | "[" -> LBRACK
    | "]" -> RBRACK
    | "(" -> LPAREN
    | ")" -> RPAREN
    | ";" ->  SEMICOLON
    | ":" -> COLON
    | "," -> COMMA
    | "->" -> RARROW
    | "<-" -> LARROW
    | "+" -> PLUS
    | "-" ->  MINUS
    | "*" ->  TIMES
    | "/" ->  DIV
    | letter, Star (letter | integer) -> ID(Sedlexing.Latin1.lexeme buf)
    | eof -> EOF
    | _ -> print_string (Sedlexing.Utf8.lexeme buf); failwith "Failed to parse"

let lexer buf = 
  Sedlexing.with_tokenizer token buf