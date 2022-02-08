" Custom acm_cpp filetype, which copes cpp filetype + adds additional custom stuff
" BufNewFile and BufRead autocommands for custom acm_cpp filetype.

function AcmCppOnNewFile() abort
    " copy everything from template.cpp file
    % !cat ~/ACM/template.cpp
    " move cursor to a good starting position
    ?__solution
    normal j$
endfunction

function AcmCppOnEnter() abort
    %argdelete
    argadd % in

    " maps
    " compile and run
    nnoremap <F10> :argdo write<CR><CR>:first<CR>:terminal acm % -o %:r && ./%:r < in<CR>
    " only run
    nnoremap <F9> :argdo write<CR><CR>:first<CR>:terminal ./%:r < in<CR>

endfunction

function AcmCppPyOnEnter() abort
    nnoremap <F10> :write <bar> :terminal python3 %<CR>
    nnoremap <F9> :write <bar> :terminal python3 %<CR>
endfunction

augroup AcmCppBufTriggers
    autocmd!
    autocmd BufNewFile * if &ft ==# 'acm_cpp'| call AcmCppOnNewFile()|endif
    autocmd BufNewFile,BufRead,BufEnter * if &ft ==# 'acm_cpp'| call AcmCppOnEnter()|endif
    autocmd BufNewFile,BufRead,BufEnter ~/ACM/*.py call AcmCppPyOnEnter()
augroup END
