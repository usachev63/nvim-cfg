" General
set hidden                     " buffers are not required to be written during buffer switch
set mouse=a                    " enable mouse support
set clipboard=unnamedplus      " register + is essentially equal to register "
set gdefault                   " %s is by default /g

" path: for use in :find, gf, etc.
set path+=**                   " add all subdirectories of current working directory

" zsh-like auto-completion in ex-mode
set wildmenu
set wildmode=full

" Search options
set ignorecase
set smartcase                  " discards ignore case if the search pattern contains upper case characters
setglobal infercase            " convenient case in insert mode completion

" :grep uses ack
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" Workaround for 
"  SQLComplete: the dbext plugin must be loaded for dynamic SQL completion
" problem
let g:omni_sql_default_compl_type = 'syntax'

let g:python3_host_prog = '/usr/bin/python3'
