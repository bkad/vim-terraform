" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" basically the JSON indent pattern
setlocal cindent
setlocal cinoptions+=j1,J1
setlocal cinkeys=0{,0},o,O

let b:undo_indent = "setl cin<"

" override the tf.vim indent file
set indentexpr=
set indentkeys=0{,0},o,O
