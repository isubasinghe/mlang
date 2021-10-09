open! List
open! Parser

let letter = [%sedlex.regexp? 'a'..'z'|'A'..'Z']
let hexdigit = [%sedlex.regexp? '0'..'9' | 'a'..'f' | 'A'..'F']
let unescaped_string = [%sedlex.regexp? 0x20 .. 0x21 | 0x23 .. 0x5B | 0x5D .. 0x10FFFF ]
let escaped_string = [%sedlex.regexp? "\\" , ( 0x22 | 0x5C | 0x2F | 0x62 | 0x66 | 0x6E | 0x72 | 0x74 | (0x75, Rep(hexdigit,4)) ) ]
let string_char = [%sedlex.regexp? (escaped_string | unescaped_string ) ]
let stringlit = [%sedlex.regexp?  "\"" , (Star string_char) , '"']
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
    | "==" -> EQ
    | ">=" -> GEQ
    | ">" -> GQ
    | "<=" -> LEQ
    | "<" -> LQ
    | "=" -> ASSIGN
    | "!" -> NOT
    | stringlit -> STRINGLIT (Sedlexing.Utf8.lexeme buf)
    | letter, Star (letter | integer) -> ID(Sedlexing.Latin1.lexeme buf)
    | eof -> EOF
    | _ -> print_string (Sedlexing.Utf8.lexeme buf); failwith "Failed to parse"


let print_string_nl s = 
  print_string s;
  print_string "\n"
    
let debug_token buf = 
  let tk = token buf in
  print_string_nl (Sedlexing.Utf8.lexeme buf); 
  tk
let lexer buf = 
  Sedlexing.with_tokenizer token buf
