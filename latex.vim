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
set conceallevel=2
let g:tex_conceal='abdmg'


function TEX_OnNewFile()
    " copy everything from template.cpp file
    % !cat ~/Templates/template.tex 
    " move cursor to a good starting position
    ?\\newpage
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

function! TEX_SetLangForce(lang)
    if !filereadable(g:XkbSwitchLib)
        return
    endif

    call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', a:lang)
endfunction

function! TEX_SwitchLang()
    if !filereadable(g:XkbSwitchLib)
        return
    endif

    let cur_synid  = synIDattr(synID(line("."), col(".") - 1, 1), "name")
    let cur_layout = libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')

    if !exists('b:saved_cur_layout')
        let b:saved_cur_layout = {}
    endif

    if !exists('b:saved_cur_layout[cur_synid]')
        let b:saved_cur_layout[cur_synid] = g:tex_default_layout
    endif
    let b:xkb_ilayout = b:saved_cur_layout[cur_synid]
endfunction

fun! TEX_SaveLang()
    if !filereadable(g:XkbSwitchLib)
        return
    endif

    let cur_synid  = synIDattr(synID(line("."), col(".") - 1, 1), "name")
    let cur_layout = libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')

    let b:saved_cur_layout[b:saved_cur_synid] = cur_layout
endfun

fun! TEX_CheckLang()
    if !filereadable(g:XkbSwitchLib)
        return
    endif

    let cur_synid  = synIDattr(synID(line("."), col(".") - 1, 1), "name")
    let cur_layout = libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')

    if !exists('b:saved_cur_synid')
        let b:saved_cur_synid = cur_synid
    endif
    if !exists('b:saved_cur_layout')
        let b:saved_cur_layout = {}
    endif

    if cur_synid == b:saved_cur_synid
        return
    endif

    let b:saved_cur_layout[b:saved_cur_synid] = cur_layout
    if !exists('b:saved_cur_layout[cur_synid]')
        let b:saved_cur_layout[cur_synid] = g:tex_default_layout
    endif
    call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout',
                \ b:saved_cur_layout[cur_synid])
    let b:saved_cur_synid = cur_synid
endfun

let g:XkbSwitchPostIEnterAuto = [
            \ [{'ft': 'tex', 'cmd': 'call TEX_SwitchLang()'}, 0] ]

augroup Latex
    autocmd! 

    autocmd BufNewFile * if &ft ==# 'tex'| call TEX_OnNewFile()|endif

    autocmd FocusLost,TextChanged,InsertLeave * if &ft ==# 'tex'| update|endif

    autocmd CursorMovedI * if &ft ==# 'tex'| call TEX_CheckLang()|endif
    autocmd InsertLeave * if $ft ==# 'tex' | call TEX_SaveLang()|endif
augroup END
