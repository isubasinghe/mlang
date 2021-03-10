open List

let letter = [%sedlex.regexp? 'a'..'z'|'A'..'Z']
let integer = [%sedlex.regexp? '0'..'9']

let rec token buf tokens =
  match%sedlex buf with
    | white_space -> (); token buf tokens
    | Plus integer -> (); token buf ((Tokens.T_Int (Sedlexing.Latin1.lexeme buf)) :: tokens)
    | letter, Star (letter, integer) -> (); token buf ((Tokens.T_Id (Sedlexing.Latin1.lexeme buf) )::tokens)
    | eof -> rev tokens
    | _ -> failwith "Internal failure: Reached impossible place"


let tokenize s =
  let lexbuf = Sedlexing.Utf8.from_string s in
  token lexbuf []