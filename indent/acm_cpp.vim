" Custom acm_cpp filetype, which copes cpp filetype + adds additional custom stuff

" Only do this when not done yet for this buffer
if exists("b:did_indent")
  finish
endif

runtime! indent/cpp.vim

setlocal cindent cino=j1,(0,ws,Ws

set filetype=acm_cpp
