" map <buffer> = <Plug>(operator-clang-format)

" let g:clang_format#auto_format = 1
" let g:clang_format#auto_formatexpr = 1
" let g:clang_format#style_options = {
"             \ "ColumnLimit" : 80,}
" let g:clang_format#command = "clang-format-14"

setlocal softtabstop=2
setlocal shiftwidth=2

" ClangFormatAutoEnable

" Switching between source and header files
nnoremap <localleader>fs :ClangdSwitchSourceHeader<CR>

" Fix comment string for vim-commentary
setlocal commentstring=//\ %s
