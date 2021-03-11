open List

let letter = [%sedlex.regexp? 'a'..'z'|'A'..'Z']
let integer = [%sedlex.regexp? '0'..'9']
let float = [%sedlex.regexp? (Plus integer), '.', (Plus integer)]

let rec token buf tokens =
  
  match%sedlex buf with
    | white_space -> (); token buf tokens
    | float -> (); token buf ((Tokens.T_Float (Sedlexing.Latin1.lexeme buf)) :: tokens)
    | Plus integer -> (); token buf ((Tokens.T_Int (Sedlexing.Latin1.lexeme buf)) :: tokens)
    | "if" -> (); token buf ((Tokens.T_If)::tokens)
    | "fun" -> (); token buf ((Tokens.T_Fun)::tokens)
    | "for" -> (); token buf ((Tokens.T_For)::tokens)
    | "else" -> (); token buf ((Tokens.T_Else)::tokens)
    | "int" -> (); token buf ((Tokens.T_TInt)::tokens)
    | "{" -> (); token buf ((Tokens.T_LBrace)::tokens)
    | "}" -> (); token buf ((Tokens.T_RBrace)::tokens)
    | "[" -> (); token buf ((Tokens.T_LBrack)::tokens)
    | "]" -> (); token buf ((Tokens.T_RBrack)::tokens)
    | "(" -> (); token buf ((Tokens.T_LParan)::tokens)
    | ")" -> (); token buf ((Tokens.T_RParan)::tokens)
    | ";" -> (); token buf ((Tokens.T_SemiColon)::tokens)
    | letter, Star (letter | integer) -> (); token buf ((Tokens.T_Id (Sedlexing.Latin1.lexeme buf) )::tokens)
    | eof -> rev tokens
    | _ -> failwith "Internal failure: Reached impossible place"


let tokenize s =
  let lexbuf = Sedlexing.Utf8.from_string s in
  token lexbuf []