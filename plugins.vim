call plug#begin()

"
" General plugins
" 
Plug 'windwp/nvim-autopairs'     " autocomplete brackets
Plug 'tpope/vim-surround'        " surround text objects
Plug 'tpope/vim-commentary'      " comments
Plug 'SirVer/ultisnips'          " snippets
Plug 'reconquest/vim-pythonx'    " for smarter snippets
Plug 'lyokha/vim-xkbswitch'      " Language switching (xkg-switch)
Plug 'tpope/vim-fugitive'        " Git
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-lua/plenary.nvim'     " dependency for above

" Small misc plugins
Plug 'nelstrom/vim-visual-star-search'
Plug 'lambdalisue/suda.vim'      " sudo write fix
Plug 'joshdick/onedark.vim'      " color theme
Plug 'morhetz/gruvbox'           " color theme

" LSP, linters, formatters support
Plug 'neovim/nvim-lspconfig'    
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'mhartington/formatter.nvim'

" coq_nvim: autocompletion
Plug 'skylerberg/coq_nvim', {'branch': 'preview-enable-setting'}
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




" Coq
Plug 'whonore/Coqtail'

call plug#end()
