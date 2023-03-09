" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

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

" disable quickfix
let g:vimtex_quickfix_mode=0

" fix indentation
let g:vimtex_indent_on_ampersands=0

" concealment
set conceallevel=2
let g:tex_conceal='abdgm'

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

" Expands inline math block to display math (align*)
function TEX_InlineMathToDisplay()
    normal yi$
    let l:content = getreg("0")
    execute(':substitute/\V$\(' . escape(l:content, '\') . '\)$/\r\\begin{align*}\r\1\r\\end{align*}\r')
endfunction

" Expands \begin{align*} ... \end{align*} block to inline math ($...$)
function TEX_DisplayMathToInline()
    normal dae
    let l:content = getreg("+")
    let l:content = substitute(l:content, '\\begin{align\*}', '$', '')
    let l:content = substitute(l:content, '\\end{align\*}$', '$', '')
    call append(line('.'), split(l:content, "\n"))
    normal JJ
endfunction

" Wraps a TeX command around a visual selection
function TEX_WrapCommand(command)
    normal gvSB
    execute('normal i\' . a:command)
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

" let g:tex_synroles = [
"             \'', 
"             \'normal', 
"             \'texArg',         
"             \'texArgNew',      
"             \'texAuthorArg',   
"             \'texAuthorOpt',   
"             \'texBibitemArg',  
"             \'texBibitemOpt',  
"             \'texBoxOptIPosVal', 
"             \'texBoxOptPosVal', 
"             \'texCmd',         
"             \'texCmdAccent',   
"             \'texCmdAuthor',   
"             \'texCmdAxis',     
"             \'texCmdBib',      
"             \'texCmdBibitem',  
"             \'texCmdClass',    
"             \'texCmdConditional', 
"             \'texCmdConditionalINC', 
"             \'texCmdDeclmathoper', 
"             \'texCmdDef',      
"             \'texCmdE3',       
"             \'texCmdEnv',      
"             \'texCmdEnvM',     
"             \'texCmdFootnote', 
"             \'texCmdGeometry', 
"             \'texCmdGreek',    
"             \'texCmdHyperref', 
"             \'texCmdInput',    
"             \'texCmdItem',     
"             \'texCmdLet',      
"             \'texCmdLigature', 
"             \'texCmdLstset',   
"             \'texCmdMath',     
"             \'texCmdMathEnv',  
"             \'texCmdMinipage', 
"             \'texCmdNameref',  
"             \'texCmdNew',      
"             \'texCmdNewcmd',   
"             \'texCmdNewcolumn', 
"             \'texCmdNewcolumnName', 
"             \'texCmdNewenv',   
"             \'texCmdNewthm',   
"             \'texCmdNumberWithin', 
"             \'texCmdOpname',   
"             \'texCmdPackage',  
"             \'texCmdParbox',   
"             \'texCmdPart',     
"             \'texCmdRef',      
"             \'texCmdRefConcealed', 
"             \'texCmdRefEq',    
"             \'texCmdSize',     
"             \'texCmdSpaceCode', 
"             \'texCmdSpaceCodeChar', 
"             \'texCmdStyle',    
"             \'texCmdStyleBold', 
"             \'texCmdStyleBoldItal', 
"             \'texCmdStyleItal', 
"             \'texCmdStyleItalBold', 
"             \'texCmdSubjClass', 
"             \'texCmdTabular',  
"             \'texCmdThmStyle', 
"             \'texCmdTikz',     
"             \'texCmdTikzset',  
"             \'texCmdTitle',    
"             \'texCmdTodo',     
"             \'texCmdType',     
"             \'texCmdVerb',     
"             \'texComment',     
"             \'texCommentAcronym', 
"             \'texCommentConditionals', 
"             \'texCommentFalse', 
"             \'texCommentTodo', 
"             \'texCommentURL',  
"             \'texConditionalArg', 
"             \'texConditionalINCChar', 
"             \'texConditionalNested', 
"             \'texConditionalTrueZone', 
"             \'texDeclmathoperArgBody', 
"             \'texDeclmathoperArgName', 
"             \'texDefArgBody',  
"             \'texDefArgName',  
"             \'texDefParm',     
"             \'texDefParmPre',  
"             \'texDelim',       
"             \'texE3Arg',       
"             \'texE3Cmd',       
"             \'texE3CmdNestedZoneEnd', 
"             \'texE3Constant',  
"             \'texE3Delim',     
"             \'texE3Function',  
"             \'texE3Group',     
"             \'texE3Opt',       
"             \'texE3Parm',      
"             \'texE3Type',      
"             \'texE3Variable',  
"             \'texE3Zone',      
"             \'texEnvArgName',  
"             \'texEnvMArgName', 
"             \'texEnvOpt',      
"             \'texError',       
"             \'texFileArg',     
"             \'texFileOpt',     
"             \'texFilesArg',    
"             \'texFilesOpt',    
"             \'texFootnoteArg', 
"             \'texGeometryArg', 
"             \'texGroup',       
"             \'texGroupError',  
"             \'texHrefArgLink', 
"             \'texHrefArgTextC', 
"             \'texHrefLinkGroup', 
"             \'texLength',      
"             \'texLetArgBody',  
"             \'texLetArgEqual', 
"             \'texLetArgName',  
"             \'texLigature',    
"             \'texLstDelim',    
"             \'texLstEnvBgn',   
"             \'texLstInlineOpt', 
"             \'texLstOpt',      
"             \'texLstZone',     
"             \'texLstZoneInline', 
"             \'texLstsetArg',   
"             \'texMathArg',     
"             \'texMathArrayArg', 
"             \'texMathCmd',     
"             \'texMathCmdEnv',  
"             \'texMathCmdStyle', 
"             \'texMathCmdStyleBold', 
"             \'texMathCmdStyleItal', 
"             \'texMathCmdText', 
"             \'texMathConcealedArg', 
"             \'texMathDelim',   
"             \'texMathDelimMod', 
"             \'texMathDelimZone', 
"             \'texMathDelimZoneLD', 
"             \'texMathDelimZoneLI', 
"             \'texMathDelimZoneTD', 
"             \'texMathDelimZoneTI', 
"             \'texMathEnvArgName', 
"             \'texMathEnvBgnEnd', 
"             \'texMathError',   
"             \'texMathErrorDelim', 
"             \'texMathGroup',   
"             \'texMathOper',    
"             \'texMathStyleBold', 
"             \'texMathStyleConcArg', 
"             \'texMathStyleItal', 
"             \'texMathSub',     
"             \'texMathSuper',   
"             \'texMathSuperSub', 
"             \'texMathSymbol',  
"             \'texMathTagArg',  
"             \'texMathTextAfter', 
"             \'texMathTextArg', 
"             \'texMathTextConcArg', 
"             \'texMathToolsOptPos1', 
"             \'texMathToolsOptPos2', 
"             \'texMathToolsOptWidth', 
"             \'texMathZone',    
"             \'texMathZoneEnsured', 
"             \'texMathZoneEnv', 
"             \'texMathZoneEnvStarred', 
"             \'texMathZoneLD',  
"             \'texMathZoneLI',  
"             \'texMathZoneTD',  
"             \'texMathZoneTI',  
"             \'texMinipageArgWidth', 
"             \'texMinipageOptHeight', 
"             \'texMinipageOptIPos', 
"             \'texMinipageOptPos', 
"             \'texNewcmdArgBody', 
"             \'texNewcmdArgName', 
"             \'texNewcmdOpt',   
"             \'texNewcmdParm',  
"             \'texNewcolumnArg', 
"             \'texNewcolumnArgName', 
"             \'texNewcolumnOpt', 
"             \'texNewcolumnParm', 
"             \'texNewenvArgBegin', 
"             \'texNewenvArgEnd', 
"             \'texNewenvArgName', 
"             \'texNewenvOpt',   
"             \'texNewenvParm',  
"             \'texNewthmArgName', 
"             \'texNewthmArgPrinted', 
"             \'texNewthmOptCounter', 
"             \'texNewthmOptNumberby', 
"             \'texNumberWithinArg1', 
"             \'texNumberWithinArg2', 
"             \'texOpnameArg',   
"             \'texOpt',         
"             \'texOptEqual',    
"             \'texOptSep',      
"             \'texParboxArgContent', 
"             \'texParboxArgWidth', 
"             \'texParboxOptHeight', 
"             \'texParboxOptIPos', 
"             \'texParboxOptPos', 
"             \'texParm',        
"             \'texPartArgTitle', 
"             \'texPartConcArgTitle', 
"             \'texPartConcealed', 
"             \'texPgfAddplotOpt', 
"             \'texPgfCoordinates', 
"             \'texPgfFunc',     
"             \'texPgfGnuplotArg', 
"             \'texPgfNode',     
"             \'texPgfTableArg', 
"             \'texPgfTableOpt', 
"             \'texPgfType',     
"             \'texProofEnvBgn', 
"             \'texProofEnvOpt', 
"             \'texRefArg',      
"             \'texRefConcealedArg', 
"             \'texRefConcealedDelim', 
"             \'texRefConcealedOpt1', 
"             \'texRefConcealedOpt2', 
"             \'texRefEqConcealedArg', 
"             \'texRefEqConcealedDelim', 
"             \'texRefOpt',      
"             \'texSpecialChar', 
"             \'texStyleArgConc', 
"             \'texStyleBold',   
"             \'texStyleBoldItalUnder', 
"             \'texStyleBoldUnder', 
"             \'texStyleBoth',   
"             \'texStyleItal',   
"             \'texStyleItalUnder', 
"             \'texStyleUnder',  
"             \'texSubjClassArg', 
"             \'texSubjClassOpt', 
"             \'texSymbol',      
"             \'texSynIgnoreZone', 
"             \'texTabularArg',  
"             \'texTabularAtSep', 
"             \'texTabularChar', 
"             \'texTabularCmd',  
"             \'texTabularCmdArg', 
"             \'texTabularCmdOpt', 
"             \'texTabularCol',  
"             \'texTabularLength', 
"             \'texTabularMathdelim', 
"             \'texTabularMulti', 
"             \'texTabularOpt',  
"             \'texTabularPostPre', 
"             \'texTabularPostPreArg', 
"             \'texTabularVertline', 
"             \'texTheoremEnvBgn', 
"             \'texTheoremEnvOpt', 
"             \'texThmStyleArg', 
"             \'texTikzCycle',   
"             \'texTikzDraw',    
"             \'texTikzEnvBgn',  
"             \'texTikzNodeOpt', 
"             \'texTikzOpt',     
"             \'texTikzSemicolon', 
"             \'texTikzZone',    
"             \'texTikzsetArg',  
"             \'texTitleArg',    
"             \'texTypeSize',    
"             \'texUrlArg',      
"             \'texVerbZone',    
"             \'texVerbZoneInline', 
"             \'texZone',        
"             \]
let g:tex_default_layout = 'us'

function! TEX_Init()
    call TEX_CheckXkbSwitchLib()

    " by default every syntax id maps to 'us'
    let b:saved_cur_layout = {}
    " but some of them map to 'ru'
    let b:saved_cur_layout[""] = 'ru'
    let b:saved_cur_layout["texTitleArg"] = 'ru'
    let b:saved_cur_layout["texAuthorArg"] = 'ru'
    let b:saved_cur_layout["texMathTextConcArg"] = 'ru'
    let b:saved_cur_layout["texPartArgTitle"] = 'ru'
    let b:saved_cur_layout["texStyleBoth"] = 'ru'
    let b:saved_cur_layout["texStyleItal"] = 'ru'
    let b:saved_cur_layout["texStyleBold"] = 'ru'
    let b:saved_cur_layout["texTheoremEnvOpt"] = 'ru'
    let b:saved_cur_layout["texStyleArgConc"] = 'ru'

    let b:mathzone_driven_zones = {}
    let b:mathzone_driven_zones['texDelim'] = 1

    nnoremap <buffer> <leader>i2d :call TEX_InlineMathToDisplay()<CR>
    nnoremap <buffer> <leader>d2i :call TEX_DisplayMathToInline()<CR>
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

function! TEX_CheckXkbSwitchLib() abort
    if !filereadable(g:XkbSwitchLib)
        throw "Couldn't find XkbSwitch library!"
    endif
endfunction

function! TEX_GetXkbLayout() abort
    return libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
endfunction

function! TEX_SetXkbLayout(lang) abort
    call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', a:lang)
endfunction

function! TEX_GetCurSynIdName() abort
    let l:col = col(".")
    if l:col > 0
        let l:col = l:col - 1
    endif
    return synIDattr(synID(line("."), l:col, 1), "name")
endfunction

function! TEX_SwitchLangOnIEnter() abort
    let l:cur_synid  = TEX_GetCurSynIdName()

    if !exists('b:saved_cur_layout[cur_synid]')
        let b:saved_cur_layout[l:cur_synid] = g:tex_default_layout
    endif

    call TEX_SetXkbLayout(b:saved_cur_layout[l:cur_synid])
    let b:saved_cur_synid = l:cur_synid
endfunction

function! TEX_SaveLang() abort
    let b:saved_cur_layout[b:saved_cur_synid] = TEX_GetXkbLayout()
endfunction

function! TEX_SaveLangOnILeave() abort
    call TEX_SaveLang()
    unlet b:saved_cur_synid
endfunction

function! TEX_SwitchLangOnSynIdChange() abort
    call TEX_SaveLang()

    let l:cur_synid  = TEX_GetCurSynIdName()
    if l:cur_synid == b:saved_cur_synid
        return
    endif

    if exists('b:mathzone_driven_zones[l:cur_synid]')
        let l:new_layout = 'en'
        if !vimtex#syntax#in_mathzone() && !vimtex#syntax#in('texRefArg') && !vimtex#syntax#in('texArg') && !vimtex#syntax#in('texStyleArgConc')
            let l:new_layout = 'ru'
        endif
        call TEX_SetXkbLayout(l:new_layout)
        let b:saved_cur_synid = l:cur_synid
        return
    endif

    if !exists('b:saved_cur_layout[l:cur_synid]')
        let b:saved_cur_layout[l:cur_synid] = g:tex_default_layout
    endif
    call TEX_SetXkbLayout(b:saved_cur_layout[l:cur_synid])
    let b:saved_cur_synid = l:cur_synid
endfunction

let g:XkbSwitchPostIEnterAuto = [
            \ [{'ft': 'tex', 'cmd': 'call TEX_SwitchLangOnIEnter()'}, 1] ]

augroup Latex
    autocmd! 

    autocmd BufNewFile *.tex
                \ call TEX_OnNewFile() |
                \ call TEX_Init()
    autocmd BufRead *.tex
                \ call TEX_Init()

    autocmd Filetype tex
                \ autocmd FocusLost,TextChanged,InsertLeave <buffer> update

    autocmd Filetype tex
                \ autocmd CursorMovedI,TextChangedI <buffer> call TEX_SwitchLangOnSynIdChange()
    " autocmd Filetype tex
    "             \ autocmd InsertLeave <buffer> call TEX_SaveLangOnILeave()
augroup END
