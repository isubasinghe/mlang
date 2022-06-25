extern crate cfgrammar;
extern crate lrlex;
extern crate lrpar;

mod asts;
mod lowerings;

use std::io::{self, BufRead, Write};
use lrlex::{lrlex_mod, DefaultLexeme};
use lrpar::{lrpar_mod, NonStreamingLexer};

lrlex_mod!("parser/lex.l");
lrpar_mod!("parser/grammar.y");


fn main() {
    let lexerdef = lex_l::lexerdef();
    let stdin = io::stdin();
    loop {
        print!(">>> ");
        io::stdout().flush().ok();
        match stdin.lock().lines().next() {
            Some(Ok(ref l)) => {

            }, 
            _ => break
        }
    }
}
