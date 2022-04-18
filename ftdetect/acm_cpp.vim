" Custom acm_cpp filetype, which copes cpp filetype + adds additional custom stuff
" The definition of acm_cpp filetype.

augroup AcmCppFtDetect
    autocmd!
    autocmd BufNewFile,BufRead ~/ACM/*.cpp set filetype=acm_cpp
    autocmd BufNewFile,BufRead *.acm set filetype=acm_cpp
augroup END
