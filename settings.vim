" General
set hidden                     " buffers are not required to be written during buffer switch
set clipboard=unnamedplus      " using system clipboard (registers "" and "+ are the same)
set mouse=a                    " enable mouse support
set shell=/usr/bin/zsh\ -li    " default shell

" path: for use in :find, gf, etc.
set path+=**                   " add all subdirectories of current working directory
"set path+=/usr/include/**      " add all subdirectories of /usr/include/ directory

" Appearance
set number                     " line numbers
set nohlsearch                 " don't highlight search
set listchars=tab:..,trail:-,nbsp:+
set list
set splitright                 " vsplit splits the window to the right

" Indentation
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" File type
filetype plugin indent on      " autoidenting depending on file type
filetype plugin on

" zsh-like autocompletion in ex-mode
set wildmenu
set wildmode=full

" Search options
set ignorecase
set smartcase                  " discards ignore case if the search pattern contains upper case characters

" :grep uses ack
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m
