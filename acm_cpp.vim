" this function is called when a new cpp file is created in nvim inside ~/ACM directory
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

augroup AcmCpp
    autocmd!

    " actually define acm_cpp filetype
    autocmd BufNewFile,BufRead ~/ACM/*.cpp set filetype=acm_cpp

    autocmd BufNewFile * if &ft ==# 'acm_cpp'| call AcmCppOnNewFile()|endif
    autocmd BufNewFile,BufRead * if &ft ==# 'acm_cpp'| call AcmCppOnRead()|endif

    autocmd filetype acm_cpp set autowriteall     " autowrite always

    " maps
    " compile and run
    autocmd filetype acm_cpp nnoremap <F10> :first<CR>:w <bar> terminal acm % -o %:r && ./%:r<CR>
    " only run
    autocmd filetype acm_cpp nnoremap <F9> :first<CR>:terminal ./%:r<CR>
augroup END
