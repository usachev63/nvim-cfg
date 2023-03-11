" Get directory of current buffer (smart)
function GetCurFileDir()
    if &filetype ==# "netrw" && exists("b:netrw_curdir")
        return b:netrw_curdir
    endif
    if &buftype ==# "terminal" && exists("b:term_title")
        " We extact current directory from terminal title (b:term_title variable)
        return get(split(b:term_title, ':'), 1, '')
    endif
    return expand("%:p:h") . "/"
endfunction

function TabChangeDirToCurFileDir()
    execute "tchdir " . GetCurFileDir()
endfunction

function LocalChangeDirToCurFileDir()
    execute "lchdir " . GetCurFileDir()
endfunction

function TabEditChangeDir(file)
    execute "tabedit " . a:file
    call TabChangeDirToCurFileDir()
endfunction

function EditChangeDir(file)
    execute "edit " . a:file
    call TabChangeDirToCurFileDir()
endfunction

" "%%" expands to current file dir
cnoremap <expr> %% getcmdtype() == ':' ? GetCurFileDir() : '%%'

command -nargs=0 TChangeDir call TabChangeDirToCurFileDir()
command -nargs=0 LChangeDir call LocalChangeDirToCurFileDir()
command -nargs=1 -complete=file TEditChangeDir call TabEditChangeDir(<q-args>)
command -nargs=1 -complete=file EChangeDir call EditChangeDir(<q-args>)
