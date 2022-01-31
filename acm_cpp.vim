" this function is called when a new cpp file is created in nvim inside ~/ACM directory
function AcmCppOnNewFile() abort
    " copy everything from template.cpp file
    % !cat ~/ACM/template.cpp 
    " move cursor to a good starting position
    norm 101$zz
endfunction

function AcmCppOnRead() abort
    args % in
    next
    prev
endfunction

augroup AcmCpp
    autocmd!

    " actually define acm_cpp filetype
    autocmd BufNewFile,BufRead ~/ACM/*.cpp set filetype=acm_cpp
    autocmd filetype acm_cpp set autowrite
    autocmd BufNewFile * if &ft ==# 'acm_cpp'| call AcmCppOnNewFile()|endif
    autocmd BufNewFile,BufRead * if &ft ==# 'acm_cpp'| call AcmCppOnRead()|endif

    " compile and run
    autocmd filetype acm_cpp nnoremap <F10> :w <bar> !acm % -o %:r && ./%:r <CR>
    " only run
    autocmd filetype acm_cpp nnoremap <F9> :!./%:r <CR>
augroup END
