function PythonOnEnter() abort
    nnoremap <F10> :write <bar> :terminal python3 %<CR>
    nnoremap <F9> :write <bar> :terminal python3 %<CR>
endfunction

augroup PythonOnEnterMap
    autocmd BufNewFile,BufRead,BufEnter *.py call PythonOnEnter()
augroup END
