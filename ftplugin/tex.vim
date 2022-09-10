setlocal spelllang=en,ru
setlocal spell

setlocal softtabstop=1
setlocal shiftwidth=1

function! TEX_ReturnBackSlash(calculation)
    return '\'
endfunction

inoremap <buffer> <expr> \ TEX_ReturnBackSlash(TEX_SetLangForce('us'))
