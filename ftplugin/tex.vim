setlocal spelllang=en,ru
setlocal spell

setlocal softtabstop=1
setlocal shiftwidth=1

setlocal nonumber

inoremap <C-f> <Esc>: silent exec '.!~/.local/bin/inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!~/.local/bin/inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
