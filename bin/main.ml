open Frontend

let rec print_list = function 
  [] -> ()
  | e::l -> print_string (Tokens.show_token e); print_string " "; print_list l

let main () = print_list (Lexer.tokenize "fun hello() { if () {} else {} }")

let () = main ()