" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'
" let g:vimtex_view_general_viewer = 'zathura'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : '',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'hooks' : [],
            \ 'options' : [
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \   '-shell-escape',
            \ ],
            \}

" compile subfiles as local main by default
let g:vimtex_subfile_start_local=1

" disable quickfix
let g:vimtex_quickfix_mode=0
" fix indentation
let g:vimtex_indent_on_ampersands=0

" concealment
set conceallevel=0
let g:tex_conceal='abdgm'

let g:vimtex_env_toggle_math_map = {
            \ '$' : 'align*',
            \ 'align*' : '$',
            \ 'align' : '$',
            \ '$$' : 'align*',
            \ '\[' : 'align*',
            \}

function TEX_ShouldInsertTemplate()
    let l:filename = expand("%:t")
    return index(["main.tex", "sol.tex", "solution.tex"], l:filename) >= 0
endfunction

function TEX_OnNewFile()
    if (TEX_ShouldInsertTemplate())
        " copy everything from template.cpp file
        0:read ~/Templates/template.tex
        " move cursor to a good starting position
        ?\\maketitle
        normal j$
    endif
    write
endfunction

" Wraps a TeX command around a visual selection
function TEX_WrapCommand(command)
    call vimtex#cmd#create(a:command, 1)
endfunction

" Wraps \underbrace around a visual selection
function TEX_WrapUnderbrace()
    call TEX_WrapCommand('underbrace')
    normal f{%a_{}
    startinsert
endfunction

function TEX_Wrap(open, close)
    execute('normal gv"vy')
    execute("normal gvc\<C-r>\<C-r>=a:open\<CR>\<C-r>\<C-r>v\<C-r>\<C-r>=a:close\<CR>")
endfunction

" Wraps a delimiter around a visual selection
function TEX_WrapDelimiter(del_open, del_close)
    call TEX_Wrap('\left' . a:del_open, ' \right' . a:del_close)
endfunction

function! TEX_Init()
    xnoremap <buffer> <leader>bf :call TEX_WrapCommand("textbf")<CR>
    xnoremap <buffer> <leader>it :call TEX_WrapCommand("textit")<CR>
    xnoremap <buffer> <leader>u :call TEX_WrapUnderbrace()<CR>
    xnoremap <buffer> <leader>sb :call TEX_WrapDelimiter('(', ')')<CR>
    xnoremap <buffer> <leader>sB :call TEX_WrapDelimiter('\{', '\}')<CR>
    xnoremap <buffer> <leader>sa :call TEX_WrapDelimiter('<Bar>', '<Bar>')<CR>
    xnoremap <buffer> <leader>sq :call TEX_WrapDelimiter('[', ']')<CR>
    xnoremap <buffer> <leader>sn :call TEX_WrapDelimiter('\<Bar>', '\<Bar>')<CR>
    xnoremap <buffer> <leader>sQ :call TEX_Wrap('<<', '>>')<CR>

    " Integration with inkscape-figures CLI tool
    " silent exec '.!~/.local/bin/inkscape-figures watch'
    inoremap <buffer> <C-f> <Esc>: silent exec '.!~/.local/bin/inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
    nnoremap <buffer> <C-f> : silent exec '!~/.local/bin/inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
endfunction

augroup Latex
    autocmd! 

    autocmd BufNewFile *.tex
                \ call TEX_OnNewFile() |
                \ call TEX_Init()
    autocmd BufRead *.tex
                \ call TEX_Init()

    autocmd FileType tex
                \ autocmd TextChanged,InsertLeave <buffer>
                \ silent update
augroup END
