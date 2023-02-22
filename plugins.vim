call plug#begin()

"
" General plugins
" 
Plug 'jiangmiao/auto-pairs'      " autocomplete brackets
Plug 'tpope/vim-surround'        " surround text objects
Plug 'tpope/vim-commentary'      " comments
Plug 'SirVer/ultisnips'          " snippets
Plug 'reconquest/vim-pythonx'    " for smarter snippets
Plug 'lyokha/vim-xkbswitch'      " Language switching (xkg-switch)
Plug 'tpope/vim-fugitive'        " Git

" Small misc plugins
Plug 'nelstrom/vim-visual-star-search'
Plug 'lambdalisue/suda.vim'      " sudo write fix
Plug 'joshdick/onedark.vim'      " color theme
Plug 'morhetz/gruvbox'           " color theme

" LSP, linters, formatters support
Plug 'neovim/nvim-lspconfig'    
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-lua/plenary.nvim'     " dependecy for above

" coq_nvim: autocompletion
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

"
" TeX
"
Plug 'lervag/vimtex'




"
" Markdown
" 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}




" Rust
Plug 'rust-lang/rust.vim'

call plug#end()
