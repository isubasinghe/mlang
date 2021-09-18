open! Frontend
open! MenhirLib
let usage_msg = "mcc [-verbose] <file1> [<file2>] ... -o <output>"
let verbose = ref false
let input_files = ref []
let output_file = ref ""

let anon_fun filename =
  input_files := filename::!input_files

  let speclist =
    [("-verbose", Arg.Set verbose, "Output debug information");
    ("-o", Arg.Set_string output_file, "Set output file name")]

let parse_lexbuf lexbuf filename =
  Sedlexing.set_filename lexbuf filename;
  Frontend.Lexer.token lexbuf
let parse_file filename =
  let oc = open_in filename in 
  let lexbuf = Sedlexing.Utf8.from_channel oc in
  let lexer = Sedlexing.with_tokenizer Lexer.token lexbuf in
  let parser = MenhirLib.Convert.Simplified.traditional2revised Parser.main in
  let result = parser lexer in
  print_int result;
  flush stdout

let () =
  Arg.parse speclist anon_fun usage_msg;
  match !input_files with 
  | [] -> print_string "At least one file is needed to compile\n"
  | x :: _ -> parse_file x