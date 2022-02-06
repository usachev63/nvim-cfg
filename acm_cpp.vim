" Custom acm_cpp filetype, which copes cpp filetype + adds additional custom stuff
" BufNewFile and BufRead autocommands for custom acm_cpp filetype.

function AcmCppOnNewFile() abort
    " copy everything from template.cpp file
    % !cat ~/ACM/template.cpp
    " move cursor to a good starting position
    ?__solution
    normal j$
endfunction

function AcmCppOnRead() abort
    args % in
    next
    prev
endfunction

augroup AcmCppBufTriggers
    autocmd!
    autocmd BufNewFile * if &ft ==# 'acm_cpp'| call AcmCppOnNewFile()|endif
    autocmd BufNewFile,BufRead,BufEnter * if &ft ==# 'acm_cpp'| call AcmCppOnRead()|endif
augroup END
