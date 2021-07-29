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
  ()
let parse_file filename =
  let oc = open_in filename in
    parse_lexbuf (Sedlexing.Latin1.from_channel oc) filename

let () =
  Arg.parse speclist anon_fun usage_msg;
  match !input_files with 
  | [] -> print_string "At least one file is needed to compile\n"
  | x :: _ -> parse_file x