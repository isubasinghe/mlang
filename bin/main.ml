open! Frontend
open! MenhirLib

(* 
let () = 
  let lexbuf = Sedlexing.Utf8.from_string "2 + 3" in
    while true do
      let lexer = Sedlexing.with_tokenizer Lexer.token lexbuf in
      let parser = MenhirLib.Convert.Simplified.traditional2revised Parser.main in
      let result = parser lexer in 
        print_int result; print_newline(); flush stdout;
    done   *)
    