open Frontend

let rec print_list = function 
  [] -> ()
  | e::l -> print_string (Tokens.show_token e); print_string " "; print_list l

let main () = print_list (Parser.tokenize "12 hello123")

let () = main ()