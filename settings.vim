" General
set hidden                     " buffers are not required to be written during buffer switch
set mouse=a                    " enable mouse support
set clipboard=unnamedplus      " register + is essentially equal to register "
set gdefault                   " %s is by default /g

" Default shell setup
if executable("zsh")
    set shell=/usr/bin/zsh\ -li
elseif executable("bash")
    set shell=/usr/bin/bash\ -li
endif

" path: for use in :find, gf, etc.
set path+=**                   " add all subdirectories of current working directory
"set path+=/usr/include/**      " add all subdirectories of /usr/include/ directory

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
set noignorecase
set smartcase                  " discards ignore case if the search pattern contains upper case characters
setglobal infercase            " convenient case in insert mode completion

" netrw changes windows's working directory
"let g:netrw_keepdir=0
let g:netrw_liststyle=3        " tree-style netrw view
let g:netrw_banner=0           " suppress netrw banner

" :grep uses ack
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

" russian keymap. To switch, use <C-^> in Insert mode
set keymap=russian-jcukenwin
set iminsert=0                 " default is english
set imsearch=0
" xkb-switch
let g:XkbSwitchEnabled = 1
" keymap assistance in normal mode
let g:XkbSwitchAssistNKeymap = 1    " for commands r and f

" Workaround for 
"  SQLComplete: the dbext plugin must be loaded for dynamic SQL completion
" problem
let g:omni_sql_default_compl_type = 'syntax'
