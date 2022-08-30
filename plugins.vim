call plug#begin()

"
" General plugins
" 
Plug 'jiangmiao/auto-pairs'     " autocomplete brackets
Plug 'tpope/vim-surround'       " surround text objects
Plug 'tpope/vim-commentary'     " comments
Plug 'SirVer/ultisnips'         " snippets
Plug 'reconquest/vim-pythonx'   " for smarter snippets
Plug 'lyokha/vim-xkbswitch'     " Language switching (xkg-switch)
Plug 'ycm-core/YouCompleteMe'

" Small misc plugins
Plug 'nelstrom/vim-visual-star-search'
Plug 'lambdalisue/suda.vim'     " sudo write fix
Plug 'joshdick/onedark.vim'     " color theme
Plug 'morhetz/gruvbox'          " color theme

" LSP (Language Server Protocol) support
Plug 'neovim/nvim-lspconfig'    
Plug 'williamboman/nvim-lsp-installer'




" TeX "
Plug 'lervag/vimtex'            




" Markdown "
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}




" C/C++ (projects)

" clang-format support
Plug 'rhysd/vim-clang-format'   " clang-format support
Plug 'kana/vim-operator-user'   " dependency for above
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " dependency for above



" Rust
Plug 'rust-lang/rust.vim'

call plug#end()
