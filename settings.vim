" General
set hidden                     " buffers are not required to be written during buffer switch
set mouse=a                    " enable mouse support
set clipboard=unnamedplus      " register + is essentially equal to register "
set gdefault                   " %s is by default /g

" path: for use in :find, gf, etc.
set path+=**                   " add all subdirectories of current working directory

" Appearance
set number                     " line numbers
set nohlsearch                 " don't highlight search
set listchars=tab:..,nbsp:+
set list
set splitright                 " vsplit splits the window to the right
set termguicolors              " better colors
let g:gruvbox_italic=1
colorscheme gruvbox
set linebreak
highlight NonText guifg=bg

" Indentation
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" File type
filetype plugin indent on      " auto-indenting depending on file type
filetype plugin on

" zsh-like auto-completion in ex-mode
set wildmenu
set wildmode=full

" Search options
set ignorecase
set smartcase                  " discards ignore case if the search pattern contains upper case characters
setglobal infercase            " convenient case in insert mode completion

" netrw changes windows's working directory
"let g:netrw_keepdir=0
let g:netrw_liststyle=0        " tree-style netrw view
let g:netrw_banner=0           " suppress netrw banner

" :grep uses ack
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" Workaround for 
"  SQLComplete: the dbext plugin must be loaded for dynamic SQL completion
" problem
let g:omni_sql_default_compl_type = 'syntax'

let g:python3_host_prog = '/usr/bin/python3'
