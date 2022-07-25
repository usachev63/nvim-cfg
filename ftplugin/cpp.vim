map <buffer> = <Plug>(operator-clang-format)

let g:clang_format#auto_format = 1
let g:clang_format#auto_formatexpr = 1
let g:clang_format#style_options = {
            \ "ColumnLimit" : 80,}

" ClangFormatAutoEnable

" Switching between source and header files (vim-fswitch)
nnoremap <localleader>fs :FSHere<CR>
