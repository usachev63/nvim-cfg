function GetCurFileDir()
    if exists("b:netrw_curdir")
        return b:netrw_curdir
    endif
    return expand("%:p:h") . "/"
endfunction

function TabChangeDirToCurFileDir()
    execute "tchdir " . GetCurFileDir()
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
command -nargs=1 -complete=file TEditChangeDir call TabEditChangeDir(<q-args>)
command -nargs=1 -complete=file EChangeDir call EditChangeDir(<q-args>)
