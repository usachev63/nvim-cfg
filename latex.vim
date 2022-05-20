" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
"let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

" disable quickfix
let g:vimtex_quickfix_mode=0

" concealment
set conceallevel=1
let g:tex_conceal='abdmg'


function TEX_OnNewFile()
    " copy everything from template.cpp file
    % !cat ~/Templates/template.tex 
    " move cursor to a good starting position
    ?\\newpage
endfunction

let g:XkbSwitchSyntaxRules = [ {'ft': 'tex', 'in': ['normal', 'texZone', 'texMathZone', 'texMathZoneX', 'texMathZoneXX', '', 'texMathZoneEnv', 'texMathDelimZone',  'texMathTextAfter', 'texMathDelim', 'texEnvArgName', 'texCmdGreek', 'texTabularChar', 'texMathOper', 'texDelim', 'texComment']} ]

augroup Latex
    autocmd! 

    autocmd BufNewFile * if &ft ==# 'tex'| call TEX_OnNewFile()|endif

    autocmd FocusLost,TextChanged,InsertLeave * if &ft ==# 'tex'| update|endif
augroup END
