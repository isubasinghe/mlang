# mlang
**Warning:** brain dump 


I want a simple programming language which is a cross between Go and Rust. Perhaps we could have opt in manual memory management for hot paths and have a generation garbage collector for other paths? I think sacrificing some safety is okay, as long as external static analysis tools can show the programmer any potential violations of safety. Programmers don't code in simple text editors anymore, we have language servers etc that help us, we can use this fact as a influencing factor in language design. This project is just a brain dump of what I want in a programming language . I kind of want to experiment if I could introduce a linear type system so that I have compile time knowledge of the lifetime of a given variable. I don't know how possible this would be, but I am interested in trying it out, so I am messing around with OCaml, Menhir, Sedlex and LLVM.

This is not even halfway done, I contribute here randomly, maybe during the summer break I can contribute more heavily into this. 

## Why OCaml? 
It is the language that felt "just right" for this, I actually wrote a fair amount of this project in Haskell, I didn't really like some aspects of Haskell so I did a complete 180 and went to Rust, but in Rust land, it was a bit cubersome to write compiler code. OCaml at the moment, seems exactly the right "feel" for the stuff that I am doing. 
