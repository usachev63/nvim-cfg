" Custom acm_cpp filetype, which copes cpp filetype + adds additional custom stuff

" Only do this when not done yet for this buffer
if exists("b:current_syntax")
  finish
endif

runtime! syntax/cpp.vim

" remove highlighting in red for lambda expression
highlight link cParenError NONE
highlight link cErrInParen NONE
highlight link cErrinBracket NONE

set filetype=acm_cpp
